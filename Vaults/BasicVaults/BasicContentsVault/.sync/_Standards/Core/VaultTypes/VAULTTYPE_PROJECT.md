---
type: standard
tags:
  - TileMapToolKit
  - AIMindVault
  - core
updated: 2026-03-11
---

# VAULTTYPE_PROJECT — Project Vault Spec

> Vault prototype for goal achievement and task management.
> Users manually set up vaults referencing this spec.

## Purpose

- Plan, execute, and track work toward measurable goals.
- Support the PDCA cycle: Plan → Design → Implement → Review.
- Core focus is **deliverable production and progress tracking**, not information storage.

## Folder Structure

```
{VaultName}/
├── Contents/
│   └── Project/       # Goal achievement and task management (sub-structure freely designed per vault)
├── _Standards/
│   ├── Core/          # Global shared operational standards (synced from top-level)
│   ├── Contents/      # Custom rules specific to this vault
│   └── CONTENTS_SPEC.md  # Vault identity and content scope definition
├── Tags/              # Tag management
├── Juggl_StyleGuide/  # Juggl mapping guide
├── _STATUS.md         # Current work status
└── _VAULT-INDEX.md    # Vault structure index
```

> **`Contents/Project/` sub-structure** may vary per vault.
> For example, a game development vault might have `docs/design/`, `src/`, etc.,
> while a general business project might have `tasks/`, `issues/`, `milestones/`, etc.
> Each vault defines its own content scope and folder structure in `CONTENTS_SPEC.md`,
> and specifies rules for AI agent content access in `Contents/CONTENTS_AI_RULES.md`.

## Juggl Operation Mode

- **Node Classification**: task, milestone, issue, decision, doc
- **Layout**: Hierarchy + dependency graph (task → milestone)
- **Key Relationships**: Dependency (`depends-on`), blocking (`blocks`), reference (`ref`)
- **Juggl Embed**: Dependency graph inserted in milestone notes

## AI Agent Configuration

All vaults use the **shared workspace** at the multi-vault root.

| Component | Location | Description |
|-----------|----------|-------------|
| Global entry point | Root `CLAUDE.md` / `CODEX.md` / `ANTIGRAVITY.md` | Vault registry + routing |
| Global shared rules | Root `.claude/rules/` | Mandatory rules: encoding, edit mode separation, etc. |
| Vault local entry point | `{VaultPath}\CLAUDE.md` | Vault-specific session rules + role specification |
| Vault agent status | `{VaultPath}\.antigravity\AGENT_STATUS.md`, etc. | Per-agent last work status |

- Agents (Claude, Codex, Antigravity, etc.) are **managed globally from the top level**, applying global rules → local rules in order upon vault entry.
- `.claude/`, `.codex/`, `.antigravity/` folders may exist inside vaults for **per-vault local settings override** purposes.
- Which agents are actively used is specified in each vault's CLAUDE.md / SESSION_RULES.md.

## Note Templates

Freely configure templates to match the vault's content nature.
Examples suitable for project vaults:

| File | Purpose |
|------|---------|
| `TEMPLATE_TaskNote.md` | Task note (goal, completion criteria, progress) |
| `TEMPLATE_Milestone.md` | Milestone (targets, success criteria, timeline) |
| `TEMPLATE_DecisionLog.md` | Decision log (options, rationale, outcome) |
| `TEMPLATE_Retrospective.md` | Retrospective (what went well, improvements, next actions) |

## Recommended Plugin Usage

| Plugin | Usage |
|--------|-------|
| Templater | Auto-insert Task/Milestone |
| Juggl | Task dependency graph visualization |
| Dataview | In-progress task lists, milestone achievement rates |
| Tasks | Checkbox task tracking/filtering |
| Kanban | Task status board (To Do → In Progress → Done) |
