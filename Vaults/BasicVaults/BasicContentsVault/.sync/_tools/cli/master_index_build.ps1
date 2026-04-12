<#
.SYNOPSIS
    크로스볼트 마스터 인덱스 빌드 — 전체 볼트의 vault_index.json을 집계
.DESCRIPTION
    각 볼트의 .vault_data/vault_index.json을 읽어서 하나의 master_index.json으로 합친다.
    -VaultName 지정 시 해당 볼트분만 부분 갱신 (개별 인덱스 빌드 후 자동 호출용).
.PARAMETER AIMindVaultsRoot
    AIMindVaults 루트 경로. 생략 시 스크립트 위치에서 자동 탐지.
.PARAMETER VaultName
    부분 갱신 대상 볼트명. 생략 시 전체 빌드.
.EXAMPLE
    .\master_index_build.ps1
    .\master_index_build.ps1 -VaultName "Unity"
#>

param(
    [string]$AIMindVaultsRoot,
    [string]$VaultName
)

$ErrorActionPreference = "Continue"
$startTime = Get-Date

# ── 루트 자동탐지 ──
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
if (-not $AIMindVaultsRoot) {
    $candidate = $ScriptDir
    for ($i = 0; $i -lt 10; $i++) {
        $parent = Split-Path -Parent $candidate
        if (-not $parent -or $parent -eq $candidate) { break }
        if (Test-Path (Join-Path $parent "Vaults")) {
            $AIMindVaultsRoot = $parent
            break
        }
        $candidate = $parent
    }
}
if (-not $AIMindVaultsRoot) {
    Write-Host "[ERROR] AIMindVaults root not found"
    exit 1
}
$AIMindVaultsRoot = (Resolve-Path $AIMindVaultsRoot).Path

$MasterDataDir = Join-Path $AIMindVaultsRoot ".vault_data"
$MasterIndexPath = Join-Path $MasterDataDir "master_index.json"
$VaultsDir = Join-Path $AIMindVaultsRoot "Vaults"

if (-not (Test-Path $MasterDataDir)) {
    New-Item -ItemType Directory -Path $MasterDataDir -Force | Out-Null
}

# ── 기존 마스터 인덱스 로드 (부분 갱신용) ──
$masterVaults = @{}
$masterNotes = @()
$masterTagIndex = @{}

if ($VaultName -and (Test-Path $MasterIndexPath)) {
    try {
        $utf8 = New-Object System.Text.UTF8Encoding($false)
        $raw = [System.IO.File]::ReadAllText($MasterIndexPath, $utf8)
        $existing = $raw | ConvertFrom-Json

        foreach ($v in $existing.vaults.PSObject.Properties) {
            $masterVaults[$v.Name] = $v.Value
        }
        foreach ($n in $existing.notes) {
            if ($n.vault_id -ne $VaultName) {
                $masterNotes += $n
            }
        }
        if ($existing.tag_index) {
            foreach ($t in $existing.tag_index.PSObject.Properties) {
                $masterTagIndex[$t.Name] = @($t.Value | Where-Object { $_ -notlike "${VaultName}:*" })
            }
        }
    }
    catch {
        Write-Host "[WARN] Failed to load existing master index, doing full build"
        $VaultName = ""
        $masterVaults = @{}
        $masterNotes = @()
        $masterTagIndex = @{}
    }
}

# ── 볼트 인덱스 수집 ──
$vaultDirs = Get-ChildItem -Path $VaultsDir -Directory -Recurse -Depth 2 |
    Where-Object { Test-Path (Join-Path $_.FullName ".vault_data\vault_index.json") }

$processedCount = 0
$totalNotes = 0

foreach ($vDir in $vaultDirs) {
    $vName = $vDir.Name
    $indexFile = Join-Path $vDir.FullName ".vault_data\vault_index.json"

    # 부분 갱신 모드: 지정된 볼트만 처리
    if ($VaultName -and $vName -ne $VaultName) { continue }

    try {
        $utf8 = New-Object System.Text.UTF8Encoding($false)
        $raw = [System.IO.File]::ReadAllText($indexFile, $utf8)
        $vIndex = $raw | ConvertFrom-Json
    }
    catch {
        Write-Host "[WARN] Failed to read: $indexFile"
        continue
    }

    # vault 필드 정합성 확인
    if ($vIndex.vault -ne $vName) {
        Write-Host "[WARN] vault mismatch: $vName has vault=$($vIndex.vault) — skipping"
        continue
    }

    # 볼트 메타데이터
    $vaultTags = @()
    if ($vIndex.tag_index) {
        $vaultTags = @($vIndex.tag_index.PSObject.Properties.Name)
    }
    $masterVaults[$vName] = [pscustomobject]@{
        path       = $vDir.FullName.Substring($AIMindVaultsRoot.Length + 1) -replace '\\', '/'
        note_count = $vIndex.notes.Count
        domain_tags = $vaultTags
        built      = $vIndex.built
    }

    # 노트 집계 (경량화: title, tags, type, vault_id만)
    foreach ($note in $vIndex.notes) {
        $masterNotes += [pscustomobject]@{
            vault_id = $vName
            title    = $note.title
            path     = $note.path
            type     = $note.type
            tags     = @($note.tags)
        }
    }

    # 태그 인덱스 집계
    if ($vIndex.tag_index) {
        foreach ($tp in $vIndex.tag_index.PSObject.Properties) {
            $tagName = $tp.Name
            if (-not $masterTagIndex.ContainsKey($tagName)) {
                $masterTagIndex[$tagName] = @()
            }
            foreach ($notePath in $tp.Value) {
                $masterTagIndex[$tagName] += "${vName}:${notePath}"
            }
        }
    }

    $processedCount++
    $totalNotes += $vIndex.notes.Count
}

# ── concept_map 생성 (태그 기반 크로스볼트 매핑) ──
$conceptMap = @{}
foreach ($tp in $masterTagIndex.GetEnumerator()) {
    $tagName = $tp.Key
    $entries = $tp.Value
    $vaultIds = @($entries | ForEach-Object { ($_ -split ':')[0] } | Sort-Object -Unique)
    if ($vaultIds.Count -ge 2) {
        $conceptMap[$tagName] = [pscustomobject]@{
            vaults = $vaultIds
            count  = $entries.Count
        }
    }
}

# ── 인덱스 저장 ──
$masterIndex = [pscustomobject]@{
    built       = (Get-Date).ToString("yyyy-MM-ddTHH:mm:ss")
    vault_count = $masterVaults.Count
    note_count  = $masterNotes.Count
    vaults      = $masterVaults
    notes       = $masterNotes
    tag_index   = $masterTagIndex
    concept_map = $conceptMap
}

$json = $masterIndex | ConvertTo-Json -Depth 6
$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
[System.IO.File]::WriteAllText($MasterIndexPath, $json, $utf8NoBom)

# ── 결과 출력 ──
$elapsed = ((Get-Date) - $startTime).TotalSeconds
$mode = if ($VaultName) { "PARTIAL ($VaultName)" } else { "FULL" }
Write-Host ""
Write-Host "======================================"
Write-Host " Master Index Build Complete"
Write-Host "======================================"
Write-Host " Mode     : $mode"
Write-Host " Vaults   : $($masterVaults.Count)"
Write-Host " Notes    : $($masterNotes.Count)"
Write-Host " Tags     : $($masterTagIndex.Count)"
Write-Host " Concepts : $($conceptMap.Count) (cross-vault)"
Write-Host " Time     : $([math]::Round($elapsed, 2))s"
Write-Host " Output   : $MasterIndexPath"
Write-Host "======================================"
