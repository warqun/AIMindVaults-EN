---
type: standard
tags:
  - AIMindVault
  - core
updated: 2026-03-11
---

# VaultTypes — Vault type comparison index

This vault system ships two prototypes.
Users set up vaults manually.

## Type comparison

| Item | domain | project |
|------|--------|---------|
| **Purpose** | Per-topic knowledge accumulation (PKM) | Goal achievement (task management) |
| **Spec doc** | [[VAULTTYPE_DOMAIN]] | [[VAULTTYPE_PROJECT]] |
| **Contents root** | `Contents/Domain/` | `Contents/Project/` |
| **Sub-structure** | Free per vault (defined in CONTENTS_SPEC) | Free per vault (defined in CONTENTS_SPEC) |
| **Juggl usage** | Topic clusters + time axis | Hierarchy + dependency graph |
| **AI agents** | Shared multi-vault environment (managed at top level) | Shared multi-vault environment (managed at top level) |
| **Note templates** | Free per vault (domain examples provided) | Free per vault (project examples provided) |

## Common items

- `_Standards/Core/` — synced from the top-level global (identical across vaults)
- `_Standards/Contents/` — per-vault custom rules (not copied, created individually)
- `CONTENTS_SPEC.md` — defines vault identity, content scope, and sub-structure
- `.obsidian/plugins/` — fully shared except obsidian-git
- AI agents — routed from the top-level `CLAUDE.md` / `CODEX.md`, overridden by the vault's local entry points

## Related

- [[VAULTTYPE_DOMAIN]] — full spec for domain vaults
- [[VAULTTYPE_PROJECT]] — full spec for project vaults
- [[NoteTemplates/TEMPLATE_INDEX]] — full template list
