# AIMindVaults

> A multi-vault knowledge management system for Obsidian + AI agents.

---

## What Is This?

A system that organizes multiple Obsidian vaults under a single working directory, enabling AI agents (Claude Code, Codex, Cursor, etc.) to automatically follow rules while working across them.

### Why Multi-Vault?

Obsidian noticeably slows down as the number of files and folders in a single vault grows. Installing multiple community plugins makes it worse. Splitting vaults by topic helps performance, but then you have to manage rules and tools separately for each vault.

AIMindVaults solves both problems at once — vaults are split to maintain Obsidian performance, while the rules and tools that AI agents follow are managed consistently from a single source.

### Core Architecture

- **One vault is the source of truth** (Hub), and all other vaults automatically receive rules and tools from it.
- **Content editing** and **workspace configuration** are never mixed. Each has its own dedicated mode.
- **Multiple AI agents** can work without conflicts because they share state through `_STATUS.md`.

### Folder Structure

```
AIMindVaults/                        ← AI agent project root
├── CLAUDE.md                        ← Claude Code routing hub
├── CODEX.md                         ← Codex routing hub
├── .claude/rules/                   ← Shared AI rules (auto-applied to all vaults)
├── Vaults/
│   ├── BasicVaults/                 ← Workspace hub
│   │   ├── AIHubVault/              ← Source of truth for rules/tools/standards (Hub)
│   │   └── BasicContentsVault/      ← General-purpose content vault
│   ├── Domains_*/                   ← Domain knowledge vaults (knowledge accumulation only)
│   ├── Lab_*/                       ← Lab vaults (knowledge accumulation + active development)
│   └── Projects_*/                  ← Project vaults (execution only)
└── References/                      ← Read-only reference materials
```

### Vault Types

| Type | Prefix | Role |
|------|--------|------|
| **Basic** | `BasicVaults/` | Workspace hub, general-purpose template |
| **Domain** | `Domains_*/` | Knowledge accumulation for a specific topic |
| **Lab** | `Lab_*/` | Hybrid vaults combining knowledge accumulation and active development |
| **Project** | `Projects_*/` | Dedicated to real project execution |
| **Reference** | `References/` | External reference materials (read-only) |

---

## Quick Start

### 1. Register with an AI Agent

Extract the ZIP near the root of a drive (e.g., `C:\AIMindVaults/`). Set the project root of your local AI agent (Claude Code, Cursor, Windsurf, etc.) to this `AIMindVaults/` folder. The agent reads the root `CLAUDE.md` or `CODEX.md` to understand the system structure.

### 2. Register Vaults in Obsidian

In Obsidian, use **Open folder as vault** to register these two folders as vaults:

- `Vaults/BasicVaults/AIHubVault/` — Workspace source of truth (Hub)
- `Vaults/BasicVaults/BasicContentsVault/` — General-purpose content vault

Plugin settings are already included, so no additional configuration is needed. On first launch, just click **Turn on community plugins**.

### 3. Ask Your Agent

Once registered, instruct your AI agent to start from the entry point. The agent will follow `CLAUDE.md` → vault structure → rule system and report what features are available.

### What's Next?

When a new topic comes up, clone a vault to add it. See "Adding Vaults" below for how.

For a detailed setup guide and plugin list → `Vaults/BasicVaults/AIHubVault/README.md`

---

## How Does It Work?

### Hub-Sync (Automatic Synchronization)

AIHubVault is the single source of truth. Rules, tools, and standard documents are **edited only here**.

When you open another vault in Obsidian, `aimv pre-sync` runs automatically, compares versions with the Hub, and synchronizes any differences.

### Edit Mode Separation

Editing within a vault is divided into two types:

- **Contents mode**: Work only on content inside `Contents/` (knowledge organization, project management)
- **Workspace mode**: Work only on environment settings like `_Standards/`, `_tools/` (AIHubVault only)

The two modes are never mixed in a single task.

### AI Agent Routing

AI agents start from the `AIMindVaults/` root. When a user makes a request, the agent finds the appropriate vault, reads its rules, and then proceeds with the task.

---

## AI Rule System

AI agents follow a 3-tier rule system:

| Tier | Location | Purpose |
|------|----------|---------|
| Shared rules | `.claude/rules/` (11 rules) | Auto-applied to all vaults. Encoding safety, edit modes, script management, etc. |
| Vault rules | Each vault's `CLAUDE.md` | Vault-specific role, entry procedure, editing scope |
| Operational rules | Each vault's `_WORKFLOW.md` | Detailed procedures for state sharing, tags, CLI usage, etc. |

For details on all 11 shared rules, see:
→ `Vaults/BasicVaults/AIHubVault/_Standards/Core/AI_Rules_Index.md`

---

## Adding Vaults

1. Run the `/create-vault <category>/<vault-name>` skill (clones from BasicContentsVault)
2. Place in the appropriate category by vault type:
   - Knowledge accumulation only: `Domains_<area>/`
   - Knowledge + development: `Lab_<area>/`
   - Execution only: `Projects_<area>/`
3. Register the vault in Obsidian + configure Shell Commands
4. Add to the vault registry table in the root `CLAUDE.md`

---

## Learn More

| Document | Description |
|----------|-------------|
| `docs/architecture.md` | System architecture — Hub-Sync, edit modes, rule system, state management |
| `docs/cli-reference.md` | Node.js CLI tool reference — 14 commands in detail |
| `docs/customization.md` | User customization — adding vaults, custom rules/skills/tags |
| `AGENT_ONBOARDING.md` | AI agent onboarding document |
| `Vaults/BasicVaults/AIHubVault/README.md` | Setup guide, plugin list, AI agent integration |

---

## License

MIT
