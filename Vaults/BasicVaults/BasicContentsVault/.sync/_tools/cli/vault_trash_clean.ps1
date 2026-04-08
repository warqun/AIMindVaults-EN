#Requires -Version 5.1
<#
.SYNOPSIS
    볼트 .trash/ 폴더 일괄 정리
.DESCRIPTION
    지정 볼트 또는 전체 볼트의 Obsidian 휴지통(.trash/)을 비운다.
    Vaults/ 하위를 재귀 탐색하여 .trash/ 폴더를 찾고 삭제한다.
.PARAMETER Vault
    대상 볼트명. 쉼표 구분으로 복수 지정 가능. 생략 시 전체 볼트.
.PARAMETER DryRun
    실제 삭제 없이 대상 목록과 크기만 출력.
.PARAMETER VaultsRoot
    Vaults 폴더 경로. 미지정 시 스크립트 위치에서 자동 탐지.
.EXAMPLE
    .\vault_trash_clean.ps1
    .\vault_trash_clean.ps1 -Vault Unity
    .\vault_trash_clean.ps1 -Vault Unity,AI,Search -DryRun
#>
param(
    [string[]]$Vault = @(),
    [switch]$DryRun,
    [string]$VaultsRoot = ""
)

$ErrorActionPreference = "Stop"

# ── 경로 자동탐지 ──
# NOTE: .sync\_tools\cli\ 기준 3단계(..\..\..),  레거시 _tools\cli\ 기준 2단계(..\..),
#       순서대로 시도하며 Vaults/ 폴더 존재로 멀티볼트 루트를 검증한다.
if (-not $VaultsRoot) {
    $ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
    $rootCandidates = @(
        (Join-Path $ScriptDir "..\..\.."),
        (Join-Path $ScriptDir "..\..")
    )
    $multiVaultRoot = $null
    foreach ($candidate in $rootCandidates) {
        if (-not (Test-Path $candidate)) { continue }
        $resolved = (Resolve-Path $candidate).Path
        # 볼트 루트에서 Vaults/ 가 있는 멀티볼트 루트까지 탐색
        $current = $resolved
        for ($i = 0; $i -lt 4; $i++) {
            if (Test-Path (Join-Path $current "Vaults")) {
                $multiVaultRoot = $current
                break
            }
            $parent = Split-Path -Parent $current
            if (-not $parent -or $parent -eq $current) { break }
            $current = $parent
        }
        if ($multiVaultRoot) { break }
    }
    if (-not $multiVaultRoot) {
        Write-Error "Vaults/ 폴더를 찾을 수 없습니다. -VaultsRoot를 지정하세요."
        exit 1
    }
    $VaultsRoot = Join-Path $multiVaultRoot "Vaults"
}

if (-not (Test-Path $VaultsRoot)) {
    Write-Error "Vaults 경로가 존재하지 않습니다: $VaultsRoot"
    exit 1
}

# ── .trash/ 폴더 수집 ──
$trashDirs = Get-ChildItem -Path $VaultsRoot -Recurse -Directory -Filter ".trash" -Force -ErrorAction SilentlyContinue

# 볼트명 필터 적용
if ($Vault.Count -gt 0) {
    $trashDirs = $trashDirs | Where-Object {
        $trashPath = $_.FullName
        $matched = $false
        foreach ($v in $Vault) {
            if ($trashPath -match "[/\\]$([regex]::Escape($v))[/\\]") {
                $matched = $true
                break
            }
        }
        $matched
    }
}

if ($trashDirs.Count -eq 0) {
    Write-Host "비울 .trash/ 폴더가 없습니다." -ForegroundColor Green
    exit 0
}

# ── 결과 출력 ──
$totalFiles = 0
$totalSize = 0

Write-Host ""
Write-Host "=== Vault Trash Clean ===" -ForegroundColor Cyan
Write-Host ""

foreach ($trash in $trashDirs) {
    $files = Get-ChildItem -Path $trash.FullName -Recurse -File -Force -ErrorAction SilentlyContinue
    $fileCount = ($files | Measure-Object).Count
    $size = ($files | Measure-Object -Property Length -Sum).Sum
    if (-not $size) { $size = 0 }
    $sizeKB = [math]::Round($size / 1024, 1)

    # 볼트명 추출 (Vaults/ 이후 경로에서)
    $relativePath = $trash.FullName.Substring($VaultsRoot.Length).TrimStart('\', '/')
    $vaultName = ($relativePath -split '[/\\]' | Where-Object { $_ -and $_ -ne '.trash' }) -join '/'

    $totalFiles += $fileCount
    $totalSize += $size

    if ($DryRun) {
        Write-Host "  [DRY] $vaultName — $fileCount files, ${sizeKB}KB" -ForegroundColor DarkYellow
    } else {
        Remove-Item -Path $trash.FullName -Recurse -Force
        Write-Host "  [DEL] $vaultName — $fileCount files, ${sizeKB}KB" -ForegroundColor Green
    }
}

$totalKB = [math]::Round($totalSize / 1024, 1)
Write-Host ""
Write-Host "합계: $($trashDirs.Count)개 볼트, $totalFiles 파일, ${totalKB}KB" -ForegroundColor Cyan
if ($DryRun) {
    Write-Host "(DryRun — 실제 삭제 안 함)" -ForegroundColor DarkYellow
}
