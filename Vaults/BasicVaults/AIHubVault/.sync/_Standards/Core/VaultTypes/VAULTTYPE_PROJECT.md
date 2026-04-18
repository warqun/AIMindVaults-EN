---
type: standard
tags:
  - AIMindVault
  - core
updated: 2026-03-11
---

# VAULTTYPE_PROJECT — Project vault spec

> Vault prototype for goal achievement and task management.
> Users set up vaults manually with this spec as a reference.

## Purpose

- Plan, execute, and track work toward measurable goals.
- Supports the plan → design → implement → review PDCA cycle.
- The focus is **producing results and tracking progress**, not storing information.

## Folder structure

```
{VaultName}/
├── Contents/
│   └── Project/       # Goal achievement / task management (sub-structure free per vault)
├── _Standards/
│   ├── Core/          # Global shared operating standards (synced from top level)
│   ├── Contents/      # Custom rules for this vault
│   └── CONTENTS_SPEC.md  # Defines vault identity and content scope
├── Tags/              # Tag management
├── Juggl_StyleGuide/  # Juggl mapping guide
├── _STATUS.md         # Current work status
└── _VAULT-INDEX.md    # Vault structure index
```

> **The sub-structure of `Contents/Project/`** can vary per vault.
> For example, a game-dev vault may use `docs/design/`, `src/`; a general-ops project may use `tasks/`, `issues/`, `milestones/`.
> Each vault defines its own content scope and folders in `CONTENTS_SPEC.md`,
> and documents the rules AI agents follow when accessing contents in `Contents/CONTENTS_AI_RULES.md`.

## Juggl usage

- **Node categories**: task, milestone, issue, decision, doc
- **Layout**: hierarchy + dependency graph (task → milestone)
- **Core relations**: `depends-on`, `blocks`, `ref`
- **Juggl embed**: a dependency graph on milestone notes

## AI agent composition

Every vault uses the **shared workspace** from the multi-vault root.

| Component | Location | Description |
|-----------|----------|-------------|
| Global entry points | Root `CLAUDE.md` / `CODEX.md` | Vault registry + routing |
| Global shared rules | Root `.claude/rules/` | Mandatory rules — encoding, edit-mode separation, etc. |
| Vault local entry | `{VaultPath}\CLAUDE.md` | Vault-specific session rules + role |
| Vault agent status | `{VaultPath}\.codex\AGENT_STATUS.md`, etc. | Last work state per agent |

- Agents (Claude, Codex, etc.) are **managed commonly at the top level**; on vault entry, global rules apply first, then local rules.
- `.claude/`, `.codex/` folders may exist inside a vault as **per-vault local overrides**.
- Which agents are actually active is declared in each vault's CLAUDE.md / CODEX.md.

## Note templates

Compose templates freely to fit each vault's content character.
Examples that suit project vaults:

| File | Purpose |
|------|---------|
| `TEMPLATE_TaskNote.md` | Task note (goal, done criteria, progress) |
| `TEMPLATE_Milestone.md` | Milestone (target, acceptance criteria, period) |
| `TEMPLATE_DecisionLog.md` | Decision log (options, reason, outcome) |
| `TEMPLATE_Retrospective.md` | Retrospective (wins, improvements, next actions) |

## Recommended plugin usage

| Plugin | Usage |
|--------|-------|
| Templater | Auto-insert Task / Milestone |
| Juggl | Visualize task-dependency graphs |
| Dataview | In-progress task lists, milestone progress rate |
| Tasks | Checkbox task tracking and filtering |
| Kanban | Status board (To Do → In Progress → Done) |
