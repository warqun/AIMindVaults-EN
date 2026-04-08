<#
.SYNOPSIS
    Obsidian 볼트를 안전하게 여는 런처
.DESCRIPTION
    1. pre_sync.ps1 실행 (스크립트 최신화 + workspace 동기화)
    2. 동기화 완료 후 Obsidian 볼트 열기
    Obsidian이 꺼진 상태에서 실행해야 community-plugins.json 변경이 정상 반영됨.
.EXAMPLE
    .\open_vault.ps1
#>

$ErrorActionPreference = "Continue"

# ── 경로 탐지 ──
# NOTE: .sync\_tools\cli\ 기준 3단계(..\..\..),  레거시 _tools\cli\ 기준 2단계(..\..),
#       순서대로 시도하며 Contents/ 폴더 존재로 볼트 루트를 검증한다.
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$VaultRoot = $null
$rootCandidates = @(
    (Join-Path $ScriptDir "..\..\.."),   # .sync\_tools\cli → 볼트루트
    (Join-Path $ScriptDir "..\..")        # _tools\cli → 볼트루트 (레거시)
)
foreach ($candidate in $rootCandidates) {
    if (-not (Test-Path $candidate)) { continue }
    $resolved = (Resolve-Path $candidate).Path
    if (
        (Test-Path (Join-Path $resolved "Contents")) -or
        (Test-Path (Join-Path $resolved ".obsidian"))
    ) {
        $VaultRoot = $resolved
        break
    }
}
if (-not $VaultRoot) {
    Write-Error "Vault root auto-detect failed from $ScriptDir"
    exit 1
}

# 볼트명 추출 (폴더명)
$VaultName = Split-Path -Leaf $VaultRoot

# ── pre_sync 실행 ──
# pre_sync.ps1은 .sync/ 직하에 위치 (cli/ 안이 아님)
$preSyncCandidates = @(
    (Join-Path $VaultRoot ".sync\pre_sync.ps1"),
    (Join-Path $VaultRoot "pre_sync.ps1")
)
$preSyncScript = $preSyncCandidates | Where-Object { Test-Path $_ } | Select-Object -First 1
if ($preSyncScript -and (Test-Path $preSyncScript)) {
    Write-Host "=== Pre-Sync 실행 ===" -ForegroundColor Cyan
    & $preSyncScript
    Write-Host ""
} else {
    Write-Host "[WARN] pre_sync.ps1을 찾을 수 없습니다." -ForegroundColor DarkYellow
}

# ── Obsidian 볼트 열기 ──
Write-Host "=== Obsidian 볼트 열기: $VaultName ===" -ForegroundColor Green
Start-Process "obsidian://open?vault=$VaultName"
