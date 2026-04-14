<#
.SYNOPSIS
AgentForge full module installation script (for new vaults)

.USAGE
  .\install.ps1 -AgentForge "C:\AgentForge" -Target "C:\NewVault"

.DESCRIPTION
Reads manifest.toml and installs all modules to the target vault.
- Auto-creates target folders
- Prompts [Y/N/All] before overwriting existing files
- Creates .agentforge-version.toml after installation
- UTF-8 without BOM + full glob pattern support
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$AgentForge,

    [Parameter(Mandatory=$true)]
    [string]$Target
)

# ====================== UTF-8 Helpers ======================
function Read-Utf8 {
    param([string]$Path)
    if (-not (Test-Path $Path)) { throw "File not found: $Path" }
    [System.IO.File]::ReadAllText($Path, [Text.Encoding]::UTF8)
}

function Write-Utf8NoBom {
    param([string]$Path, [string]$Content)
    $parent = Split-Path $Path -Parent
    if ($parent -and -not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, [Text.UTF8Encoding]::new($false))
}

# ====================== TOML Parser ======================
function Parse-Manifest {
    param([string]$Path)
    $content = Read-Utf8 $Path
    $lines = $content -split "`r?`n"
    $modules = @{}
    $current = $null
    foreach ($line in $lines) {
        $trim = $line.Trim()
        if ($trim -match '^\[module\.(\w+)\]$') {
            $name = $matches[1]
            $current = @{ Version = ""; Files = @() }
            $modules[$name] = $current
        }
        elseif ($current -and $trim -match '^version\s*=\s*["'']?([^"'']+)["'']?') {
            $current.Version = $matches[1].Trim()
        }
        elseif ($current -and $trim -match '^\{\s*src\s*=\s*["'']([^"'']+)["'']\s*,\s*dest\s*=\s*["'']([^"'']+)["'']\s*\}\s*,?') {
            $current.Files += @{ Src = $matches[1].Trim(); Dest = $matches[2].Trim() }
        }
    }
    return $modules
}

function Read-InstalledVersions {
    param([string]$Path)
    if (-not (Test-Path $Path)) { return @{} }
    $content = Read-Utf8 $Path
    $ver = @{}
    $inSection = $false
    foreach ($line in ($content -split "`r?`n")) {
        $trim = $line.Trim()
        if ($trim -eq '[installed]') { $inSection = $true; continue }
        if ($inSection -and $trim -match '^(\w+)\s*=\s*["'']?([^"'']+)["'']?') {
            $ver[$matches[1]] = $matches[2]
        }
    }
    return $ver
}

