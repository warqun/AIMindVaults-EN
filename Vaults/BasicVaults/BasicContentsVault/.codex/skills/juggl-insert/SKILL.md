---
name: juggl-insert
description: Procedure for inserting a Juggl block below H1 when an existing note has none
---

# Juggl Block Insertion

> When to use: Adding a Juggl block to an existing note that doesn't have one
> Rules: `.codex/rules/never-do.md`, `.codex/rules/bulk-edit-safety.md`

## Single File Insertion

```powershell
# 1. Read file (fixed UTF-8)
$text = [System.IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)

# 2. Skip if juggl block already exists
if ($text -match '```juggl') { Write-Host "SKIP: juggl already exists"; return }

# 3. Find H1 position
$lines = $text -split "`n"
$h1Index = -1
for ($i = 0; $i -lt $lines.Count; $i++) {
    if ($lines[$i] -match '^# ') { $h1Index = $i; break }
}
if ($h1Index -eq -1) { Write-Host "ERROR: H1 not found"; return }

# 4. Remove extension from filename
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($path)

# 5. Insert juggl block (line after H1)
$jugglBlock = "``````juggl`nlocal: $baseName`n``````"
$newLines = @($lines[0..$h1Index]) + @("", $jugglBlock, "") + @($lines[($h1Index+1)..($lines.Count-1)])
$newText = $newLines -join "`n"

# 6. Write (UTF-8 without BOM)
[System.IO.File]::WriteAllText($path, $newText, [Text.UTF8Encoding]::new($false))
```

## Bulk Insertion (Multiple Files)

Must follow the 5-step protocol (`.codex/rules/bulk-edit-safety.md`):

```
Step 1: Pre-encoding verification
Step 2: Dry-run (output file list only)
Step 3: Apply to 3 samples first
Step 4: Visual verification then full run
Step 5: Confirm post-review BAD_COUNT=0
```

Excluded targets:
```
Contents/*/temp/**
_STATUS.md
_VAULT-INDEX.md
.codex/**
.claude/**
```

## Invariant Check (Before Full Run)

```powershell
# Verify at most 1 juggl block per file
$files = Get-ChildItem Contents/**/*.md -Recurse
foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [Text.Encoding]::UTF8)
    $count = ([regex]::Matches($content, '```juggl')).Count
    if ($count -gt 1) { Write-Host "WARN: $($f.Name) has $count juggl blocks" }
}
```
