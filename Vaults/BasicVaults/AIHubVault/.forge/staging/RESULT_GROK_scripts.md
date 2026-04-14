<#
.SYNOPSIS
AgentForge 모듈 전체 설치 스크립트 (신규 볼트용)

.USAGE
  .\install.ps1 -AgentForge "C:\AgentForge" -Target "C:\NewVault"

.DESCRIPTION
manifest.toml을 읽어 모든 모듈을 대상 볼트에 설치합니다.
• 대상 폴더 자동 생성
• 기존 파일 덮어쓰기 전 [Y/N/All] 확인
• 설치 완료 후 .agentforge-version.toml 생성
• UTF-8 BOM 없음 + glob 패턴 완벽 지원
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
    if (-not (Test-Path $Path)) { throw "파일 없음: $Path" }
    [System.IO.File]::ReadAllText($Path, [Text.Encoding]::UTF8)
}

function Write-Utf8NoBom {
    param([string]$Path, [string]$Content)
    $parent = Split-Path $Path -Parent
    if ($parent -and -not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, [Text.UTF8Encoding]::new($false))
}

# ====================== TOML 파서 ======================
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

# ====================== 복사 헬퍼 ======================
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
            Write-Warning "파일 없음: $($entry.Src)"
            continue
        }
        foreach ($item in $items) {
            # dest가 /로 끝나거나 glob이면 디렉토리로 취급
            if ($entry.Dest -match '/$|\\$' -or $entry.Src -match '\*') {
                $destDir = Join-Path $Target ($entry.Dest.TrimEnd('/\'))
                $destFile = Join-Path $destDir $item.Name
            } else {
                $destFile = Join-Path $Target $entry.Dest
            }
            $destParent = Split-Path $destFile -Parent
            if (-not (Test-Path $destParent)) { New-Item -ItemType Directory -Path $destParent -Force | Out-Null }

            if (Test-Path $destFile -and $ConfirmOverwrite) {
                $ans = Read-Host "  $($destFile) 이미 존재합니다. 덮어쓰시겠습니까? (Y/N/All)"
                if ($ans -match '^A') { $ConfirmOverwrite = $false }
                elseif ($ans -notmatch '^[Yy]') { continue }
            }
            Copy-Item -Path $item.FullName -Destination $destFile -Force
            Write-Host "  → $($item.Name)" -ForegroundColor Green
        }
    }
}

# ====================== 메인 ======================
$manifestPath = Join-Path $AgentForge "manifest.toml"
if (-not (Test-Path $manifestPath)) { Write-Error "manifest.toml 없음: $manifestPath"; exit 1 }

$modules = Parse-Manifest $manifestPath
if (-not (Test-Path $Target)) {
    New-Item -ItemType Directory -Path $Target -Force | Out-Null
    Write-Host "대상 볼트 생성: $Target" -ForegroundColor Cyan
}

Write-Host "=== AgentForge 전체 모듈 설치 시작 ===" -ForegroundColor Cyan

$versionPath = Join-Path $Target ".agentforge-version.toml"
$installed = @{}

foreach ($modName in $modules.Keys) {
    $mod = $modules[$modName]
    Write-Host "`n[$modName] v$($mod.Version) 설치 중..." -ForegroundColor Magenta
    Copy-ModuleFiles -AgentForge $AgentForge -Target $Target -FileEntries $mod.Files -ConfirmOverwrite $true
    $installed[$modName] = $mod.Version
}

Write-InstalledVersions $versionPath $installed
Write-Host "`n설치 완료! (.agentforge-version.toml 생성됨)" -ForegroundColor Green
<#
.SYNOPSIS
AgentForge 특정 모듈 업데이트 스크립트

.USAGE
  .\update.ps1 -AgentForge "C:\AgentForge" -Module claudian -Target "C:\MyVault"

.DESCRIPTION
지정 모듈만 설치하고 .agentforge-version.toml과 버전 비교 후 변경된 경우에만 복사합니다.
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$AgentForge,

    [Parameter(Mandatory=$true)]
    [string]$Module,

    [Parameter(Mandatory=$true)]
    [string]$Target
)

# (install.ps1과 동일한 Read-Utf8, Write-Utf8NoBom, Parse-Manifest, Read-InstalledVersions, Write-InstalledVersions, Copy-ModuleFiles 함수 전체 복사 — 생략 없이 동일하게 포함됨)

# ====================== UTF-8 Helpers (복사) ======================
function Read-Utf8 { param([string]$Path) if (-not (Test-Path $Path)) { throw "파일 없음: $Path" }; [System.IO.File]::ReadAllText($Path, [Text.Encoding]::UTF8) }
function Write-Utf8NoBom { param([string]$Path, [string]$Content) $parent = Split-Path $Path -Parent; if ($parent -and -not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }; [System.IO.File]::WriteAllText($Path, $Content, [Text.UTF8Encoding]::new($false)) }