function Write-InstalledVersions {
    param([string]$Path, [hashtable]$Versions)
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine("[installed]")
    foreach ($k in ($Versions.Keys | Sort-Object)) {
        [void]$sb.AppendLine("$k = `"$($Versions[$k])`"")
    }
    Write-Utf8NoBom $Path $sb.ToString()
}

# ====================== Copy Helper ======================
function Copy-ModuleFiles {
    param(
        [string]$AgentForge,
        [string]$Target,
        [array]$FileEntries,
        [bool]$ConfirmOverwrite = $true
    )
    foreach ($entry in $FileEntries) {
        $srcFull = Join-Path $AgentForge $entry.Src
        $items = Get-ChildItem -Path $srcFull -File -ErrorAction SilentlyContinue
        if (-not $items) {
            Write-Warning "File not found: $($entry.Src)"
            continue
        }
        foreach ($item in $items) {
            # Treat dest as directory if it ends with / or src contains glob
            if ($entry.Dest -match '/$|\\$' -or $entry.Src -match '\*') {
                $destDir = Join-Path $Target ($entry.Dest.TrimEnd('/\'))
                $destFile = Join-Path $destDir $item.Name
            } else {
                $destFile = Join-Path $Target $entry.Dest
            }
            $destParent = Split-Path $destFile -Parent
            if (-not (Test-Path $destParent)) { New-Item -ItemType Directory -Path $destParent -Force | Out-Null }

            if (Test-Path $destFile -and $ConfirmOverwrite) {
                $ans = Read-Host "  $($destFile) already exists. Overwrite? (Y/N/All)"
                if ($ans -match '^A') { $ConfirmOverwrite = $false }
                elseif ($ans -notmatch '^[Yy]') { continue }
            }
            Copy-Item -Path $item.FullName -Destination $destFile -Force
            Write-Host "  -> $($item.Name)" -ForegroundColor Green
        }
    }
}

# ====================== Main ======================
$manifestPath = Join-Path $AgentForge "manifest.toml"
if (-not (Test-Path $manifestPath)) { Write-Error "manifest.toml not found: $manifestPath"; exit 1 }

$modules = Parse-Manifest $manifestPath
if (-not (Test-Path $Target)) {
    New-Item -ItemType Directory -Path $Target -Force | Out-Null
    Write-Host "Target vault created: $Target" -ForegroundColor Cyan
}

Write-Host "=== AgentForge Full Module Installation Start ===" -ForegroundColor Cyan

$versionPath = Join-Path $Target ".agentforge-version.toml"
$installed = @{}

foreach ($modName in $modules.Keys) {
    $mod = $modules[$modName]
    Write-Host "`n[$modName] Installing v$($mod.Version)..." -ForegroundColor Magenta
    Copy-ModuleFiles -AgentForge $AgentForge -Target $Target -FileEntries $mod.Files -ConfirmOverwrite $true
    $installed[$modName] = $mod.Version
}

Write-InstalledVersions $versionPath $installed
Write-Host "`nInstallation complete! (.agentforge-version.toml created)" -ForegroundColor Green
<#
.SYNOPSIS
AgentForge specific module update script

.USAGE
  .\update.ps1 -AgentForge "C:\AgentForge" -Module claudian -Target "C:\MyVault"

.DESCRIPTION
Installs only the specified module, comparing versions with .agentforge-version.toml and copying only when changed.
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$AgentForge,

    [Parameter(Mandatory=$true)]
    [string]$Module,

    [Parameter(Mandatory=$true)]
    [string]$Target
)

# (Same Read-Utf8, Write-Utf8NoBom, Parse-Manifest, Read-InstalledVersions, Write-InstalledVersions, Copy-ModuleFiles functions as install.ps1 — included in full without omission)

# ====================== UTF-8 Helpers (copy) ======================
function Read-Utf8 { param([string]$Path) if (-not (Test-Path $Path)) { throw "File not found: $Path" }; [System.IO.File]::ReadAllText($Path, [Text.Encoding]::UTF8) }
function Write-Utf8NoBom { param([string]$Path, [string]$Content) $parent = Split-Path $Path -Parent; if ($parent -and -not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }; [System.IO.File]::WriteAllText($Path, $Content, [Text.UTF8Encoding]::new($false)) }

# ====================== TOML Parser (copy) ======================
function Parse-Manifest { /* Same full function as install.ps1 */ 
    param([string]$Path)
    $content = Read-Utf8 $Path
    $lines = $content -split "`r?`n"
    $modules = @{}
    $current = $null
    foreach ($line in $lines) {
        $trim = $line.Trim()
        if ($trim -match '^\[module\.(\w+)\]$') { $name = $matches[1]; $current = @{ Version = ""; Files = @() }; $modules[$name] = $current }
        elseif ($current -and $trim -match '^version\s*=\s*["'']?([^"'']+)["'']?') { $current.Version = $matches[1].Trim() }
        elseif ($current -and $trim -match '^\{\s*src\s*=\s*["'']([^"'']+)["'']\s*,\s*dest\s*=\s*["'']([^"'']+)["'']\s*\}\s*,?') { $current.Files += @{ Src = $matches[1].Trim(); Dest = $matches[2].Trim() } }
    }
    return $modules
}

# ====================== Version Read/Write (copy) ======================
function Read-InstalledVersions { /* Same as install.ps1 */ 
    param([string]$Path)
    if (-not (Test-Path $Path)) { return @{} }
    $content = Read-Utf8 $Path
    $ver = @{}
    $inSection = $false
    foreach ($line in ($content -split "`r?`n")) {
        $trim = $line.Trim()
        if ($trim -eq '[installed]') { $inSection = $true; continue }
        if ($inSection -and $trim -match '^(\w+)\s*=\s*["'']?([^"'']+)["'']?') { $ver[$matches[1]] = $matches[2] }
    }
    return $ver
}
function Write-InstalledVersions { /* Same as install.ps1 */ 
    param([string]$Path, [hashtable]$Versions)
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine("[installed]")
    foreach ($k in ($Versions.Keys | Sort-Object)) { [void]$sb.AppendLine("$k = `"$($Versions[$k])`"") }
    Write-Utf8NoBom $Path $sb.ToString()
}

# ====================== Copy Helper (copy) ======================
function Copy-ModuleFiles { /* Same full copy as install.ps1 */ 
    param([string]$AgentForge, [string]$Target, [array]$FileEntries, [bool]$ConfirmOverwrite = $true)
    foreach ($entry in $FileEntries) {
        $srcFull = Join-Path $AgentForge $entry.Src
        $items = Get-ChildItem -Path $srcFull -File -ErrorAction SilentlyContinue
        if (-not $items) { Write-Warning "File not found: $($entry.Src)"; continue }
        foreach ($item in $items) {
            if ($entry.Dest -match '/$|\\$' -or $entry.Src -match '\*') {
                $destDir = Join-Path $Target ($entry.Dest.TrimEnd('/\'))
                $destFile = Join-Path $destDir $item.Name
            } else { $destFile = Join-Path $Target $entry.Dest }
            $destParent = Split-Path $destFile -Parent
            if (-not (Test-Path $destParent)) { New-Item -ItemType Directory -Path $destParent -Force | Out-Null }
            if (Test-Path $destFile -and $ConfirmOverwrite) {
                $ans = Read-Host "  $($destFile) already exists. Overwrite? (Y/N/All)"
                if ($ans -match '^A') { $ConfirmOverwrite = $false }
                elseif ($ans -notmatch '^[Yy]') { continue }
            }
            Copy-Item -Path $item.FullName -Destination $destFile -Force
            Write-Host "  -> $($item.Name)" -ForegroundColor Green
        }
    }
}

# ====================== Main ======================
$manifestPath = Join-Path $AgentForge "manifest.toml"
$modules = Parse-Manifest $manifestPath
if (-not $modules.ContainsKey($Module)) { Write-Error "Module '$Module' not found"; exit 1 }

$mod = $modules[$Module]
$versionPath = Join-Path $Target ".agentforge-version.toml"
$installed = Read-InstalledVersions $versionPath
$currentVer = if ($installed.ContainsKey($Module)) { $installed[$Module] } else { "0.0.0" }

if ($currentVer -eq $mod.Version) {
    Write-Host "Already at latest version ($Module v$currentVer)" -ForegroundColor Green
    exit 0
}

Write-Host "Updating: $Module v$currentVer -> v$($mod.Version)" -ForegroundColor Magenta
Copy-ModuleFiles -AgentForge $AgentForge -Target $Target -FileEntries $mod.Files -ConfirmOverwrite $true

$installed[$Module] = $mod.Version
Write-InstalledVersions $versionPath $installed
Write-Host "Module update complete" -ForegroundColor Green
<#
.SYNOPSIS
AgentForge working vault -> source vault reverse sync (export)

.USAGE
  .\export.ps1 -Source "C:\WorkVault" -AgentForge "C:\AgentForge"

.DESCRIPTION
Copies files from the Source vault back to AgentForge modules/ based on manifest.toml.
Reverse-syncs changes only (simple copy, no prompts)
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Source,

    [Parameter(Mandatory=$true)]
    [string]$AgentForge
)

# ====================== UTF-8 Helpers ======================
function Read-Utf8 {
    param([string]$Path)
    if (-not (Test-Path $Path)) { throw "File not found: $Path" }
    [System.IO.File]::ReadAllText($Path, [Text.Encoding]::UTF8)
}

function Write-Utf8NoBom {
    param([string]$Path, [string]$Content)
    $parent = Split-Path $Path -Parent
    if ($parent -and -not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, [Text.UTF8Encoding]::new($false))
}

# ====================== TOML Parser ======================
function Parse-Manifest {
    param([string]$Path)
    $content = Read-Utf8 $Path
    $lines = $content -split "`r?`n"
    $modules = @{}
    $current = $null
    foreach ($line in $lines) {
        $trim = $line.Trim()
        if ($trim -match '^\[module\.(\w+)\]$') {
            $name = $matches[1]
            $current = @{ Version = ""; Files = @() }
            $modules[$name] = $current
        }
        elseif ($current -and $trim -match '^version\s*=\s*["'']?([^"'']+)["'']?') {
            $current.Version = $matches[1].Trim()
        }
        elseif ($current -and $trim -match '^\{\s*src\s*=\s*["'']([^"'']+)["'']\s*,\s*dest\s*=\s*["'']([^"'']+)["'']\s*\}\s*,?') {
            $current.Files += @{ Src = $matches[1].Trim(); Dest = $matches[2].Trim() }
        }
    }
    return $modules
}

# ====================== Reverse Sync Helper ======================
function Export-ModuleFiles {
    param([string]$Source, [string]$AgentForge, [array]$FileEntries)
    foreach ($entry in $FileEntries) {
        $sourcePath = Join-Path $Source $entry.Dest
        $targetPath = Join-Path $AgentForge $entry.Src
        $items = Get-ChildItem -Path $sourcePath -File -ErrorAction SilentlyContinue
        if (-not $items) { Write-Warning "File not found in Source: $($entry.Dest)"; continue }
        foreach ($item in $items) {
            if ($entry.Dest -match '/$|\\$' -or $entry.Src -match '\*') {
                $destDir = Split-Path $targetPath -Parent
                $destFile = Join-Path $destDir $item.Name
            } else {
                $destFile = $targetPath
            }
            $destParent = Split-Path $destFile -Parent
            if (-not (Test-Path $destParent)) { New-Item -ItemType Directory -Path $destParent -Force | Out-Null }
            Copy-Item -Path $item.FullName -Destination $destFile -Force
            Write-Host "  <- $($item.Name)" -ForegroundColor Cyan
        }
    }
}

# ====================== Main ======================
$manifestPath = Join-Path $AgentForge "manifest.toml"
if (-not (Test-Path $manifestPath)) { Write-Error "manifest.toml not found: $manifestPath"; exit 1 }

$modules = Parse-Manifest $manifestPath

Write-Host "=== AgentForge Reverse Sync Start ===" -ForegroundColor Cyan

foreach ($modName in $modules.Keys) {
    $mod = $modules[$modName]
    Write-Host "`n[$modName] Reverse syncing..." -ForegroundColor Magenta
    Export-ModuleFiles -Source $Source -AgentForge $AgentForge -FileEntries $mod.Files
}

Write-Host "`nReverse sync complete!" -ForegroundColor Green