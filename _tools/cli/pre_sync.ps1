<#
.SYNOPSIS
    Script-freshness check before running sync_workspace.ps1.
.DESCRIPTION
    Compares the Hub's sync_workspace.ps1 version with the local version,
    replaces with the Hub version if different, then runs sync_workspace.ps1.
    Invoke from Obsidian Shell Commands.
.EXAMPLE
    .\pre_sync.ps1
#>

$ErrorActionPreference = "Continue"

# -- Path detection --
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$VaultRoot = (Resolve-Path "$ScriptDir\..\..").Path
$syncScript = Join-Path $ScriptDir "sync_workspace.ps1"

# Hub-path detection (same logic as sync_workspace.ps1)
$HubPath = ""
$normalizedVault = (Resolve-Path $VaultRoot).Path.TrimEnd('\')

# Pass 1: based on script location
$HubFromScript = (Resolve-Path "$ScriptDir\..\..").Path.TrimEnd('\')
if ($HubFromScript -ne $normalizedVault -and (Test-Path (Join-Path $HubFromScript ".sync\.hub_marker"))) {
    $HubPath = $HubFromScript
}

# Pass 2: search for .hub_marker from the AIMindVaults root
if (-not $HubPath) {
    $walkDir = $VaultRoot
    $rootDir = ""
    for ($i = 0; $i -lt 10; $i++) {
        $walkParent = Split-Path -Parent $walkDir
        if (-not $walkParent -or $walkParent -eq $walkDir) { break }
        if (Test-Path (Join-Path $walkParent "Vaults")) {
            $rootDir = $walkParent
            break
        }
        $walkDir = $walkParent
    }
    if ($rootDir) {
        $vaultsDir = Join-Path $rootDir "Vaults"
        $hubCandidate = Get-ChildItem -Path $vaultsDir -Directory -Recurse -Depth 3 |
            Where-Object {
                $candidatePath = (Resolve-Path $_.FullName).Path.TrimEnd('\')
                ($candidatePath -ne $normalizedVault) -and
                (Test-Path (Join-Path $_.FullName ".sync\.hub_marker"))
            } | Select-Object -First 1
        if ($hubCandidate) { $HubPath = $hubCandidate.FullName }
    }
}

# If the Hub cannot be found, run sync_workspace.ps1 directly.
if (-not $HubPath -or -not (Test-Path $HubPath)) {
    Write-Host "[PRE_SYNC] Hub not found. Running sync_workspace.ps1 as-is." -ForegroundColor DarkYellow
    & $syncScript
    exit $LASTEXITCODE
}

# If the current vault is itself the Hub, no sync is needed.
if ($normalizedVault -eq (Resolve-Path $HubPath).Path.TrimEnd('\')) {
    Write-Host "[PRE_SYNC] Current vault is the Hub. Sync not needed." -ForegroundColor Cyan
    exit 0
}

# -- Script-version comparison --
$hubSyncScript = Join-Path $HubPath "_tools\cli\sync_workspace.ps1"

if ((Test-Path $hubSyncScript) -and (Test-Path $syncScript)) {
    $localHash = (Get-FileHash -Path $syncScript -Algorithm SHA256).Hash
    $hubHash = (Get-FileHash -Path $hubSyncScript -Algorithm SHA256).Hash

    if ($localHash -ne $hubHash) {
        Write-Host "[PRE_SYNC] sync_workspace.ps1 differs from Hub. Updating." -ForegroundColor Yellow
        Copy-Item -Path $hubSyncScript -Destination $syncScript -Force
        Write-Host "[PRE_SYNC] Update complete." -ForegroundColor Green
    } else {
        Write-Host "[PRE_SYNC] sync_workspace.ps1 is up to date." -ForegroundColor DarkGray
    }
}

# -- Update pre_sync itself (trampoline pattern) --
$hubPreSync = Join-Path $HubPath "_tools\cli\pre_sync.ps1"
$selfPath = $MyInvocation.MyCommand.Path
if ((Test-Path $hubPreSync) -and (Test-Path $selfPath)) {
    $selfHash = (Get-FileHash -Path $selfPath -Algorithm SHA256).Hash
    $hubPreHash = (Get-FileHash -Path $hubPreSync -Algorithm SHA256).Hash
    if ($selfHash -ne $hubPreHash) {
        Write-Host "[PRE_SYNC] pre_sync.ps1 itself is also out of date. Re-executing with the new version..." -ForegroundColor Yellow
        Copy-Item -Path $hubPreSync -Destination $selfPath -Force
        # Trampoline: launch the new version in a new process and exit the current (old) process
        Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$selfPath`"" -WindowStyle Hidden
        exit 0
    }
}

# -- Run sync_workspace.ps1 --
Write-Host "[PRE_SYNC] Running sync_workspace.ps1..." -ForegroundColor Cyan
& $syncScript
exit $LASTEXITCODE
