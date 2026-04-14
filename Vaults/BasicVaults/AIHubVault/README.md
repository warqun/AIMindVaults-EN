# AIMindVault

> An Obsidian vault for AI workspace design, improvement, and distribution.
> Includes multi-agent orchestration (Claude · Codex · Copilot), knowledge graph visualization, automation scripts, and AI agent operational standards.

---

## Multi-Vault System — Essential Reading

This vault is part of the **AIMindVaults multi-vault system**. It is not used standalone.
For core concepts (Hub-Sync, edit mode separation, vault routing, etc.), refer to [[CORE_CONCEPTS]].

### Structure

```
AIMindVaults/                    <- Multi-vault root (AI agent working directory)
├── CLAUDE.md                    <- Claude Code routing hub
├── CODEX.md                     <- Codex routing hub
├── .claude/                     <- Common rules + commands
├── .codex/                      <- Common Codex rules
└── Vaults/
    └── BasicVaults/
        ├── AIHubVault/          <- This vault (workspace source Hub)
        └── BasicContentsVault/  <- General-purpose content vault
```

### AIHubVault = Hub (Core Rule)

- **This vault is the Single Source of Truth for the workspace.**
- Workspace files such as `_Standards/Core/`, `_tools/`, `_WORKFLOW.md`, `_VAULT-INDEX.md`, `Juggl_StyleGuide/` are **edited only in this vault**.
- Identical files in other vaults are auto-propagated via Hub-Sync. Do not modify them directly.
- Hub identification marker: `_forge/` directory (exists only in this vault)

### Hub-Sync (Automatic Synchronization)

- When another vault is opened in Obsidian, `sync_workspace.ps1` runs automatically.
- It copies AIHubVault's workspace files to that vault.
- Sync targets: See `_Standards/Core/Hub_Sync_Targets.md`
- **Prerequisite**: The `syncworkspace` command must be registered in the Shell Commands plugin with the `on-layout-ready` event.

---

## Prerequisites

