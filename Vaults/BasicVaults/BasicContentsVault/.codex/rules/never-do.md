# CODEX Absolute Prohibition List (Highest Priority Rules)

> This file must be read before starting any work.
> Violating any item below will cause file corruption and require history recovery.

---

## Encoding Prohibitions (Markdown with CJK/Unicode)

**Absolutely prohibited:**
```powershell
# PROHIBITED — Default encoding causes character corruption
Get-Content file.md | Set-Content file.md
Get-Content file.md -Raw | ... | Set-Content file.md
Add-Content file.md "..."
```

**Must use only this method:**
```powershell
# SAFE — Fixed UTF-8 I/O
$text = [System.IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($path, $text, [Text.UTF8Encoding]::new($false))
```

---

## Bulk Edit Prohibition Patterns

**Absolutely prohibited:**
```powershell
# PROHIBITED — Global replacement on all files at once
Get-ChildItem Domain/**/*.md | ForEach { ... Set-Content ... }
```

**Must follow this order:**
1. Dry-run (output target file list only, no modifications)
2. Apply to sample of 3 files first
3. Visual verification in Obsidian on samples
4. Full run only when no issues found
5. Run aimv review -> Confirm BAD_COUNT=0

---

## Juggl Block Prohibition Patterns

**Absolutely prohibited:**
- Inserting juggl blocks at arbitrary positions in markdown files
- Overwriting existing juggl block content (skip if exists)
- Inserting juggl into files in `Domain/temp/agent_packets/` folder

**Correct position:** Directly below H1 heading (no blank lines between)

---

## Issue Note Prohibition Patterns

- Using `ISS_*`, `ISSUE_*` prefixes is prohibited -> Must use `DISS_*` or `SISS_*`
- Creating issue notes without updating system index is prohibited
- Creating issue notes without frontmatter is prohibited
- Creating issue notes without juggl blocks is prohibited

---

## Unauthorized Script Creation Prohibited

- Creating new scripts without checking `_Standards/Core/Script_Registry.md` is prohibited
- Placing duplicate-function scripts in `_tools/`, `_forge/` folders is prohibited
- Creating scripts without registering in `Script_Registry.md` is prohibited
- Hardcoding paths is prohibited — Must use script-location-based auto-detection
- Detailed rules: `_Standards/Core/Script_Creation_Rule.md`

---

## General Prohibitions

- Modifying files without reading them first is prohibited
- Starting work without checking _WORKFLOW.md / _STATUS.md is prohibited
- Reporting completion before passing post-review is prohibited
- Directly filling _STATUS.md master with table content is prohibited (maintain links only)
- Ending session without updating AGENT_STATUS.md is prohibited

---

> On violation: immediately stop work -> report to user -> recover then restart
