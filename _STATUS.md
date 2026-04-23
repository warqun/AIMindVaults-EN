---
type: status-hub
updated: 2026-04-22
---

# STATUS HUB — Multi-Vault Registry

> Full vault list and recent AI work log.
> For detailed work history, see each vault's `_STATUS.md`.
> At session start, review by most recent work date to understand current progress.

## Root Environment

Recent root-level changes: see `_ROOT_VERSION.md`

## Vault Registry

### BasicVaults

| Vault | Type | Path | Content | Working Agent |
|-------|------|------|---------|---------------|
| CoreHub | Core Hub | `Vaults/BasicVaults/CoreHub/` | **Core-layer source of truth** (CLI, _Standards/Core, schemas, Core 6 plugins). Multi-Hub Phase 1 (2026-04-20). `core-sync-all --broadcast` pushes to every Preset Hub. hubType=core, hubId=core | claude / 2026-04-20 |
| AIHubVault | Preset Hub (default) | `Vaults/BasicVaults/AIHubVault/` | **Default Preset Hub** (hubId=default). Receives Core layer + manages Custom bundle (Juggl, make-md, obsidian-git, mcp-tools, etc.). Satellite vaults bind here. Source of truth for AI workspace design/improvement/distribution. | - |
| AIHubVault_Minimal | Preset Hub (minimal) | `Vaults/BasicVaults/AIHubVault_Minimal/` | Minimal Preset Hub (hubId=minimal). Core 6 plugins only, no Custom. Satellite bindings optional. | claude / 2026-04-20 |
| BasicContentsVault | Template | `Vaults/BasicVaults/BasicContentsVault/` | General-purpose vault template. Clone source for `/create-vault` — do not edit content directly. Not a Hub. | - |

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