- **Obsidian** v1.5 or higher
- **Shell Commands** plugin (required for Hub-Sync auto-execution)
- **(Optional)** Git — for automatic version control via obsidian-git
- **(Optional)** AI Agent CLI — install according to the agent you want to use:
  - [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — `npm install -g @anthropic-ai/claude-code`
  - [Codex CLI](https://github.com/openai/codex) — `npm install -g @openai/codex`
  - [Cursor](https://www.cursor.com/) — Install and open `AIMindVaults/` as a project
  - [Windsurf](https://windsurf.com/) — Install and open `AIMindVaults/` as a project

---

## Quick Start

### 1. Get AIMindVaults

Download the ZIP and extract to your preferred location.

> **Windows Path Length Warning**: Windows has a default path length limit of 260 characters. Since vault internal paths can be deep, place `AIMindVaults/` close to the drive root (e.g., `C:\AIMindVaults/`, `D:\AIMV/`). Placing it in a deep path like `C:\Users\...\Documents\Projects\` may cause errors during file copy or extraction.
>
> Permanent fix: Enable Windows Long Path support to remove the 260-character limit.
> ```
> Registry: HKLM\SYSTEM\CurrentControlSet\Control\FileSystem
> Value: LongPathsEnabled = 1 (DWORD) -> Reboot required
> ```

### 2. Register Vaults in Obsidian

Register each vault **individually** in Obsidian:

1. Obsidian -> **Open folder as vault** -> Select `Vaults/BasicVaults/AIHubVault/`
2. Register `Vaults/BasicVaults/BasicContentsVault/` the same way
3. On first launch, click "Community plugins" -> **Turn on community plugins**

### 3. Verify Shell Commands Plugin

In each vault, open `Settings -> Shell Commands` and verify that the `syncworkspace` command is registered and the `on-layout-ready` event is enabled.

- In AIHubVault, sync is SKIPPED since it is the Hub itself (this is normal).
- In other vaults, versions are compared with AIHubVault each time they are opened, and auto-sync runs if needed.

### 4. AI Agent Setup

Set the AI agent's (Claude Code, Codex, etc.) **project root to the `AIMindVaults/` directory**.

- Claude Code -> The root `CLAUDE.md` serves as the vault routing hub
- Codex -> The root `AGENTS.md` is the entry point (legacy `CODEX.md` redirects to `.codex/CODEX.md`)
- Agents automatically route to the appropriate vault based on the user's work target.

---

## Adding New Vaults

1. Clone BasicContentsVault using `BasicContentsVault/_tools/clone_vault.ps1` to create a new vault
2. Place it in the appropriate location under `Vaults/` (category folders can be freely added)
3. Register the vault in Obsidian
4. Register `syncworkspace` in the Shell Commands plugin (enable `on-layout-ready`)
5. Add it to the vault registry table in the root `CLAUDE.md`

---

## Vault Structure

```
AIMindVault/
├── Contents/              # Vault content
│   ├── Domain/            # Knowledge accumulation (guides, research, prompts)
│   └── Project/           # Task management (ideas, plans)
├── _Standards/            # Vault consistency standards and plugin operational rules
│   ├── Core/              # Common operational standards (distributed to all vaults via Hub-Sync)
│   └── Contents/          # Vault-specific rules (not synced)
├── _tools/                # Automation scripts (PowerShell CLI)
├── _forge/                # Vault clone & initialization hub (AIHubVault only)
├── Juggl_StyleGuide/      # Juggl graph style guide
├── Tags/                  # Tag definition notes
├── _VaultReview/          # Agent review reports
├── _STATUS.md             # Current work status (check at session start)
├── _VAULT-INDEX.md        # Workspace directory map
├── _WORKFLOW.md           # Operational rules (edit modes, sync, etc.)
├── _WORKSPACE_VERSION.md  # Sync version tracking
└── .claude/               # Claude Code settings (rules, commands)
```

---

## AI Agent Integration

| Agent | Config File Location |
|-------|---------------------|
| Claude Code | `.claude/CLAUDE.md`, `.claude/rules/`, `.claude/commands/` |
| Codex | `.codex/` |
| Antigravity | `.antigravity/SESSION_RULES.md` |
| Cursor | `.cursor/rules/` |

Set the **multi-vault root (`AIMindVaults/`)** as the workspace for each AI tool.
Vault-specific settings are located in each vault's agent folder.

### Integrating a New AI Agent

Local AI agents (Claude Code, Cursor, Windsurf, etc.) are used by **registering the project folder as a workspace**. Open the extracted `AIMindVaults/` folder as the agent's workspace (project root). Then copy and paste the following prompt into the agent's first conversation, and the agent will explain its configuration method:

````
This project is a multi-vault Obsidian system called AIMindVaults.
Multiple AI agents (Claude Code, Codex, Antigravity, etc.) work simultaneously in this environment,
and each agent has separate configuration files and entry rules.

I want to integrate you as a new agent into this system.
Please create the configuration files based on the information below:

## Current System Structure
- Multi-vault root: AIMindVaults/ (agent project root)
- Vault location: Under Vaults/ (e.g., Vaults/BasicVaults/AIHubVault/)
- Existing agent config examples:
  - Claude Code: Root CLAUDE.md + .claude/rules/ + per-vault CLAUDE.md
  - Codex: Root CODEX.md + .codex/rules/ + per-vault CODEX.md
  - Antigravity: Per-vault .antigravity/SESSION_RULES.md

## What I Need
1. Root entry point file (acting as vault routing hub)
2. Per-vault rule files (vault-specific rules + session routines)
3. How to reference common rules (leveraging common rules already defined in AIMindVaults/.claude/rules/)

## What You Should Tell Me
- Your agent name
- Auto-loaded config file rules (filename, location, format)
- Whether you connect at root level or per-vault level
- Whether you support sub-folders like rules/commands

Once you provide this information, I'll set up the configuration files matching existing agent patterns.
Reference files: Root CLAUDE.md, .codex/rules/vault-routing.md
````

---

## Plugins

### Community Plugins (24)

Search, install, and enable from `Settings -> Community plugins -> Browse`:

| Plugin Name                | Purpose |
| ------------------------- | ------- |
| Advanced Canvas           | Advanced canvas features (card colors, edge styles, groups, etc.) |
| Advanced Tables           | Markdown table auto-alignment and keyboard editing support |
| BRAT                      | Install and manage beta/unreleased plugins via GitHub URL |
| Colored Tags              | Apply colors to tags for visual distinction |
| Dataview                  | Query notes like a database — tables, lists, and displays |
| Git                       | Automatic git commit, push, and pull (version control) |
| Global Search and Replace | Vault-wide text search and replace |
| Juggl                     | Interactive knowledge graph visualization |
| Linter                    | Auto-correct note formatting (frontmatter, spacing, line breaks, etc.) |
| Local REST API            | HTTP API access to Obsidian from external tools (Claude, etc.) |
| make.md                   | File management, Spaces, and smart folder UI |
| MCP Tools                 | MCP server integration — connect AI agents with Obsidian |
| Mermaid Themes            | Customize Mermaid diagram themes |
| Mermaid Tools             | Mermaid diagram authoring assistance |
| Meta Bind                 | Interactive widgets in notes (buttons, sliders, input fields) |
| Metadata Menu             | Frontmatter metadata management UI |
| New 3D Graph              | 3D knowledge graph visualization |
| QuickAdd                  | Quick note creation, templates, and macro execution |
| Share to NotionNext       | Export notes to Notion pages |
| Shell Commands            | Run terminal commands directly within Obsidian |
| Smart Connections         | AI-based note semantic similarity recommendations |
| TagFolder                 | Tag-based virtual folder view |
| Tasks                     | Todo lists, due dates, filters, and recurring schedule management |
| Templater                 | Advanced template creation and automation (JS scripting support) |

### Beta Plugins (3)

After installing BRAT, enter URLs at `Settings -> BRAT -> Add Beta plugin`:

| Plugin       | GitHub URL                                          | Purpose |
| ------------ | --------------------------------------------------- | ------- |
| Claudian     | https://github.com/YishenTu/claudian                | Run Claude AI directly within Obsidian |
| Time Machine | https://github.com/dsebastien/obsidian-time-machine | View and restore note edit history and snapshots |
| YTranscript  | https://github.com/lstrzepek/obsidian-yt-transcript | Extract YouTube video subtitles and insert into notes |

> Details -> `_Standards/Plugins/Installed_Plugins_Index.md`

---

## Plugin Details

-> `_Standards/Plugins/README.md`

---

## Caution When Deleting/Moving

Before deleting or moving the `AIMindVaults/` folder, verify that no AI agents have this folder registered as a workspace. **Deletion/moving will fail if an agent has the folder open as a workspace.**

How to release:
- **Claude Code**: End the `claude` session (`/exit` or close terminal)
- **Cursor / Windsurf**: Close the project or switch to another folder
- **Codex CLI**: End the running session

Release workspace connections from all agents before deleting/moving.

---

## License

MIT
