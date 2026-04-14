# Codex Bulk Edit Safety Rules

> Mandatory procedure to prevent root causes of 2 encoding incidents on 2026-03-04.
> Reference: `_Standards/Encoding_BulkEdit_Safety.md`

---

## 4-Step Required Protocol

Bulk modifications (modifying 2+ files via script) must follow this order:

```
Step 1 — Dry-run
  Output target file list + change diff summary only, no modifications

Step 2 — Sample 3 files
  Apply to only 3 target files first
  -> Open in Obsidian for visual verification (Juggl blocks, frontmatter, character integrity)

Step 3 — Full execution
  Apply to all files only after confirming sample passes

Step 4 — Post-verification
  node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
  -> Confirm POST_EDIT_REVIEW_BAD=0
```

---

## Safe I/O Code (PowerShell)

```powershell
# Read
$text = [System.IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)

# Write (BOM-less UTF-8)
[System.IO.File]::WriteAllText($path, $newText, [Text.UTF8Encoding]::new($false))
```

---

## Juggl Block Insertion Rules

- Before insertion: Check if file has an existing juggl block -> skip if present
- Insertion location: Directly below the first H1 (no blank lines)
- Excluded targets: Entire `Domain/temp/agent_packets/**` folder
- Insertion content: `local:` value is the filename (without extension)

---

## Invariants — Verify Before Full Execution

Confirm the script guarantees the following:
- [ ] No more than 1 juggl block per file
- [ ] No frontmatter block corruption (no `---` position changes)
- [ ] `local:` value exactly matches the filename
- [ ] No line ending character changes (CRLF/LF)

---

## Emergency Stop Rules

If `BAD_COUNT > 0` or character corruption is detected:
1. Immediately stop work
2. Report to user
3. Restore from Obsidian snapshot
4. Retry with safe method after confirming recovery

---

## Required References When Creating Scripts

- Before writing new scripts: Refer to `_Standards/Core/Script_Creation_Rule.md`
- Check for duplicates: Review `_Standards/Core/Script_Registry.md`
- Path coding: No hardcoding; use auto-detection patterns
