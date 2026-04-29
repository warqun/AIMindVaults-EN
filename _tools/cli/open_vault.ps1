<#
.SYNOPSIS
    Safely open an Obsidian vault.
.DESCRIPTION
    1. Run pre_sync.ps1 (script update + workspace sync).
    2. Open the Obsidian vault after the sync completes.
    Run while Obsidian is closed so that community-plugins.json changes apply correctly.
.EXAMPLE
    .\open_vault.ps1
#>

$ErrorActionPreference = "Continue"

# -- Path detection --
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$VaultRoot = (Resolve-Path "$ScriptDir\..\..").Path

# Vault name (folder name)
$VaultName = Split-Path -Leaf $VaultRoot

# -- Run pre_sync --
$preSyncScript = Join-Path $ScriptDir "pre_sync.ps1"
if (Test-Path $preSyncScript) {
    Write-Host "=== Running Pre-Sync ===" -ForegroundColor Cyan
    & $preSyncScript
    Write-Host ""
} else {
    Write-Host "[WARN] pre_sync.ps1 not found." -ForegroundColor DarkYellow
}

# -- Open the Obsidian vault --
Write-Host "=== Opening Obsidian vault: $VaultName ===" -ForegroundColor Green
Start-Process "obsidian://open?vault=$VaultName"
