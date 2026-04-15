---
name: juggl-insert
description: Procedure to insert a Juggl block below H1 when an existing note lacks one
---

# Juggl block insertion

> When to use: adding a Juggl block when the existing note has none
> Rules: `.codex/rules/never-do.md`, `.codex/rules/bulk-edit-safety.md`

## Single-file insertion

```powershell
# 1. Read file (fixed UTF-8)
$text = [System.IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)

# 2. Skip if a juggl block already exists
if ($text -match '```juggl') { Write-Host "SKIP: juggl already exists"; return }

# 3. Find the H1 position
$lines = $text -split "`n"
$h1Index = -1
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match '^# ') { $h1Index = $i; break }
}
if ($h1Index -eq -1) { Write-Host "ERROR: H1 not found"; return }

# 4. Remove extension from the filename
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($path)

# 5. Insert juggl block (line after H1)
$jugglBlock = "``````juggl`nlocal: $baseName`n``````"
$newLines = @($lines[0..$h1Index]) + @("", $jugglBlock, "") + @($lines[($h1Index+1)..($lines.Count-1)])
$newText = $newLines -join "`n"

# 6. Write (UTF-8 without BOM)
[System.IO.File]::WriteAllText($path, $newText, [Text.UTF8Encoding]::new($false))
```

## Bulk insertion (many files)

Must follow the 5-step protocol (`.codex/rules/bulk-edit-safety.md`):

```
Step 1: Pre-validate encoding
Step 2: Dry-run (print file list only)
Step 3: Apply to 3 samples first
Step 4: Visually verify, then run on all files
Step 5: Confirm post-review BAD_COUNT=0
```

Excluded:
```
Contents/*/temp/**
_STATUS.md
_VAULT-INDEX.md
.codex/**
.claude/**
```

## Invariant checks (before the full run)

```powershell
# Verify at most one juggl block per file
$files = Get-ChildItem Contents/**/*.md -Recurse
foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8)
    $count = ([regex]::Matches($content, '```juggl')).Count
    if ($count -gt 1) { Write-Host "WARN: $($f.Name) has $count juggl blocks" }
}
```
