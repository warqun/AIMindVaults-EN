# Codex bulk-edit safety rules

> Mandatory procedure to prevent the root causes of the two 2026-03-04 encoding incidents.
> Reference: `_Standards/Encoding_BulkEdit_Safety.md`

---

## 4-step mandatory protocol

Any bulk edit (script-driven edit of 2+ files) must follow this order:

```
Step 1 — Dry-run
  No edits; only print the target file list + summary diff

Step 2 — Sample of 3
  Apply to 3 target files first
  → Visually verify in Obsidian (juggl block, frontmatter, Korean integrity)

Step 3 — Full run
  Apply to all files only after the sample passes

Step 4 — Post-verification
  node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
  → Confirm POST_EDIT_REVIEW_BAD=0
```

---

## Safe I/O code (PowerShell)

```powershell
# Read
$text = [System.IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)

# Write (UTF-8 without BOM)
[System.IO.File]::WriteAllText($path, $newText, [Text.UTF8Encoding]::new($false))
```

---

## Juggl block insertion rules

- Before insertion: check if the file already has a juggl block → if so, skip
- Insertion point: directly below the first H1 (no blank line)
- Excluded: the entire `Domain/temp/agent_packets/**` folder
- Inserted content: `local:` value is the filename (without extension)

---

## Invariants — verify before the full run

Confirm the script guarantees:
- [ ] At most 1 juggl block per file
- [ ] Frontmatter block intact (`---` positions unchanged)
- [ ] `local:` value matches the filename exactly
- [ ] Line endings (CRLF/LF) unchanged

---

## Emergency-stop rule

If `BAD_COUNT > 0` or Korean mojibake appears:
1. Stop work immediately
2. Report to the user
3. Restore from an Obsidian snapshot
4. After restore is confirmed, retry using the safe method

---

## Required references when creating scripts

- Before writing a new script: see `_Standards/Core/Script_Creation_Rule.md`
- Duplicate check: see `_Standards/Core/Script_Registry.md`
- Path coding: no hardcoding; use auto-detection patterns
