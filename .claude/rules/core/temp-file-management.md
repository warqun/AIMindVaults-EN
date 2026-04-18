# Temp File Management (Mandatory)

> Applies to all vaults. All agents.

## Rules

- When running CLI commands (yt-dlp, python, ffmpeg, etc.), create temp files under `$env:TEMP` only.
- Never create temp files directly at a vault root or the CWD.
- After the task, delete the temp folder/files immediately. No completion report before deletion is confirmed.
- Only the final output goes into the target vault's designated path (e.g. `Contents/`).

## Temp Folder Pattern

```powershell
$tempDir = Join-Path $env:TEMP "aimind_temp_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
New-Item -ItemType Directory -Path $tempDir -Force
# ... do the work ...
Remove-Item -Path $tempDir -Recurse -Force
```

## Infinite-Recursion Path Deletion (Incident Rule)

> Based on 2026-04-08 incident — `clone_vault` runaway recursive copy.

Windows MAX_PATH (260 chars) makes every normal deletion tool fail. **Try in the order below.**

### 1st choice: PowerShell flatten-and-delete

Iteratively move deep sub-folders to short paths (flatten) to shrink path length, then delete:

```powershell
$root = '<bomb-path>'
$temp = '<parent-of-bomb-path>\_del'

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

### 2nd choice: repeated robocopy mirror

```powershell
mkdir C:\TEMP_EMPTY
for ($i = 0; $i -lt 1000; $i++) {
    robocopy C:\TEMP_EMPTY "<bomb-path>" /MIR /R:0 /W:0 /NP /NJH /NJS /NFL /NDL 2>&1 | Out-Null
    if (-not (Test-Path "<bomb-path>")) { Write-Host "DONE at pass $i"; break }
}
rmdir "<bomb-path>"; rmdir C:\TEMP_EMPTY
```

### Methods that fail (do not use)

7z, `Remove-Item -Recurse`, `cmd /c rd /s /q`, `[System.IO.Directory]::Delete()` — all hit the MAX_PATH wall.

### Reference

If a recursive-copy bomb occurs, log the incident in your project plan vault for future reference.

## Forbidden

- Leaving temp files (`.vtt`, `.json`, `.srt`, `.tmp`, `.log`, etc.) at a vault root.
- Creating temp scripts (`.py`, `.ps1`) inside a vault and leaving them.
- If cleanup fails, report immediately and ask the user to delete manually.
