# GitHub Copilot — AIMindVault Instructions

> This file is the auto-loaded instruction file for the **GitHub Copilot** (VSCode extension).
> If you use the OpenAI Codex VSCode extension instead, the auto-loaded file is `AGENTS.md` at the project root.

---

## Role

Codex / GitHub Copilot's role in this workspace:
- Structuring, contract documents, and Vault organization
- Documenting and normalizing what Claude (Claudian) designs
- Bulk edits (tag normalization, Juggl insertion, etc.)

---

## Absolute prohibitions (violations corrupt files)

### Encoding
```powershell
# Forbidden
Get-Content file.md | Set-Content file.md
Get-Content file.md -Raw | Set-Content file.md
# Allowed
$t = [System.IO.File]::ReadAllText($p, [Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($p, $t, [Text.UTF8Encoding]::new($false))
```

### Bulk edits
- No global replace across every file at once.
- Always follow: Dry-run → 3-file sample → full run.

---

## Files to read at session start

1. `.codex/rules/never-do.md`
2. `_WORKFLOW.md`
3. `_STATUS.md`
4. `.codex/AGENT_STATUS.md`

---

## Rule file locations

- `.codex/rules/never-do.md` — list of absolute prohibitions
- `.codex/rules/note-writing.md` — frontmatter / Juggl rules
- `.codex/rules/bulk-edit-safety.md` — bulk-edit safety protocol

## Playbook locations

- `.codex/playbooks/juggl-insert.md` — Juggl block insertion
- `.codex/playbooks/session-end.md` — session-end checklist

---

## Edit-mode separation (mandatory)

Every edit belongs to exactly one of two modes. Mixing is forbidden.

- **`[Domain]` mode**: modify only `Domain/**` content. Forbidden to touch workspace files.
- **`[workspace]` mode**: modify vault infrastructure (`_Standards/`, `_tools/`, `.claude/`, `.codex/`, `Tags/`, vault root files). Forbidden to edit `Domain/**` content bodies.
- Declare the mode at the start of work. Declare explicitly when switching.
- Details: `_WORKFLOW.md` § 6).

---

## Edit completion gate (mandatory)

After every note edit:
```bash
node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
```
Do not report completion until `POST_EDIT_REVIEW_BAD=0`.
