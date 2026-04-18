---
type: standards
tags:
  - AIMindVault
  - Meta
  - Standards
updated: 2026-03-17
---

# AI Agent Rule Index

> Location and summary of every rule that controls AI agent behavior.
> Rules are organized in three layers; each outer layer includes the inner ones.

---

## Layer 1: Shared mandatory rules (`.claude/rules/`)

Defined in the multi-vault root `.claude/rules/`. Loaded automatically by AI agents in every vault.
Obsidian hides this folder, but the table below lists its contents.

| Rule | File | Summary |
|------|------|---------|
| Edit mode separation | `edit-mode-separation.md` | No mixing Contents/workspace modes. Workspace edits are AIHubVault-only. Version logging required |
| Encoding safety | `encoding-safety.md` | UTF-8 fixed I/O only. Never rewrite Korean markdown via `Get-Content + Set-Content`. Bulk edits: dry-run → sample → full run |
| Post-Edit Review | `post-edit-review.md` | Run `post_note_edit_review.ps1` after each note edit. Do not report completion before `BAD=0` |
| Note-writing pattern | `note-writing.md` | Korean default, YYYY-MM-DD, required frontmatter (`type`, `tags`, `updated`), `[[WikiLink]]` usage |
| Script management | `script-management.md` | Check `Script_Registry.md` for duplicates before new scripts. No hardcoding. Update registry on create/delete |
| Script creation approval | `script-creation-approval.md` | User approval required before creating scripts. Report purpose, path, scope of impact, and whether one-off |
| Session exit | `session-exit.md` | Update `_STATUS.md` directly at session end (Now/Next/Blocked/Decisions). No exit without update |
| Temp file management | `temp-file-management.md` | Create temp files only under `$env:TEMP`. Do not leave them in the vault. Delete immediately after work |
| Token optimization | `token-optimization.md` | Pinpoint access, no repeated reads, no self-debug loops, pre-report high-cost tasks |
| Juggl style | `juggl-style-sync.md` | Update graph.css and style guide together. Insert Juggl embed under the note title |
| Distribution sync | `distribution-sync.md` | When shared rules/workspace change, check distribution scope. Log the change |

---

## Layer 2: Per-vault rules (`CLAUDE.md`)

Defined at each vault's root `CLAUDE.md`. Agents read it when entering the vault.

Covers:
- Vault role and derived-instance rules
- Session entry rules (required reading order)
- Edit mode separation (Contents/workspace targets, prohibitions, exceptions)
- Note-writing rules (language, date, frontmatter, Juggl)
- Safety rules (encoding, temp files, token optimization)
- Script management
- Edit completion gate (Post-Edit Review)
- Session exit rules

---

## Layer 3: Operations rules (`_WORKFLOW.md`)

Defined in the vault's `_WORKFLOW.md`. Governs the detailed operating procedures for agents.

Covers:
- Session bootstrap (required reading order)
- Agent roster and state-sharing rules
- Capacity / context-saving guide
- Tag operation rules
- Obsidian CLI bridge rules
- Edit mode separation details (Contents-mode reference order, internal branching)

---

## Agent entry points

| Agent | Entry point | Notes |
|-------|-------------|-------|
| Claude Code | `CLAUDE.md` | `.claude/rules/` auto-loaded |
| Claudian | `CLAUDE.md` + `systemPrompt` in `claudian-settings.json` | Contents-only, workspace forbidden |
| Codex | `CODEX.md` | `.codex/rules/` auto-loaded |

---

## When changing rules

- **Layer 1**: `.claude/rules/` — edit at the multi-vault root. Log version in `_ROOT_VERSION.md`
- **Layer 2**: `CLAUDE.md` — edit in AIHubVault. Log version in `_WORKSPACE_VERSION.md`
- **Layer 3**: `_WORKFLOW.md` — edit in AIHubVault. Log version in `_WORKSPACE_VERSION.md`
- Layers 2 and 3 propagate to other vaults via `sync_workspace.ps1`
- Layer 1 is distributed via the `distribution-sync` workflow
