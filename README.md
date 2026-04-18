# AIMindVaults

> Persistent AI workspace built on Obsidian multi-vault architecture.

---

## Why this exists

Working with AI agents (Claude Code, Codex, Cursor) day to day, two problems kept pushing me in the same direction:

**1. AI work is volatile.** Great session, hard problem solved — next day the context is gone. `CLAUDE.md` helps, but a single rulebook doesn't scale once you work across multiple domains.

**2. Obsidian degrades as a single vault grows.** More notes, more plugins, slower load times. The natural fix — splitting vaults by topic — is also the right move for AI agents: a vault full of unrelated domains pollutes their context and drops decision quality. But now you have N vaults, each needing the same rules, the same plugin settings, the same tooling, and manual sync is a losing game.

AIMindVaults is a **local, file-based PKM system** that addresses both at once:

- **Persistence** — everything agents need lives as plain files they can re-read next session.
- **Multi-vault by purpose** (domain knowledge / projects / labs / personal notes) — Obsidian stays fast, agent context stays narrow.
- **Hub-and-spoke sync** — rules, tools, and standards are edited in one Hub vault and propagated to every satellite automatically.

---

## What you get

| Problem | How it's addressed |
|---------|-------------------|
| Agents forgetting between sessions | Per-vault `CLAUDE.md`, session handoff notes, content indexer agents query before scanning files |
| Obsidian slowing down | Vaults split by purpose, each kept lean |
| Multi-vault config drift | Hub-and-spoke sync via a Node.js CLI (`aimv`) |
| Polluted agent context | Scoped rules per vault — agents only see what's relevant |
| Knowledge rot over time | Post-edit review pipeline catches frontmatter/encoding/link errors before they accumulate |

---

## Folder layout

```
AIMindVaults/                        ← AI agent project root
├── CLAUDE.md                        ← Claude Code routing hub
├── CODEX.md                         ← Codex routing hub
├── .claude/rules/                   ← Shared AI rules (auto-applied to all vaults)
├── Vaults/
│   ├── BasicVaults/                 ← Workspace hub
│   │   ├── AIHubVault/              ← Source of truth for rules/tools/standards (Hub)
│   │   └── BasicContentsVault/      ← General-purpose content vault
│   ├── Domains_*/                   ← Domain knowledge vaults (accumulation only)
│   ├── Lab_*/                       ← Lab vaults (knowledge + active development)
│   └── Projects_*/                  ← Project vaults (execution only)
└── References/                      ← Read-only reference material
```

## Vault types

| Type | Prefix | Role |
|------|--------|------|
| **Basic** | `BasicVaults/` | Workspace hub, general-purpose template |
| **Domain** | `Domains_*/` | Knowledge accumulation for a specific topic |
| **Lab** | `Lab_*/` | Hybrid — knowledge accumulation alongside active development |
| **Project** | `Projects_*/` | Hands-on project execution |
| **Reference** | `References/` | External material for lookup only (read-only) |

---

## Quick Start

### 1. Register with your AI agent

Download the ZIP and extract it near your drive root (e.g. `C:\AIMindVaults/`). Point your local AI agent (Claude Code, Cursor, Windsurf, etc.) project root at this `AIMindVaults/` folder. The agent reads `CLAUDE.md` or `CODEX.md` in the root to understand the system layout.

### 2. Register vaults in Obsidian

In Obsidian, use **Open folder as vault** to register the two folders below:

- `Vaults/BasicVaults/AIHubVault/` — workspace source of truth (Hub)
- `Vaults/BasicVaults/BasicContentsVault/` — general-purpose content vault

Plugin configuration is already bundled. On first launch, just click **Turn on community plugins**.

### 3. Ask the agent

Tell your AI agent to start from the entry point. It walks `CLAUDE.md` → vault structure → rule system in order and surfaces the available features.

### What next?

When a new topic comes up, clone a vault to add it. See "Adding a vault" below.

For detailed installation and plugin list → `Vaults/BasicVaults/AIHubVault/README.md`

---

## How it works

### Hub-Sync (automatic)

AIHubVault is the sole source of truth. Rules, tools, and standards are **edited only here**. Opening any other vault auto-runs `aimv pre-sync`, which compares versions with the Hub and syncs any differences.

### Edit mode separation

Two mutually exclusive modes prevent workspace config from mixing with content:

- **Contents mode** — edit notes under `Contents/` only
- **workspace mode** — edit `_Standards/`, `_tools/`, rules, etc. (Hub only)

Never mix them within a single task.

### AI agent routing

Agents start from the `AIMindVaults/` root, read `CLAUDE.md`, route into the relevant vault by keyword, and load that vault's scoped rules before acting.

---

## AI rule system

The rules AI agents follow are organized in three layers:

| Layer | Location | What it covers |
|-------|----------|----------------|
| Shared rules | `.claude/rules/core/` (15 files) | Auto-applied across all vaults. Encoding safety, edit modes, script management, session exit, token optimization, etc. |
| Vault rules | Each vault's `CLAUDE.md` | Vault role, entry procedure, editable scope |
| Operational rules | Each vault's `_WORKFLOW.md` | Status sharing, tagging, CLI usage, detailed procedures |

Full detail on the 15 shared rules lives inside the vault:
→ `Vaults/BasicVaults/AIHubVault/_Standards/Core/AI_Rules_Index.md`

---

## Adding a vault

1. Run the `/create-vault <category>/<vault-name>` skill (clones from BasicContentsVault)
2. Place it under the category that matches the vault type:
   - Knowledge accumulation only: `Domains_<area>/`
   - Knowledge + development: `Lab_<area>/`
   - Execution only: `Projects_<area>/`
3. Register the vault in Obsidian + configure Shell Commands
4. Add an entry to the root `CLAUDE.md` vault registry table

---

## Learn more

| Document | Contents |
|----------|----------|
| `docs/architecture.md` | System architecture — Hub-Sync, edit modes, rule system, state management |
| `docs/cli-reference.md` | Node.js CLI reference — all 14 commands in detail |
| `docs/customization.md` | User customization — adding vaults, customizing rules/skills/tags |
| `AGENT_ONBOARDING.md` | AI agent onboarding document |
| `Vaults/BasicVaults/AIHubVault/README.md` | Installation guide, plugin list, AI agent integration |

---

## License

MIT
