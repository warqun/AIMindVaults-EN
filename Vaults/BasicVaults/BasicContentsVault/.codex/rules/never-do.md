# CODEX absolute-ban list (top-priority rules)

> Read this file before any work starts.
> Violating any of these causes file corruption / history-restore work.

---

## 🚫 Encoding bans (Korean markdown)

**Never use:**
```powershell
# Forbidden — default encoding mangles Korean
Get-Content file.md | Set-Content file.md
Get-Content file.md -Raw | ... | Set-Content file.md
Add-Content file.md "..."
```

**Use only this:**
```powershell
# Safe — fixed UTF-8 I/O
$text = [System.IO.File]::ReadAllText($path, [Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($path, $text, [Text.UTF8Encoding]::new($false))
```

---

## 🚫 Bulk-edit forbidden patterns

**Never use:**
```powershell
# Forbidden — global replace across all files at once
Get-ChildItem Domain/**/*.md | ForEach { ... Set-Content ... }
```

**Follow this order:**
1. Dry-run (no edits, only print the target file list)
2. Apply to 3 sample files first
3. Visually check samples in Obsidian
4. Full run only when clean
5. Run aimv review → confirm BAD_COUNT=0

---

## 🚫 Juggl block forbidden patterns

**Never use:**
- Inserting a juggl block at an arbitrary position inside a markdown file
- Overwriting an existing juggl block's content (if it exists, skip)
- Inserting juggl into files under `Domain/temp/agent_packets/`

**Correct position:** directly below the H1 title (no blank lines between)

---

## 🚫 Issue-note forbidden patterns

- Do not use prefixes `ISS_*`, `ISSUE_*` → always use `DISS_*` or `SISS_*`
- Do not skip updating the system index after creating an issue note
- Do not create issue notes without frontmatter
- Do not create issue notes without a juggl block

---

## 🚫 Unsanctioned script creation

- Do not create new scripts without checking `_Standards/Core/Script_Registry.md`
- Do not place duplicate-function scripts in `_tools/`
- Do not skip registering a new script in `Script_Registry.md`
- Do not hardcode paths — always use script-location-based auto-detection
- Details: `_Standards/Core/Script_Creation_Rule.md`

---

## 🚫 General bans

- Do not edit a file without reading it first
- Do not start work before checking _WORKFLOW.md / _STATUS.md
- Do not report completion before post-review passes
- Do not fill the _STATUS.md master with tables directly (keep links only)
- Do not end a session without updating AGENT_STATUS.md

---

> On violation: stop immediately → report to user → recover → restart
