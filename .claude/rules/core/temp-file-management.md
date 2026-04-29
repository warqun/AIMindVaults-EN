# Temporary-File Management (Mandatory)

> Applied uniformly to every vault. Common to all agents.

## Rules

- When running CLI commands (yt-dlp, python, ffmpeg, etc.), create temporary files only under `$env:TEMP`.
- Never create temporary files directly in the vault root or the current working directory.
- Delete the temp folder / files immediately when work completes. Do not report completion before deletion is verified.
- Save only the final artifact under the target vault's designated path (e.g. `Contents/`).

## Temp-Folder Pattern

```powershell
$tempDir = Join-Path $env:TEMP "aimind_temp_$(Get-Date -Format 'yyyyMMdd_HHmmss')"
New-Item -ItemType Directory -Path $tempDir -Force
# ... do the work ...
Remove-Item -Path $tempDir -Recurse -Force
```

## Infinite-Recursion Path Deletion (Incident Rule)

> Based on the 2026-04-08 incident: when something like `clone_vault` produced an infinite-recursion copy.

The Windows `MAX_PATH` (260 chars) limit makes every standard deletion tool fail. **Try the following in order:**

### Priority 1: PowerShell flatten-and-delete

Repeatedly move deep subfolders to a shorter path (flatten) so the path length shrinks, then delete:

```powershell
$root = '<bomb path>'
$temp = '<parent of bomb path>\_del'

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

### Priority 2: robocopy mirror loop

```powershell
mkdir C:\TEMP_EMPTY
for ($i = 0; $i -lt 1000; $i++) {
    robocopy C:\TEMP_EMPTY "<bomb path>" /MIR /R:0 /W:0 /NP /NJH /NJS /NFL /NDL 2>&1 | Out-Null
    if (-not (Test-Path "<bomb path>")) { Write-Host "DONE at pass $i"; break }
}
rmdir "<bomb path>"; rmdir C:\TEMP_EMPTY
```

### Methods That Fail (Do Not Use)

7z, `Remove-Item -Recurse`, `cmd /c rd /s /q`, `[System.IO.Directory]::Delete()` — all fail at the MAX_PATH limit.

### Reference

Detailed issue: the recursive-copy bomb investigation note under the project plan vault.

## Forbidden

- Do not leave temp files (`.vtt`, `.json`, `.srt`, `.tmp`, `.log`, etc.) lying around at vault roots.
- Do not leave temp scripts (`.py`, `.ps1`) inside any vault after a task.
- If cleanup fails, report immediately and request manual deletion.
