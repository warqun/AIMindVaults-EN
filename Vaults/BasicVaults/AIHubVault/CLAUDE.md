---
tags:
  - AIMindVault
  - Meta
type: workflow
updated: 2026-03-17
agent: claude
---

# AIHubVault — AI Workspace Design, Improvement & Distribution Hub

> All AI agents in this vault (Claude Code, Claudian, Codex, Cursor) use this document as their entry point.
> Additional entry points per agent: Codex -> `CODEX.md` / Antigravity -> `.antigravity/SESSION_RULES.md` / Cursor -> `.cursor/rules/`

## Role of This Vault

**AI Workspace Design, Improvement & Distribution Hub** — Designs AI operational structures such as `_Standards`, `_tools`, `.claude`, `.forge`, and distributes them to other vaults as the single source of truth (Hub).

> **Content Separation Complete (2026-03-21)**: Former Contents/Domain/ moved to `Vaults/Domains_Infra/AI/`, Contents/Project/ moved to `Vaults/Projects_Infra/Project_AIMindVaults/`. This vault now operates as a workspace-only Hub.

## Derived Instance Rules

This vault can be cloned via `aimv clone` and used as a vault for different purposes.

1. **Cloned vaults also follow all common rules (sections below) from this CLAUDE.md.**
2. **Workspace mode editing is performed only in this vault (AIHubVault).** Other vaults' `_Standards/`, `_tools/`, `Juggl_StyleGuide/` are auto-distributed via Hub-Sync and are read-only.
3. **In other vaults, only `Contents/**` can be freely edited.**

---

## Session Entry Rules (Mandatory)

Before any task, you must read the following in order:

1. `_STATUS.md` — Understand current focus/next/blockers
2. This document (`CLAUDE.md`) — Confirm vault role and rules
3. `_VAULT-INDEX.md` — Understand document locations

**Do not start any work without completing the pre-read procedure.**

---

## Edit Mode Separation (Mandatory)

All edits must be performed after **explicitly declaring** one of the modes below. Mode mixing is prohibited.

### Contents Mode

> **This vault is a workspace-only Hub.** Content work should be done in the following vaults:
> - AI domain knowledge -> `Vaults/Domains_Infra/AI/`
> - AIMindVaults project -> `Vaults/Projects_Infra/Project_AIMindVaults/`

### workspace Mode (AIHubVault Only)

- **Scope**: `_Standards/`, `_tools/`, `.claude/`, `.codex/`, `.forge/`, `Tags/`, `Juggl_StyleGuide/`, vault root files
- **Prohibited**: Modifying `Contents/**` body content
- **Exception**: Batch frontmatter tag/metadata updates within `Contents/` are allowed as workspace work
- After modification, version must be recorded in `_WORKSPACE_VERSION.md` (format: `YYYYMMDDNNNN`)
- Do not report workspace work as complete without recording the version

### Mode Operation Rules

1. **Declare mode at work start**: Specify `[Contents/Domain]`, `[Contents/Project]`, or `[workspace]`
2. **Explicit declaration when switching modes**: Switch only after previous mode edits are complete
3. **When user instructions span multiple modes**: Separate by mode and execute sequentially

---

## Note Writing Rules

- **Language**: English by default. Keep code/identifiers/paths in their original form.
- **Dates**: Use YYYY-MM-DD format only.
- **Structure**: One H1 heading. Use `[[WikiLink]]` for internal links.
- **Frontmatter Required**: All notes must start with YAML Frontmatter (`---`).
  - `type`, `tags` (including vault tag), `updated` or `created` are required.
  - Register new folders in `_VAULT-INDEX.md`.
- **Juggl Embed**: Insert directly below the title. Exceptions: `_STATUS.md`, `_VAULT-INDEX.md`, files within `.claude/`.

```juggl
local: Note_Title
```

---

## Safety Rules

### Encoding

- Encoding verification is required before bulk `Contents` modifications.
- Bulk modifications must use UTF-8 fixed I/O only.
- Never rewrite markdown with `Get-Content + Set-Content` pipeline.
- Bulk replacement: dry-run -> 3-file sample -> full execution.

### Temporary Files

- Temporary files from CLI commands must be created only under `$env:TEMP`.
- Do not leave `.vtt`, `.json`, `.srt`, `.tmp`, `.log` or other temporary files in the vault root.
- Delete immediately after work completion; do not report completion before confirming deletion.

### Token Conservation

- **Pinpoint access**: Read only the specific files needed. No broad exploration.
- **No repeated reads**: Remember content from first read and reuse.
- **Report high-cost operations in advance**: Get user approval before bulk file scans, multiple script executions, etc.

---

## Script Management

- Check `_Standards/Core/Script_Registry.md` for duplicates before creating new scripts.
- **User approval is required for script creation.** Report purpose, path, scope of impact, and whether it's one-time.
- No hardcoded paths — use script-location-based auto-detection.
- Register in Script_Registry.md after creation. Move to "Deleted Scripts" section on deletion.

---

## Edit Completion Gate

After completing note edits, you must run:
```bash
node .sync/_tools/cli-node/bin/cli.js review
```
Do not report completion before confirming `POST_EDIT_REVIEW_BAD=0`.

---

## Session Exit Rules

At session end, **directly update** the vault's `_STATUS.md`:
- **Now**: Tasks completed or in progress this session
- **Next**: Tasks to continue next
- **Blocked**: Blockers (or "None")
- **Decisions**: Decisions made this session (`(YYYY-MM-DD)` format)

**Do not end the session without updating `_STATUS.md`.**

---

## Detailed Rules Reference

For detailed content of the above rules, refer to:
- `_Standards/Core/AI_Rules_Index.md` — Complete AI agent rules index
- `_Standards/Core/` — Common operational standards
- `_WORKFLOW.md` — Full operational rules
