---
type: standard
tags:
  - AIMindVault
  - architecture
  - vault-types
created: 2026-03-18
updated: 2026-03-18
---

# Vault type definitions

Vault categories used in the multi-vault system and the role / rules for each type.

---

## Type list

| Type | Category prefix | Role | Contents scope |
|------|-----------------|------|----------------|
| **Basic** | `BasicVaults/` | Workspace hub, general-purpose template | Domain + Project |
| **Domain** | `Domains_<area>/` | Knowledge accumulation for a specific topic | Mostly Domain |
| **Lab** | `Lab_<area>/` | Knowledge accumulation + real development / experiments | Domain + Project equally |
| **Project** | `Projects_<area>/` | Execution of a concrete project | Mostly Project |
| **Reference** | `References/` | Read-only reference material | Read-only (no edits) |

---

## Basic

- **AIHubVault**: The single source of truth for rules / tools / standards. Workspace-mode edits happen only here.
- **BasicContentsVault**: General-purpose template used as the source when cloning a new vault.

## Domain

Vaults that accumulate knowledge on a specific topic. Main purpose is to grow Contents/Domain with knowledge notes.

- Examples: a language, a tool, or a discipline you want to master
- Categories: `Domains_Game`, `Domains_Video`, `Domains_Infra`, `Domains_3D`, `Domains_AI_Asset`, `Domains_VCS`

## Lab

Hybrid vaults where knowledge accumulation (Domain) and real development / experiments (Project) happen together. Suited to learning while building.

- Example: learning a framework while building a real plugin for it
- Categories: `Lab_Infra`, `Lab_Game`, etc.
- Uses Contents/Domain and Contents/Project equally

## Project

A real project with a clear goal and an end date. After completion, knowledge may be promoted up to a Domain vault (Knowledge Promotion).

- Example: a shippable product with a defined scope and deadline
- Categories: `Projects_Game`, etc.

## Reference

Holds external material for read-only reference. AI agents may only read.

- Example: an official product manual or API reference imported verbatim
- No modifications (read-only)

---

## Choosing a type when creating a vault

| Question | Answer → Type |
|----------|---------------|
| Do you only want to accumulate knowledge? | **Domain** |
| Do you want to learn and develop/experiment at the same time? | **Lab** |
| Do you have a clear goal and completion date? | **Project** |
| Are you only keeping external material? | **Reference** |
