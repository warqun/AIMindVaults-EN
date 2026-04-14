---
type: standard
tags:
  - TileMapToolKit
  - AIMindVault
  - architecture
  - vault-types
created: 2026-03-18
updated: 2026-03-18
---

# Vault Type Definitions

Vault categories used in the multi-vault system and the role/rules for each type.

---

## Type List

| Type | Category Prefix | Role | Contents Scope |
|------|----------------|------|---------------|
| **Basic** | `BasicVaults/` | Workspace hub, general-purpose template | Domain + Project |
| **Domain** | `Domains_<area>/` | Knowledge accumulation for a specific topic | Primarily Domain |
| **Lab** | `Lab_<area>/` | Combined knowledge accumulation + actual development/experimentation | Domain + Project equally |
| **Project** | `Projects_<area>/` | Practical project execution | Primarily Project |
| **Reference** | `References/` | External material lookup only | Read-only (no modifications) |

---

## Basic

- **AIHubVault**: The sole authoritative source for rules/tools/standards. Workspace mode editing is done here only.
- **BasicContentsVault**: General-purpose template used as source when cloning new vaults.

## Domain

Vaults for accumulating knowledge on a specific topic. The primary purpose is building knowledge notes in Contents/Domain.

- Examples: Unity (game engine), CapCut (video editing), Notion (workspace management)
- Category classification: `Domains_Game`, `Domains_Video`, `Domains_Infra`, `Domains_3D`, `Domains_AI_Asset`, `Domains_VCS`

## Lab

Composite vaults where knowledge accumulation (Domain) and actual development/experimentation (Project) happen together. Ideal for learning and building simultaneously.

- Examples: ObsidianDev (plugin API learning + actual plugin development)
- Category classification: `Lab_Infra`, `Lab_Game`, etc.
- Uses Contents/Domain and Contents/Project equally

## Project

Practical projects with specific goals. Have completion deadlines, and after completion, knowledge can be promoted (Knowledge Promotion) to Domain vaults.

- Examples: Project_VamSurLike (vampire survivors-like game development)
- Category classification: `Projects_Game`, etc.

## Reference

External materials stored for lookup only. AI agents are only allowed to read.

- Examples: Unity_Documentation (Unity 6.3 official manual)
- No modifications allowed (readonly)

---

## Vault Type Selection Criteria

| Question | Answer → Type |
|----------|---------------|
| Will you only accumulate knowledge? | **Domain** |
| Will you learn and develop/experiment simultaneously? | **Lab** |
| Is there a clear goal/completion deadline? | **Project** |
| Will you only store external materials for reference? | **Reference** |
