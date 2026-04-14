---
type: status-hub
updated: 2026-04-08
---

# STATUS HUB — Multi-Vault Registry

> Full vault list and recent AI work log.
> For detailed work history, see each vault's `_STATUS.md`.
> At session start, review by most recent work date to understand current progress.

## Root Environment

Recent root-level changes: see `_ROOT_VERSION.md`

## Vault Registry

### BasicVaults

| Vault | Type | Content | Working Agent |
|-------|------|---------|---------------|
| AIHubVault | Hub | AI workspace design, improvement, and distribution source of truth | - |
| BasicContentsVault | Template | Vault clone template (do not edit directly) | - |

> Register new vaults in this registry as they are added.
> Vault creation: Use the `/create-vault` skill or `node cli.js clone`.

### Expansion Examples

When a new topic arises, add a vault under the appropriate category folder:

| Category | Path Pattern | Purpose |
|----------|-------------|---------|
| Domain | `Vaults/Domains_<area>/<vault-name>/` | Knowledge accumulation for a specific topic |
| Lab | `Vaults/Lab_<area>/<vault-name>/` | Hybrid: knowledge accumulation + active development |
| Project | `Vaults/Projects_<area>/<vault-name>/` | Project execution only |
| Personal | `Vaults/Personal/<vault-name>/` | Personal records |
| Reference | `References/<vault-name>/` | External reference materials (read-only) |
