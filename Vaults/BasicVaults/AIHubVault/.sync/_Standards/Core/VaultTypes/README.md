---
type: standard
tags:
  - TileMapToolKit
  - AIMindVault
  - core
updated: 2026-03-11
---

# VaultTypes — Vault Type Comparison Index

This vault system provides two prototypes.
Users set up vaults manually.

## Type Comparison

| Item | domain | project |
|------|--------|---------|
| **Purpose** | Domain knowledge accumulation (PKM) | Goal achievement (task management) |
| **Spec Document** | [[VAULTTYPE_DOMAIN]] | [[VAULTTYPE_PROJECT]] |
| **Content Root** | `Contents/Domain/` | `Contents/Project/` |
| **Sub-structure** | Freely designed per vault (defined in CONTENTS_SPEC) | Freely designed per vault (defined in CONTENTS_SPEC) |
| **Juggl Operation** | Topic clusters + timeline | Hierarchy + dependency graph |
| **AI Agent** | Shared multi-vault environment (managed globally from root) | Shared multi-vault environment (managed globally from root) |
| **Note Templates** | Freely configured per vault (domain examples provided) | Freely configured per vault (project examples provided) |

## Common Items

- `_Standards/Core/` — Synced from top-level global (identical across all vaults)
- `_Standards/Contents/` — Per-vault custom rules (not copied, created individually)
- `CONTENTS_SPEC.md` — Defines vault identity, content scope, and sub-structure
- `.obsidian/plugins/` — Shared across all vaults except obsidian-git
- AI Agent — Routing from root `CLAUDE.md` / `CODEX.md` / `ANTIGRAVITY.md`, overridden by per-vault local entry points

## Related Documents

- [[VAULTTYPE_DOMAIN]] — Full domain vault spec
- [[VAULTTYPE_PROJECT]] — Full project vault spec
- [[NoteTemplates/TEMPLATE_INDEX]] — Complete template list
