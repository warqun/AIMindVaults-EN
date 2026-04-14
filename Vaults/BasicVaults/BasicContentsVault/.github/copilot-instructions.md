# GitHub Copilot — AIMindVault Instructions

> This file is the **GitHub Copilot** (VSCode extension) auto-load file.
> If using the OpenAI Codex VSCode extension, the actual auto-load file is `AGENTS.md` in the project root.

---

## Role

Codex (GitHub Copilot) role in this workspace:
- **Dedicated to structuring, contract documents, and Vault organization**
- Documenting and normalizing content designed by Claude (Claudian)
- Bulk editing tasks (tag normalization, Juggl insertion, etc.)

---

## Absolute Prohibitions (Violation Causes File Corruption)

### Encoding
```powershell
# PROHIBITED
Get-Content file.md | Set-Content file.md
Get-Content file.md -Raw | Set-Content file.md
# ALLOWED
$t = [System.IO.File]::ReadAllText($p, [Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($p, $t, [Text.UTF8Encoding]::new($false))
```

### Bulk Edits
- Global replacement on all files at once is prohibited
- Must follow: Dry-run -> 3 samples -> full run order

---

## Files to Read at Session Start

1. `.codex/rules/never-do.md`
2. `_WORKFLOW.md`
3. `_STATUS.md`
4. `.codex/AGENT_STATUS.md`

---

## Detailed Rule Locations

- `.codex/rules/never-do.md` — Absolute prohibition list
- `.codex/rules/note-writing.md` — Frontmatter / Juggl rules
- `.codex/rules/bulk-edit-safety.md` — Bulk edit safety protocol

## Playbook Locations

- `.codex/playbooks/juggl-insert.md` — Juggl block insertion
- `.codex/playbooks/session-end.md` — Session end checklist

---

## Edit Mode Separation (Mandatory)

All edits belong to one of two modes. Mixing is prohibited.

- **`[Domain]` mode**: Only modify `Domain/**` content. Modifying workspace files is prohibited.
- **`[workspace]` mode**: Modify vault infrastructure (`_Standards/`, `_tools/`, `.claude/`, `.codex/`, `_forge/`, `Tags/`, vault root files). Modifying `Domain/**` body content is prohibited.
- Mode declaration is required at work start. Switching requires explicit declaration.
- Detailed rules: `_WORKFLOW.md` section 6)

---

## Edit Completion Gate (Mandatory)

After note editing, must run:
```bash
node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
```
Do not report completion before `POST_EDIT_REVIEW_BAD=0`.
