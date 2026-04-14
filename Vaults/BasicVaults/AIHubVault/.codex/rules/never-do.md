# CODEX Absolute Prohibitions (Top Priority Rules)

> This file must be read before starting any work.
> Violating any item below will result in file corruption and history recovery work.

---

## Encoding Prohibition (Markdown Files)

**Absolutely prohibited:**
```powershell
# Prohibited — default encoding causes character corruption
Get-Content file.md | Set-Content file.md
Get-Content file.md -Raw | ... | Set-Content file.md
Add-Content file.md "..."
```

**Must use this method only:**
```powershell
# Safe — UTF-8 fixed I/O
$text = [System.IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($path, $text, [Text.UTF8Encoding]::new($false))
```

---

## Bulk Modification Prohibited Patterns

**Absolutely prohibited:**
```powershell
# Prohibited — global replacement on all files at once
Get-ChildItem Domain/**/*.md | ForEach { ... Set-Content ... }
```

**Must follow this order:**
1. Dry-run (output target file list only, no modifications)
2. Apply to only 3 sample files first
3. Visual verification in Obsidian
4. Full execution only if no issues found
5. Run aimv review -> confirm BAD_COUNT=0

---

## Juggl Block Prohibited Patterns

**Absolutely prohibited:**
- Inserting juggl blocks at arbitrary positions within markdown files
- Overwriting existing juggl block content (skip if already exists)
- Inserting juggl into files within `Domain/temp/agent_packets/` folder

**Correct location:** Directly below the H1 heading (no blank lines between)

---

## Issue Note Prohibited Patterns

- Using `ISS_*`, `ISSUE_*` prefixes is prohibited -> must use `DISS_*` or `SISS_*`
- Creating issue notes without updating the system index is prohibited
- Creating issue notes without frontmatter is prohibited
- Creating issue notes without a juggl block is prohibited

---

## Unauthorized Script Creation Prohibited

- Creating new scripts without checking `_Standards/Core/Script_Registry.md` is prohibited
- Placing duplicate-function scripts in `_tools/`, `_forge/` folders is prohibited
- Creating scripts without registering in `Script_Registry.md` is prohibited
- Hardcoding paths is prohibited — must use script-location-based auto-detection
- Detailed rules: `_Standards/Core/Script_Creation_Rule.md`

---

## General Prohibitions

- Modifying files without reading them first is prohibited
- Starting work without checking _WORKFLOW.md / _STATUS.md is prohibited
- Reporting completion before passing post-review is prohibited
- Directly filling the _STATUS.md master with tables is prohibited (maintain links only)
- Ending session without updating AGENT_STATUS.md is prohibited

---

> On violation: immediately stop work -> report to user -> recover and restart
