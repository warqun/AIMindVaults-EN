# BasicContentsVault — Vault Clone Source Template (Codex)

> Codex-only entry point. For Claude Code see `CLAUDE.md`.
> Shared mandatory rules: automatically applied from the root `.claude/rules/`.

## Shared rules (authoritative reference — Mandatory)

Read and follow **every rule file** under the root `.claude/rules/` directory.
Also reference this vault's `CLAUDE.md`.

## Note: do not edit this vault directly

This vault is the clone source template used by the `/create-vault` skill.
- No direct content work
- The workspace is synced from AIHubVault via `sync_workspace.ps1`

## When the vault is NOT named BasicContentsVault

The vault has been cloned but not yet customized. Immediately:
1. Update the title / role of this AGENTS.md to match the actual use case.
2. Do the same for `CLAUDE.md` and `_STATUS.md`.
3. Register this vault in the root `_STATUS.md` vault registry.

## Agent identifier

- **Identifier**: `codex`

## Codex-specific rules

| File | Purpose |
|------|---------|
| `.codex/rules/never-do.md` | List of prohibitions |
| `.codex/rules/note-writing.md` | Note authoring rules |
| `.codex/rules/bulk-edit-safety.md` | Bulk-edit safety |
