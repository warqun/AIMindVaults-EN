# AIHubVault — AI workspace design / improvement / distribution Hub (Codex)

> Entry point for the Codex desktop app / CLI.
> Claude Code → see `CLAUDE.md`.
> Shared mandatory rules: auto-applied from the root `.claude/rules/`.

## Shared rules (canonical reference — Mandatory)

Read and follow every rule file under the root `.claude/rules/`.
Also honor the rules in this vault's `CLAUDE.md`.

## Agent identifier

- **Identifier**: `codex`
- Record as `codex / YYYY-MM-DD` at session exit.

## Role of this vault

**Hub for designing, improving, and distributing the AI workspace** — authors `_Standards/`, `.sync/_tools/`, `.claude/`, etc. and propagates them to every other vault.

## Session start order

1. Read everything under root `.claude/rules/` — shared mandatory rules (canonical).
2. `.codex/rules/` — Codex-specific rules.
3. `_STATUS.md` — current focus / next / blocked.
4. `.codex/AGENT_STATUS.md` — your last work state.
5. `_VAULT-INDEX.md` — document locations.

Complete this sequence before editing.

## Edit-mode separation (mandatory)

Every edit declares exactly one mode. No mixing.

### Contents mode

- **`[Contents/Domain]`**: knowledge accumulation under `Contents/Domain/**`.
- **`[Contents/Project]`**: project work under `Contents/Project/**`.
- Forbidden: `_Standards/`, `.sync/_tools/`, `.claude/`, `.codex/`, vault root files.

### Workspace mode (AIHubVault only)

- Scope: `_Standards/`, `.sync/_tools/`, `.claude/`, `.codex/`, `Tags/`, `Juggl_StyleGuide/`, vault root files.
- Forbidden: body edits in `Contents/**`.
- Record a version in `_WORKSPACE_VERSION.md` after editing — mandatory.

## Derived-instance rule

- Workspace-mode edits happen only in this vault (AIHubVault).
- In other vaults, `_Standards/`, `.sync/_tools/`, `Juggl_StyleGuide/` are read-only (auto-distributed by Hub-Sync).
- Other vaults edit `Contents/**` freely.

## Codex-specific rules

| File | Purpose |
|------|---------|
| `.codex/rules/never-do.md` | Forbidden actions |
| `.codex/rules/note-writing.md` | Note-writing rules |
| `.codex/rules/bulk-edit-safety.md` | Bulk-edit safety |

## Skills

| Skill | Purpose |
|-------|---------|
| `.codex/skills/session-end/` | Session-exit procedure |
| `.codex/skills/juggl-insert/` | Insert a Juggl embed |

## Priorities

- Rule compliance > speed.
- Minimal edits > sweeping edits.
- Verified completion > fast "done" report.

## Session exit

Update both the vault `_STATUS.md` and the root `_STATUS.md` — both are required.
