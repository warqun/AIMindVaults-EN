# Codex Bulk Edit Safety Rules

> Mandatory procedure to prevent the root causes of 2 encoding incidents on 2026-03-04.
> Reference: `_Standards/Encoding_BulkEdit_Safety.md`

---

## 4-Step Mandatory Protocol

Bulk edits (modifying 2+ files via script) must follow this order:

```
Step 1 — Dry-run
  Output target file list + change diff summary only, no modifications

Step 2 — Sample 3
  Apply to 3 target files first
  -> Open in Obsidian for visual verification (Juggl blocks, frontmatter, character encoding)

Step 3 — Full Run
  Apply to all files only after sample verification passes

Step 4 — Post-verification
  node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
  -> Confirm POST_EDIT_REVIEW_BAD=0
```

---

## Safe I/O Code (PowerShell)

```powershell
# Read
$text = [System.IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)

# Write (UTF-8 without BOM)
[System.IO.File]::WriteAllText($path, $newText, [Text.UTF8Encoding]::new($false))
```

---

## Juggl Block Insertion Rules

- Before insertion: check if file already has a juggl block -> skip if exists
- Insertion position: directly below the first H1 (no blank lines)
- Excluded targets: entire `Domain/temp/agent_packets/**` folder
- Insertion content: `local:` value is the filename (without extension)

---

## Invariants — Verify Before Full Run

Confirm the script guarantees:
- [ ] At most 1 juggl block per file
- [ ] No frontmatter block corruption (`---` positions unchanged)
- [ ] `local:` value exactly matches the filename
- [ ] No line ending character changes (CRLF/LF)

---

## Emergency Stop Rules

When `BAD_COUNT > 0` or character corruption is detected:
1. Immediately stop work
2. Report to user
3. Restore from Obsidian snapshot
4. Retry with safe method after confirming recovery

---

## Required References for Script Creation

- Before writing a new script: reference `_Standards/Core/Script_Creation_Rule.md`
- Duplicate check: check `_Standards/Core/Script_Registry.md`
- Path coding: hardcoding prohibited, use auto-detection patterns
