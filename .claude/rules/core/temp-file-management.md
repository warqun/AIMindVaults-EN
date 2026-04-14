# Temporary File Management (Mandatory)

> Applies uniformly to all vaults. Common to all agents.

## Rules

- When running CLI commands (yt-dlp, python, ffmpeg, etc.), temporary files must be created under `$env:TEMP`.
- Do not create temporary files directly in the vault root or CWD.
- Delete temporary folders/files immediately after task completion. Do not report completion without confirming deletion.
- Only final deliverables should be saved to the designated path in the target vault (Contents/, etc.).

## Temporary Folder Pattern

```powershell
$tempDir = Join-Path $env:TEMP "aimind_temp_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
New-Item -ItemType Directory -Path $tempDir -Force
# ... perform work ...
Remove-Item -Path $tempDir -Recurse -Force
```

## Infinite Recursive Path Deletion (Incident Rule)

> Based on 2026-04-08 Incident. Applies when infinite recursive copying occurred via clone_vault or similar.

Standard deletion tools all fail due to the Windows MAX_PATH (260 character) limit. **Try the following in order**:

### Priority 1: PowerShell flatten-and-delete

Repeatedly move deep subdirectories to a short path (flatten) to reduce path length, then delete:

```powershell
$root = '<bomb_path>'
$temp = '<bomb_path_parent>\_del'

for ($i = 0; $i -lt 500; $i++) {
    $sub = Get-ChildItem -Path $root -Directory -EA SilentlyContinue | Select-Object -First 1
    if (-not $sub) { break }
    $children = Get-ChildItem -Path $sub.FullName -Directory -EA SilentlyContinue
    if ($children) {
        foreach ($child in $children) {
            if (Test-Path $temp) { Remove-Item $temp -Recurse -Force -EA SilentlyContinue }
            Move-Item -LiteralPath $child.FullName -Destination $temp -Force -EA SilentlyContinue
        }
    }
    Get-ChildItem -Path $sub.FullName -File -EA SilentlyContinue | Remove-Item -Force -EA SilentlyContinue
    Remove-Item -LiteralPath $sub.FullName -Force -Recurse -EA SilentlyContinue
}
if (Test-Path $temp) { Remove-Item $temp -Recurse -Force -EA SilentlyContinue }
if (Test-Path $root) { Remove-Item $root -Recurse -Force -EA SilentlyContinue }
```

### Priority 2: Repeated robocopy mirror

```powershell
mkdir C:\TEMP_EMPTY
for ($i = 0; $i -lt 1000; $i++) {
    robocopy C:\TEMP_EMPTY "<bomb_path>" /MIR /R:0 /W:0 /NP /NJH /NJS /NFL /NDL 2>&1 | Out-Null
    if (-not (Test-Path "<bomb_path>")) { Write-Host "DONE at pass $i"; break }
}
rmdir "<bomb_path>"; rmdir C:\TEMP_EMPTY
```

### Methods That Fail (Do Not Use)

7z, `Remove-Item -Recurse`, `cmd /c rd /s /q`, `[System.IO.Directory]::Delete()` — all fail due to the MAX_PATH limit.

### Reference

Detailed issue: Project_AIMindVaults `20260408_clone_vault_recursive_copy_bomb_issue.md`

## Prohibited Actions

- Leaving temporary files (`.vtt`, `.json`, `.srt`, `.tmp`, `.log`, etc.) in the vault root is prohibited.
- Creating temporary scripts (`.py`, `.ps1`) inside a vault and leaving them behind is prohibited.
- If cleanup fails, immediately report to the user and request manual deletion.
