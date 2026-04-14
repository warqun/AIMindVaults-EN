---
type: standards
tags:
  - TileMapToolKit
  - AIMindVault
  - Meta
  - Standards
updated: 2026-03-17
---

# AI Agent Rules Index

> Location and summary of all rules controlling AI agent behavior.
> Rules are organized in a 3-tier hierarchy, where higher tiers encompass lower ones.

---

## Tier 1: Shared Mandatory Rules (`.claude/rules/`)

Defined in `.claude/rules/` at the multi-vault root. Automatically loaded by AI agents across all vaults.
These are hidden folders in Obsidian, but the list below provides visibility.

| Rule | File | Summary |
|------|------|---------|
| Edit Mode Separation | `edit-mode-separation.md` | No mixing Contents/workspace modes. Workspace edits are AIHubVault-only. Version logging required |
| Encoding Safety | `encoding-safety.md` | UTF-8 fixed I/O only. No rewriting Korean markdown with `Get-Content + Set-Content`. Bulk edits: dry-run, sample, then full |
| Post-Edit Review | `post-edit-review.md` | Run `post_note_edit_review.ps1` after note edits. No completion report before `BAD=0` confirmed |
| Note Writing Patterns | `note-writing.md` | Default language Korean, YYYY-MM-DD dates, Frontmatter required (`type`, `tags`, `updated`), use `[[WikiLink]]` |
| Script Management | `script-management.md` | Check `Script_Registry.md` for duplicates before new scripts. No hardcoding. Update registry on create/delete |
| Script Creation Approval | `script-creation-approval.md` | User approval required before script creation. Report purpose, path, scope, and persistence |
| Session Exit | `session-exit.md` | Update `_STATUS.md` directly on session exit (Now/Next/Blocked/Decisions). No exit without update |
| Temp File Management | `temp-file-management.md` | Temp files only under `$env:TEMP`. No leaving temp files in vault. Delete immediately after completion |
| Token Optimization | `token-optimization.md` | Pinpoint access only, no repeated reads, no self-debugging loops, pre-report high-cost operations |
| Juggl Style | `juggl-style-sync.md` | Update graph.css and style guide simultaneously. Insert Juggl embed below note title |
| Distribution Sync | `distribution-sync.md` | Check distribution scope when changing shared rules/workspace. Log changes |

---

## Tier 2: Per-Vault Rules (`CLAUDE.md`)

Defined in each vault's root `CLAUDE.md`. Read by agents upon vault entry.

Includes:
- Vault role and derived instance rules
- Session entry rules (required read order)
- Edit mode separation (Contents/workspace targets, restrictions, exceptions)
- Note writing rules (language, dates, Frontmatter, Juggl)
- Safety rules (encoding, temp files, token optimization)
- Script management
- Edit completion gate (Post-Edit Review)
- Session exit rules

---

## Tier 3: Operational Rules (`_WORKFLOW.md`)

Defined in each vault's `_WORKFLOW.md`. Governs detailed agent operational procedures.

Includes:
- Session bootstrap (pre-read sequence)
- Agent list and state sharing rules
- Capacity/context optimization guide
- Tag operation rules
- Obsidian CLI bridge rules
- Edit mode separation details (Contents mode reference order, internal branching)

---

## Agent Entry Points

| Agent | Entry Point | Notes |
|-------|-------------|-------|
| Claude Code | `CLAUDE.md` | `.claude/rules/` auto-loaded |
| Claudian | `CLAUDE.md` + `claudian-settings.json` systemPrompt | Contents only, workspace prohibited |
| Codex | `CODEX.md` | `.codex/rules/` auto-loaded |
| Antigravity | `.antigravity/SESSION_RULES.md` | Research/investigation specialized |
| Cursor | `.cursor/rules/` (auto-loaded) | Code editing/refactoring |

---

## Caution When Changing Rules

- **Tier 1**: `.claude/rules/` — Edit at multi-vault root. Log version in `_ROOT_VERSION.md`
- **Tier 2**: `CLAUDE.md` — Edit in AIHubVault. Log version in `_WORKSPACE_VERSION.md`
- **Tier 3**: `_WORKFLOW.md` — Edit in AIHubVault. Log version in `_WORKSPACE_VERSION.md`
- Tiers 2 and 3 are auto-propagated to other vaults via `sync_workspace.ps1`
- Tier 1 is distributed via the `distribution-sync` workflow
