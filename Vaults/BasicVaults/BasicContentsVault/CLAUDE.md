---
tags:
  - Meta
type: workflow
updated: 2026-04-15
---

# BasicContentsVault — Vault Clone Source Template

> **This vault is the clone source (template) used by the `/create-vault` skill.**
> Do not perform content work here directly. Use only when creating a new vault.

## When the vault is named BasicContentsVault

This vault is the clone source template for `/create-vault`.
- No direct content work
- The workspace is synced from AIHubVault via `sync_workspace.ps1`
- Related: `/create-vault` skill

## When the vault is NOT named BasicContentsVault

The vault has been cloned but not yet customized. **Do the following immediately:**
1. Update the title / role / structure of this CLAUDE.md to match the new vault's purpose.
2. Update the vault's role in `_STATUS.md` in the same way.
3. Register this vault in the root `_STATUS.md` vault registry (if not already registered).
