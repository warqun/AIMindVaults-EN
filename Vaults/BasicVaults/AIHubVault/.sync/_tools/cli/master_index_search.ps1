<#
.SYNOPSIS
    크로스볼트 마스터 인덱스 검색
.DESCRIPTION
    master_index.json에서 키워드, 태그, 볼트별 노트를 검색한다.
    인덱스가 없으면 자동으로 전체 빌드를 실행한다.
.PARAMETER Query
    키워드 검색 (title, tags에 매칭)
.PARAMETER Tag
    태그 필터
.PARAMETER Vault
    특정 볼트만 검색
.PARAMETER Format
    출력 형식: table (기본), compact (AI 컨텍스트용)
.PARAMETER Top
    상위 N건 (기본 15)
.PARAMETER ConceptsOnly
    크로스볼트 개념 맵만 출력 (2개 이상 볼트에 걸친 태그)
.EXAMPLE
    .\master_index_search.ps1 -Query "ECS"
    .\master_index_search.ps1 -Tag "Unity"
    .\master_index_search.ps1 -ConceptsOnly
    .\master_index_search.ps1 -Query "색채" -Format compact -Top 5
#>

param(
    [string]$Query,
    [string]$Tag,
    [string]$Vault,
    [string]$Format = "table",
    [int]$Top = 15,
    [switch]$ConceptsOnly
)

$ErrorActionPreference = "Continue"

# ── 루트 자동탐지 ──
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$AIMindVaultsRoot = ""
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
if (-not $AIMindVaultsRoot) {
    Write-Host "[ERROR] AIMindVaults root not found"
    exit 1
}

$MasterIndexPath = Join-Path $AIMindVaultsRoot ".vault_data\master_index.json"

# ── 인덱스 없으면 자동 빌드 ──
if (-not (Test-Path $MasterIndexPath)) {
    Write-Host "[INFO] Master index not found, building..."
    $builderPath = Join-Path $ScriptDir "master_index_build.ps1"
    if (Test-Path $builderPath) {
        $powershellExe = (Get-Process -Id $PID).Path
        & $powershellExe -ExecutionPolicy Bypass -File $builderPath -AIMindVaultsRoot $AIMindVaultsRoot
    } else {
        Write-Host "[ERROR] master_index_build.ps1 not found: $builderPath"
        exit 1
    }
}

if (-not (Test-Path $MasterIndexPath)) {
    Write-Host "[ERROR] Master index still not found after build attempt"
    exit 1
}

# ── 인덱스 로드 ──
try {
    $utf8 = New-Object System.Text.UTF8Encoding($false)
    $raw = [System.IO.File]::ReadAllText($MasterIndexPath, $utf8)
    $master = $raw | ConvertFrom-Json
}
catch {
    Write-Host "[ERROR] Failed to load master index: $_"
    exit 1
}

# ── ConceptsOnly 모드 ──
if ($ConceptsOnly) {
    if (-not $master.concept_map) {
        Write-Host "No cross-vault concepts found."
        exit 0
    }
    $concepts = $master.concept_map.PSObject.Properties |
        Sort-Object { $_.Value.count } -Descending |
        Select-Object -First $Top

    Write-Host "=== Cross-Vault Concepts (${Top} max) ==="
    Write-Host ""
    foreach ($c in $concepts) {
        $vaults = $c.Value.vaults -join ", "
        Write-Host "[$($c.Value.count)] $($c.Name) -> $vaults"
    }
    exit 0
}

# ── 검색 ──
$results = @($master.notes)

# 볼트 필터
if ($Vault) {
    $results = @($results | Where-Object { $_.vault_id -eq $Vault })
}

# 태그 필터
if ($Tag) {
    $results = @($results | Where-Object { $_.tags -contains $Tag })
}

# 키워드 검색 (title + tags 매칭, 가중 스코어링)
if ($Query) {
    $queryLower = $Query.ToLower()
    $queryTerms = $queryLower -split '\s+'
    $scored = @()

    foreach ($note in $results) {
        $score = 0
        $titleLower = $note.title.ToLower()
        $tagString = ($note.tags -join " ").ToLower()

        foreach ($term in $queryTerms) {
            # title 매칭 (가중치 높음)
            if ($titleLower -like "*$term*") { $score += 10 }
            # tag 매칭
            if ($tagString -like "*$term*") { $score += 5 }
        }

        if ($score -gt 0) {
            $scored += [pscustomobject]@{
                note  = $note
                score = $score
            }
        }
    }

    $results = @($scored | Sort-Object -Property score -Descending | Select-Object -First $Top | ForEach-Object { $_.note })
} else {
    $results = @($results | Select-Object -First $Top)
}

# ── 결과 출력 ──
if ($results.Count -eq 0) {
    Write-Host "No results found."
    exit 0
}

# 볼트별 집계 헤더
$vaultSummary = $results | Group-Object vault_id | Sort-Object Count -Descending |
    ForEach-Object { "$($_.Name):$($_.Count)" }
Write-Host "=== $($results.Count) results across [$($vaultSummary -join ', ')] ==="
Write-Host ""

if ($Format -eq "compact") {
    foreach ($note in $results) {
        $tagStr = ($note.tags | Select-Object -First 3) -join ","
        Write-Host "[$($note.vault_id)] $($note.title) | $($note.type) | tags:$tagStr"
    }
} else {
    foreach ($note in $results) {
        $tagStr = ($note.tags | Select-Object -First 5) -join ", "
        Write-Host "[$($note.vault_id)] $($note.title)"
        Write-Host "  type: $($note.type) | tags: $tagStr"
        Write-Host "  path: $($note.path)"
        Write-Host ""
    }
}
