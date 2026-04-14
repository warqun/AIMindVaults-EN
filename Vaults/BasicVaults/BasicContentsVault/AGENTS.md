# BasicContentsVault — Vault Clone Source Template (Codex)

> Codex-specific entry point. For Claude Code, see `CLAUDE.md`.
> Common mandatory rules: Auto-applied from root `.claude/rules/`.

## Common Rules (Canonical Reference — Mandatory)

Read and follow **all rule files** in the root `.claude/rules/` directory.
Also refer to the vault `CLAUDE.md`.

## Warning: Do Not Edit This Vault Directly

This vault is the **clone source template** for the `/create-vault` skill.
- Do not create content directly in this vault
- Workspace is synced from AIHubVault via `sync_workspace.ps1`

## If the Vault Name Is Not BasicContentsVault

The vault was cloned but initial setup has not been completed. Immediately:
1. Update the title/role in this AGENTS.md to match the actual purpose
2. Update `CLAUDE.md` and `_STATUS.md` similarly
3. Register in the root `_STATUS.md` vault registry

## Agent Identifier

- **Identifier**: `codex`

## Codex-Specific Rules

| File | Purpose |
|------|---------|
| `.codex/rules/never-do.md` | Banned actions |
| `.codex/rules/note-writing.md` | Note writing rules |
| `.codex/rules/bulk-edit-safety.md` | Bulk edit safety |
