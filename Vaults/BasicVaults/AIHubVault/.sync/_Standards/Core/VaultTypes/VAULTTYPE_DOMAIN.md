---
type: standard
tags:
  - TileMapToolKit
  - AIMindVault
  - core
updated: 2026-03-11
---

# VAULTTYPE_DOMAIN — Domain vault spec

> Vault prototype for accumulating knowledge on a specific field or topic (PKM).
> Users set up vaults manually with this spec as a reference.

## Purpose

- Collect, connect, and settle information — daily notes, reading, learning, ideas.
- A Second Brain that grows denser over time.
- The focus is **information accumulation and connection**, not goal achievement.

## Folder structure

```
{VaultName}/
├── Contents/
│   └── Domain/        # Knowledge accumulation (sub-structure is free per vault)
├── _Standards/
│   ├── Core/          # Global shared operating standards (synced from top level)
│   ├── Contents/      # Custom rules for this vault
│   └── CONTENTS_SPEC.md  # Defines vault identity and content scope
├── Tags/              # Tag management
├── Juggl_StyleGuide/  # Juggl mapping guide
├── _STATUS.md         # Current work status
└── _VAULT-INDEX.md    # Vault structure index
```

> **The sub-structure of `Contents/Domain/`** can vary per vault.
> Each vault defines its own content scope and folders in `CONTENTS_SPEC.md`,
> and documents the rules AI agents follow when accessing contents in `Contents/CONTENTS_AI_RULES.md`.

## Juggl usage

- **Node categories**: topic, person, daily, inbox, reference
- **Layout**: topic clusters + time axis (linear array of daily nodes)
- **Core relations**: `[[link]]`-based connections; topic → concept hierarchy
- **Juggl embed**: a `local:` view at the top of each topic note

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
Examples that suit domain vaults:

| File | Purpose |
|------|---------|
| `TEMPLATE_DailyNote.md` | Daily log (what you learned, did, thought) |
| `TEMPLATE_InboxCapture.md` | Quick information capture (to classify later) |
| `TEMPLATE_ConceptCard.md` | Concept card (definition, connections, examples) |
| `TEMPLATE_BookNote.md` | Reading note (summary, quotes, action points) |

## Recommended plugin usage

| Plugin | Usage |
|--------|-------|
| Templater | Auto-insert DailyNote / InboxCapture |
| Juggl | Visualize topic clusters |
| Dataview | Inbox list, tracking unprocessed notes |
| Calendar | Calendar navigation for daily notes |
| Smart Connections | Semantic note-connection suggestions |
