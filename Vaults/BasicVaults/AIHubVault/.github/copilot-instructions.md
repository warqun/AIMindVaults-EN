# GitHub Copilot — AIMindVault Instructions

> This file is the auto-load file exclusively for **GitHub Copilot** (VSCode extension).
> If using the OpenAI Codex VSCode extension, the actual auto-load file is `AGENTS.md` at the project root.

---

## Role

The role of Codex (GitHub Copilot) in this workspace:
- Dedicated to **structuring, contract documents, and Vault organization**
- Documenting and formalizing content designed by Claude (Claudian)
- Bulk modification tasks (tag normalization, Juggl insertion, etc.)

---

## Absolute Prohibitions (Violation = File Corruption)

### Encoding
```powershell
# Prohibited
Get-Content file.md | Set-Content file.md
Get-Content file.md -Raw | Set-Content file.md
# Allowed
$t = [System.IO.File]::ReadAllText($p, [Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($p, $t, [Text.UTF8Encoding]::new($false))
```

### Bulk Modifications
- Global replacement on all files at once is prohibited
- Must follow: Dry-run -> 3 samples -> full execution order

---

## Files to Read at Session Start

1. `.codex/rules/never-do.md`
2. `_WORKFLOW.md`
3. `_STATUS.md`
4. `.codex/AGENT_STATUS.md`

---

## Detailed Rule Locations

- `.codex/rules/never-do.md` — Absolute prohibitions list
- `.codex/rules/note-writing.md` — Frontmatter / Juggl rules
- `.codex/rules/bulk-edit-safety.md` — Bulk edit safety protocol

## Playbook Locations

- `.codex/playbooks/juggl-insert.md` — Juggl block insertion
- `.codex/playbooks/session-end.md` — Session end checklist

---

## Edit Mode Separation (Mandatory)

All edits belong to one of two modes. Mixing is prohibited.

- **`[Domain]` mode**: Modify only `Domain/**` content. Modifying workspace files is prohibited.
- **`[workspace]` mode**: Modify vault infrastructure (`_Standards/`, `_tools/`, `.claude/`, `.codex/`, `_forge/`, `Tags/`, vault root files). Modifying `Domain/**` body content is prohibited.
- Mode declaration is required at work start. Explicit declaration required when switching.
- Detailed rules: `_WORKFLOW.md` § 6)

---

## Edit Completion Gate (Mandatory)

After editing notes, you must run:
```bash
node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
```
Do not report completion before confirming `POST_EDIT_REVIEW_BAD=0`.
