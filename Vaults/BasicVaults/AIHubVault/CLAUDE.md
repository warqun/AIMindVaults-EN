---
tags:
  - AIHubVault
  - Meta
type: workflow
updated: 2026-04-15
agent: claude
---

# AIHubVault — AI workspace design / improvement / distribution Hub

> Every AI agent in this vault uses this file as its entry point.
> Agent-specific entry points: Codex → `AGENTS.md`

## Role of this vault

**Hub for designing, improving, and distributing the AI workspace.** This is where `_Standards/`, `.sync/_tools/`, `.claude/`, etc. — the AI operational structure — are authored and from which they propagate to every other vault.

> This vault is a workspace-only Hub. Content (domain knowledge, project notes) lives in other topic-specific vaults.

## Derived-instance rule

This vault can be cloned via `aimv clone` to create other vaults.

1. Cloned vaults still follow every shared rule in this CLAUDE.md.
2. **Workspace-mode edits happen only in AIHubVault.** Other vaults receive `_Standards/`, `.sync/_tools/`, `Juggl_StyleGuide/` via Hub-Sync — treat them as read-only there.
3. In other vaults, only `Contents/**` is freely editable.

---

## Session entry rules (mandatory)

Before starting any work, read the following in order:

1. `_STATUS.md` — current focus / next / blocked.
2. This file (`CLAUDE.md`) — vault role and rules.
3. `_VAULT-INDEX.md` — document locations.

**Don't start work without completing the pre-read.**

---

## Edit-mode separation (mandatory)

Every edit is made in exactly one mode. Declare the mode explicitly. Don't mix modes in a single task.

### Contents mode

> **This vault is a workspace-only Hub.** Put content in topic-specific vaults instead — see the root `CLAUDE.md` registry for routing.

### Workspace mode (AIHubVault only)

- **Scope**: `_Standards/`, `.sync/_tools/`, `.claude/`, `.codex/`, `Tags/`, `Juggl_StyleGuide/`, vault root files.
- **Forbidden**: editing `Contents/**` content body.
- **Exception**: bulk frontmatter / metadata updates under `Contents/` are treated as workspace work.
- After editing, record a version in `_WORKSPACE_VERSION.md` (format: `YYYYMMDDNNNN`) — mandatory.
- Don't report a workspace task as complete without the version entry.

### Mode-operation rules

1. **Declare the mode at task start**: `[Contents/Domain]`, `[Contents/Project]`, or `[workspace]`.
2. **Declare mode switches explicitly**: finish the previous mode's edits first.
3. **User instruction spans modes**: split into per-mode tasks and run them sequentially.

---

## Note-writing rules

- **Language**: default English. Keep code / identifiers / paths as-is.
- **Dates**: YYYY-MM-DD only.
- **Structure**: one H1 title. Use `[[WikiLink]]` for internal links.
- **Frontmatter required**: every note begins with YAML frontmatter (`---`).
  - `type`, `tags` (include the vault tag), and `updated` or `created` are mandatory.
  - When creating a new folder, register it in `_VAULT-INDEX.md`.
- **Juggl embed**: place directly under the H1. Exceptions: `_STATUS.md`, `_VAULT-INDEX.md`, files under `.claude/`.

```juggl
local: note_filename
```

---

## Safety rules

### Encoding

- Run encoding validation before any bulk Contents edit.
- Bulk-edit scripts use UTF-8 fixed I/O only.
- Never rewrite markdown with a `Get-Content → Set-Content` pipeline.
- Bulk replace: dry-run → 3-file sample → full run.

### Temp files

- Create CLI temp files only under `$env:TEMP` (or the OS equivalent).
- Don't leave `.vtt`, `.json`, `.srt`, `.tmp`, `.log`, etc. at the vault root.
- Delete temp artifacts after the job; don't report completion before deletion is confirmed.

### Token economy

- **Pinpoint access**: read exactly the files you need. No broad scanning.
- **No re-reading**: once read, remember and reference — don't re-read the same file.
- **Report costly work up-front**: bulk scans, many-script runs, etc. need user approval first.

---

## Script management

- Before creating a script, check `_Standards/Core/Script_Registry.md` for duplicates.
- **Script creation requires user approval.** Report purpose, path, impact, and whether it's one-shot.
- No hard-coded paths — auto-detect based on script location.
- Register the script after creation. On deletion, move the entry to the "Deleted scripts" section.

---

## Edit-completion gate

After a note edit, always run:

```bash
node .sync/_tools/cli-node/bin/cli.js review
```

Don't report completion until `POST_EDIT_REVIEW_BAD=0`.

---

## Session-exit rule

On session exit, update this vault's `_STATUS.md` directly:
- **Now**: what you completed / are mid-way through.
- **Next**: what to pick up next.
- **Blocked**: blockers (or "none").
- **Decisions**: decisions made this session, with `(YYYY-MM-DD)`.

**Don't end a session without updating `_STATUS.md`.**

---

## Detailed rule references

- `_Standards/Core/AI_Rules_Index.md` — full AI-agent rule index.
- `_Standards/Core/` — shared operational standards.
- `_WORKFLOW.md` — full operational rules.
