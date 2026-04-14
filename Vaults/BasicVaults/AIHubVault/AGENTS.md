# AIHubVault — AI Workspace Design, Improvement, and Distribution Hub (Codex)

> Codex desktop app / CLI dedicated entry point.
> For Claude Code, see `CLAUDE.md`.
> Common mandatory rules: auto-applied from root `.claude/rules/`.

## Common Rules (Canonical Reference — Mandatory)

Read and follow **all rule files** in the root `.claude/rules/` directory.
Also reference the vault `CLAUDE.md` rules.

## Agent Identifier

- **Identifier**: `codex`
- Record as `codex / YYYY-MM-DD` at session end

## This Vault's Role

**AI workspace design, improvement, and distribution hub** — The source (Hub) that designs AI operational structures such as `_Standards`, `_tools`, `.claude`, `_forge` and distributes them to other vaults.

## Session Start Sequence

1. Read all root `.claude/rules/` — common mandatory rules (canonical)
2. `.codex/rules/` — Codex-specific rules
3. Check `_STATUS.md` — current focus/next/blocking
4. Check `.codex/AGENT_STATUS.md` — my last work status
5. `_VAULT-INDEX.md` — document location reference

Complete the above sequence before any editing.

## Edit Mode Separation (Mandatory)

All edits must declare one of the following modes before proceeding. Mode mixing is prohibited.

### Contents Mode

- **`[Contents/Domain]`**: `Contents/Domain/**` knowledge accumulation
- **`[Contents/Project]`**: `Contents/Project/**` work management
- Prohibited: `_Standards/`, `_tools/`, `.claude/`, `.codex/`, `_forge/`, vault root files

### Workspace Mode (AIHubVault Only)

- Target: `_Standards/`, `_tools/`, `.claude/`, `.codex/`, `_forge/`, `Tags/`, `Juggl_StyleGuide/`, vault root files
- Prohibited: `Contents/**` content modification
- Must record version in `_WORKSPACE_VERSION.md` after modification

## Derived Instance Rules

- Workspace mode editing is performed only in this vault (AIHubVault)
- Other vaults' `_Standards/`, `_tools/`, `Juggl_StyleGuide/` are auto-distributed via Hub-Sync — read-only
- Other vaults can freely edit `Contents/**` only

## Codex-Specific Rules

| File | Purpose |
|------|------|
| `.codex/rules/never-do.md` | Prohibited actions list |
| `.codex/rules/note-writing.md` | Note writing rules |
| `.codex/rules/bulk-edit-safety.md` | Bulk edit safety |

## Skills

| Skill | Purpose |
|------|------|
| `.codex/skills/session-end/` | Session end procedure |
| `.codex/skills/juggl-insert/` | Juggl embed insertion |

## Priorities

- Rule compliance > speed
- Minimal edits > broad edits
- Verified completion > quick completion report

## Session End

Must update both vault `_STATUS.md` + root `_STATUS.md`.
