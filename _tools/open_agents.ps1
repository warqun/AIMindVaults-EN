$ErrorActionPreference = "Stop"

$vaultRoot = Split-Path -Parent $PSScriptRoot

function Resolve-VsCodeCommand {
    $codeCmd = Get-Command code -ErrorAction SilentlyContinue
    if ($codeCmd) { return $codeCmd.Source }

    $candidates = @(
        (Join-Path $env:LOCALAPPDATA "Programs\\Microsoft VS Code\\bin\\code.cmd"),
        (Join-Path $env:ProgramFiles "Microsoft VS Code\\bin\\code.cmd"),
        (Join-Path ${env:ProgramFiles(x86)} "Microsoft VS Code\\bin\\code.cmd")
    ) | Where-Object { $_ -and (Test-Path $_) }

    if ($candidates.Count -gt 0) { return $candidates[0] }
    return $null
}

$code = Resolve-VsCodeCommand
if ($code) {
    Start-Process -FilePath $code -ArgumentList @("--new-window", $vaultRoot) | Out-Null
} else {
    Write-Warning "VSCode 'code' command not found. Install VSCode or enable the 'code' CLI."
}

<#
AntiGravity launcher (user configuration required)

Pick one of the following options.

1) URL form (web / IDE):
   - Save the URL on a single line in `tools/antigravity.url.txt`.

2) Executable form (desktop IDE):
   - Save the exe path on a single line in `tools/antigravity.exe.txt`.
   - (Optional) Save args on a single line in `tools/antigravity.args.txt`.
#>

$antiGravityUrlPath = Join-Path $PSScriptRoot "antigravity.url.txt"
if (Test-Path $antiGravityUrlPath) {
    $url = (Get-Content -Raw -Encoding UTF8 $antiGravityUrlPath).Trim()
    if ($url) { Start-Process $url | Out-Null }
    exit 0
}

$antiGravityExePathFile = Join-Path $PSScriptRoot "antigravity.exe.txt"
if (Test-Path $antiGravityExePathFile) {
    $exe = (Get-Content -Raw -Encoding UTF8 $antiGravityExePathFile).Trim()
    if (-not $exe) { exit 0 }
    $argsFile = Join-Path $PSScriptRoot "antigravity.args.txt"
    $agArgs = if (Test-Path $argsFile) { (Get-Content -Raw -Encoding UTF8 $argsFile).Trim() } else { $vaultRoot }
    Start-Process -FilePath $exe -ArgumentList $agArgs | Out-Null
    exit 0
}