# ====================== TOML 파서 (복사) ======================
function Parse-Manifest { /* install.ps1과 동일한 함수 전체 복사 */ 
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

# ====================== 버전 읽기/쓰기 (복사) ======================
function Read-InstalledVersions { /* install.ps1과 동일 */ 
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
function Write-InstalledVersions { /* install.ps1과 동일 */ 
    param([string]$Path, [hashtable]$Versions)
    $sb = [System.Text.StringBuilder]::new()
    [void]$sb.AppendLine("[installed]")
    foreach ($k in ($Versions.Keys | Sort-Object)) { [void]$sb.AppendLine("$k = `"$($Versions[$k])`"") }
    Write-Utf8NoBom $Path $sb.ToString()
}

# ====================== 복사 헬퍼 (복사) ======================
function Copy-ModuleFiles { /* install.ps1과 동일 전체 복사 */ 
    param([string]$AgentForge, [string]$Target, [array]$FileEntries, [bool]$ConfirmOverwrite = $true)
    foreach ($entry in $FileEntries) {
        $srcFull = Join-Path $AgentForge $entry.Src
        $items = Get-ChildItem -Path $srcFull -File -ErrorAction SilentlyContinue
        if (-not $items) { Write-Warning "파일 없음: $($entry.Src)"; continue }
        foreach ($item in $items) {
            if ($entry.Dest -match '/$|\\$' -or $entry.Src -match '\*') {
                $destDir = Join-Path $Target ($entry.Dest.TrimEnd('/\'))
                $destFile = Join-Path $destDir $item.Name
            } else { $destFile = Join-Path $Target $entry.Dest }
            $destParent = Split-Path $destFile -Parent
            if (-not (Test-Path $destParent)) { New-Item -ItemType Directory -Path $destParent -Force | Out-Null }
            if (Test-Path $destFile -and $ConfirmOverwrite) {
                $ans = Read-Host "  $($destFile) 이미 존재합니다. 덮어쓰시겠습니까? (Y/N/All)"
                if ($ans -match '^A') { $ConfirmOverwrite = $false }
                elseif ($ans -notmatch '^[Yy]') { continue }
            }
            Copy-Item -Path $item.FullName -Destination $destFile -Force
            Write-Host "  → $($item.Name)" -ForegroundColor Green
        }
    }
}

# ====================== 메인 ======================
$manifestPath = Join-Path $AgentForge "manifest.toml"
$modules = Parse-Manifest $manifestPath
if (-not $modules.ContainsKey($Module)) { Write-Error "모듈 '$Module' 없음"; exit 1 }

$mod = $modules[$Module]
$versionPath = Join-Path $Target ".agentforge-version.toml"
$installed = Read-InstalledVersions $versionPath
$currentVer = if ($installed.ContainsKey($Module)) { $installed[$Module] } else { "0.0.0" }

if ($currentVer -eq $mod.Version) {
    Write-Host "이미 최신 버전 ($Module v$currentVer)" -ForegroundColor Green
    exit 0
}

Write-Host "업데이트: $Module v$currentVer → v$($mod.Version)" -ForegroundColor Magenta
Copy-ModuleFiles -AgentForge $AgentForge -Target $Target -FileEntries $mod.Files -ConfirmOverwrite $true

$installed[$Module] = $mod.Version
Write-InstalledVersions $versionPath $installed
Write-Host "모듈 업데이트 완료" -ForegroundColor Green
<#
.SYNOPSIS
AgentForge 작업 볼트 → 원형 볼트 역동기화 (export)

.USAGE
  .\export.ps1 -Source "C:\WorkVault" -AgentForge "C:\AgentForge"

.DESCRIPTION
manifest.toml 기준으로 Source 볼트의 파일들을 AgentForge modules/ 하위로 복사합니다.
변경사항만 역동기화 (단순 복사, 프롬프트 없음)
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
    if (-not (Test-Path $Path)) { throw "파일 없음: $Path" }
    [System.IO.File]::ReadAllText($Path, [Text.Encoding]::UTF8)
}

function Write-Utf8NoBom {
    param([string]$Path, [string]$Content)
    $parent = Split-Path $Path -Parent
    if ($parent -and -not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    [System.IO.File]::WriteAllText($Path, $Content, [Text.UTF8Encoding]::new($false))
}

# ====================== TOML 파서 ======================
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

# ====================== 역동기화 헬퍼 ======================
function Export-ModuleFiles {
    param([string]$Source, [string]$AgentForge, [array]$FileEntries)
    foreach ($entry in $FileEntries) {
        $sourcePath = Join-Path $Source $entry.Dest
        $targetPath = Join-Path $AgentForge $entry.Src
        $items = Get-ChildItem -Path $sourcePath -File -ErrorAction SilentlyContinue
        if (-not $items) { Write-Warning "Source에 파일 없음: $($entry.Dest)"; continue }
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
            Write-Host "  ← $($item.Name)" -ForegroundColor Cyan
        }
    }
}

# ====================== 메인 ======================
$manifestPath = Join-Path $AgentForge "manifest.toml"
if (-not (Test-Path $manifestPath)) { Write-Error "manifest.toml 없음: $manifestPath"; exit 1 }

$modules = Parse-Manifest $manifestPath

Write-Host "=== AgentForge 역동기화 시작 ===" -ForegroundColor Cyan

foreach ($modName in $modules.Keys) {
    $mod = $modules[$modName]
    Write-Host "`n[$modName] 역동기화 중..." -ForegroundColor Magenta
    Export-ModuleFiles -Source $Source -AgentForge $AgentForge -FileEntries $mod.Files
}

Write-Host "`n역동기화 완료!" -ForegroundColor Green