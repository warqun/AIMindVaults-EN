---
type: standard
tags:
  - TileMapToolKit
  - AIMindVault
  - core
updated: 2026-03-11
---

# VAULTTYPE_DOMAIN — Domain Vault Spec

> Vault prototype for accumulating knowledge in a specific field/topic (PKM).
> Users manually set up vaults referencing this spec.

## Purpose

- Collect, connect, and consolidate information from daily logs, reading, learning, ideas, etc.
- A second brain that grows denser over time.
- Core focus is **information accumulation and connection**, not goal achievement.

## Folder Structure

```
{VaultName}/
├── Contents/
│   └── Domain/        # Knowledge accumulation (sub-structure freely designed per vault)
├── _Standards/
│   ├── Core/          # Global shared operational standards (synced from top-level)
│   ├── Contents/      # Custom rules specific to this vault
│   └── CONTENTS_SPEC.md  # Vault identity and content scope definition
├── Tags/              # Tag management
├── Juggl_StyleGuide/  # Juggl mapping guide
├── _STATUS.md         # Current work status
└── _VAULT-INDEX.md    # Vault structure index
```

> **`Contents/Domain/` sub-structure** may vary per vault.
> Each vault defines its own content scope and folder structure in `CONTENTS_SPEC.md`,
> and specifies rules for AI agent content access in `Contents/CONTENTS_AI_RULES.md`.

## Juggl Operation Mode

- **Node Classification**: topic, person, daily, inbox, reference
- **Layout**: Topic clusters + timeline (daily nodes in linear arrangement)
- **Key Relationships**: `[[link]]`-based connections, topic → concept hierarchy
- **Juggl Embed**: `local:` view at the top of each topic note

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
Examples suitable for domain vaults:

| File | Purpose |
|------|---------|
| `TEMPLATE_DailyNote.md` | Daily log (things learned, done, and thoughts) |
| `TEMPLATE_InboxCapture.md` | Quick information capture (sort later) |
| `TEMPLATE_ConceptCard.md` | Concept card (definition, connections, examples) |
| `TEMPLATE_BookNote.md` | Book note (summary, quotes, action points) |

## Recommended Plugin Usage

| Plugin | Usage |
|--------|-------|
| Templater | Auto-insert DailyNote/InboxCapture |
| Juggl | Topic cluster visualization |
| Dataview | Inbox lists, unprocessed note tracking |
| Calendar | Daily note calendar navigation |
| Smart Connections | Semantic note connection recommendations |
