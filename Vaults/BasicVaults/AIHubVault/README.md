# AIHubVault

> Obsidian vault for designing, improving, and distributing the AI workspace.
> Multi-agent orchestration (Claude / Codex / Copilot), knowledge-graph visualization, automation scripts, and AI-agent operational standards.

---

## Read this first — multi-vault system

This vault is part of the **AIMindVaults multi-vault system**. Don't use it standalone.
For the core concepts (Hub-Sync, edit-mode separation, vault routing, etc.), see [[CORE_CONCEPTS]].

### Structure

```
AIMindVaults/                    <- multi-vault root (AI agent working directory)
├── CLAUDE.md                    <- Claude Code routing hub
├── AGENTS.md                    <- Codex routing hub
├── .claude/                     <- shared rules + commands
└── Vaults/
    └── BasicVaults/
        ├── AIHubVault/          <- this vault (workspace Hub / source of truth)
        └── BasicContentsVault/  <- generic content template
```

### AIHubVault = Hub (core rule)

- **This vault is the single source of truth for the workspace.**
- Workspace files — `_Standards/Core/`, `.sync/_tools/`, `_WORKFLOW.md`, `_VAULT-INDEX.md`, Juggl style guide, etc. — are **edited only in this vault**.
- The same files in other vaults are propagated by Hub-Sync. Don't edit them directly.
- Hub marker: `.sync/.hub_marker` (exists only in this vault).

### Hub-Sync (automatic)

- Opening any other vault in Obsidian triggers `aimv pre-sync` via the Shell Commands plugin.
- Workspace files propagate Hub → satellite as needed.
- Sync targets: see `_Standards/Core/Hub_Sync_Targets.md`.
- **Prerequisite**: the Shell Commands plugin must have a `pre-sync` command registered to the `on-layout-ready` event.

---

## Prerequisites

- **Obsidian** v1.5 or later
- **Shell Commands** plugin (required for Hub-Sync automation)
- **(optional)** Git — if you want obsidian-git auto-commit/push
- **(optional)** AI agent CLI — install whichever agents you plan to use:
  - [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — `npm install -g @anthropic-ai/claude-code`
  - [Codex CLI](https://github.com/openai/codex) — `npm install -g @openai/codex`
  - [Cursor](https://www.cursor.com/) — install, then open `AIMindVaults/` as a project
  - [Windsurf](https://windsurf.com/) — install, then open `AIMindVaults/` as a project

---

## Quick Start

### 1. Get AIMindVaults

Download the ZIP and extract it to your preferred location.

> **Windows path-length note**: Windows has a default 260-character path limit. Vault internals are deep, so place `AIMindVaults/` close to a drive root (e.g. `C:\AIMindVaults\`, `D:\AIMV\`). A deep path like `C:\Users\...\Documents\Projects\` will cause copy/unzip failures.
>
> Root fix: enable Windows Long Path support to remove the 260-char limit.
> ```
> Registry: HKLM\SYSTEM\CurrentControlSet\Control\FileSystem
> Value:    LongPathsEnabled = 1 (DWORD) — reboot required
> ```

### 2. Register the vaults in Obsidian

Register each vault **individually**:

1. Obsidian → **Open folder as vault** → pick `Vaults/BasicVaults/AIHubVault/`.
2. Do the same for `Vaults/BasicVaults/BasicContentsVault/`.
3. On first launch, accept "Turn on community plugins".

### 3. Verify the Shell Commands plugin

In each vault, open `Settings → Shell Commands` and confirm the `pre-sync` command is registered with the `on-layout-ready` event enabled.

- AIHubVault skips sync (it's the source — normal).
- Other vaults compare versions against AIHubVault on open and auto-sync as needed.

### 4. Configure your AI agent

Point your AI agent's project root at the `AIMindVaults/` directory.

- Claude Code → the root `CLAUDE.md` is the vault routing hub.
- Codex → the root `AGENTS.md` is the entry point.
- The agent routes to the appropriate vault based on your task.

---

## Adding a new vault

1. Clone `BasicContentsVault` via `aimv clone` (never hand-copy folders).
2. Place it under `Vaults/` in a category folder that fits its role.
3. Register the folder as a vault in Obsidian.
4. In Shell Commands, register the `pre-sync` command on the `on-layout-ready` event.
5. Add a row to the vault registry table in the root `CLAUDE.md`.

---

## Vault layout

```
AIHubVault/
├── Contents/              # vault content (empty in the Hub — see note below)
├── _Standards/            # vault consistency and plugin operational standards
│   ├── Core/              # shared standards (distributed to every vault via Hub-Sync)
│   └── Contents/          # vault-specific rules (not synced)
├── .sync/                 # sync machinery (Hub marker + CLI tools)
│   ├── .hub_marker
│   └── _tools/cli-node/   # Node.js CLI (`aimv`)
├── Juggl_StyleGuide/      # Juggl graph style guide
├── Tags/                  # tag definition notes
├── _STATUS.md             # current status (read on session start)
├── _VAULT-INDEX.md        # workspace directory map
├── _WORKFLOW.md           # operational rules (edit modes, sync, …)
├── _WORKSPACE_VERSION.md  # sync version tracker
└── .claude/               # Claude Code config (rules, commands)
```

> **Note**: AIHubVault is a workspace-only Hub. Actual knowledge content lives in topic-specific vaults (see the root `CLAUDE.md` registry).

---

## AI agent integration

| Agent | Config location |
|-------|-----------------|
| Claude Code | `.claude/CLAUDE.md`, `.claude/rules/`, `.claude/commands/` |
| Codex | `AGENTS.md`, `.codex/` |
| Cursor | `.cursor/rules/` |

Point each agent's workspace at the **multi-vault root (`AIMindVaults/`)**. Per-vault configs live inside each vault's agent folder.

### Integrating a new AI agent

Local AI agents (Claude Code, Cursor, Windsurf, etc.) register a project folder as their workspace. After extracting `AIMindVaults/`, open that folder as the workspace (project root). Then paste the prompt below into the agent's first conversation — it will tell you how to wire itself in:

````
This project is AIMindVaults — a multi-vault Obsidian system.
Multiple AI agents (Claude Code, Codex, …) work in the same workspace,
each with its own config files and entry rules.

I want to register you as a new agent in this system.
Based on the info below, produce the config files you need:

## Current system layout
- Multi-vault root: AIMindVaults/  (agent project root)
- Vaults live under: Vaults/  (e.g. Vaults/BasicVaults/AIHubVault/)
- Existing agent examples:
  - Claude Code: root CLAUDE.md + .claude/rules/ + per-vault CLAUDE.md
  - Codex:       root AGENTS.md + .codex/rules/ + per-vault AGENTS.md

## What I need
1. A root entry-point file (vault routing hub)
2. A per-vault rules file (vault-specific rules + session routine)
3. A way to reference the shared rules already defined under AIMindVaults/.claude/rules/

## What you need to tell me
- Your agent name
- Which config files you auto-read (filenames, locations, format)
- Whether you connect at the multi-vault root or per vault
- Whether you support subfolders like rules/ and commands/

Once you answer, I'll wire your config into the existing agent pattern.
Reference files: root CLAUDE.md, .claude/rules/vault-routing.md
````

---

## Plugins

### Community plugins

Install via `Settings → Community plugins → Browse`:

| Plugin | Purpose |
|--------|---------|
| Advanced Canvas | Canvas enhancements (card colors, edge styles, groups) |
| Advanced Tables | Auto-formatted markdown tables + keyboard editing |
| BRAT | Install/manage beta plugins directly from GitHub URLs |
| Colored Tags | Tag coloring for visual grouping |
| Dataview | Query notes like a database; table/list views |
| Git | Auto commit/push/pull for the vault |
| Global Search and Replace | Vault-wide batch search/replace |
| Juggl | Interactive knowledge-graph visualization |
| Linter | Auto-clean note format (frontmatter, whitespace, line breaks) |
| Local REST API | HTTP API for external tools (Claude, etc.) to access Obsidian |
| make.md | File management + Spaces / smart-folder UI |
| MCP Tools | MCP server integration — connects AI agents to Obsidian |
| Mermaid Themes | Theme customization for Mermaid diagrams |
| Mermaid Tools | Authoring helpers for Mermaid diagrams |
| Meta Bind | Interactive widgets in notes (buttons, sliders, inputs) |
| Metadata Menu | Frontmatter metadata management UI |
| New 3D Graph | 3D knowledge-graph view |
| QuickAdd | Quick note creation + templates + macros |
| Shell Commands | Run shell commands from inside Obsidian |
| Smart Connections | AI-based semantic similarity links |
| TagFolder | Virtual folder view based on tags |
| Tasks | Task lists, due dates, recurring schedules |
| Templater | Advanced templates + JS scripting |

### Beta plugins (via BRAT)

After installing BRAT: `Settings → BRAT → Add Beta plugin` with the GitHub URL.

| Plugin | GitHub URL | Purpose |
|--------|------------|---------|
| Time Machine | https://github.com/dsebastien/obsidian-time-machine | Note edit history / snapshots / restore |
| YTranscript | https://github.com/lstrzepek/obsidian-yt-transcript | Pull YouTube transcripts into notes |

> Details → `_Standards/Plugins/Installed_Plugins_Index.md`

---

## Plugin reference

See `_Standards/Plugins/README.md`.

---

## Before deleting or moving the folder

Before you delete or move `AIMindVaults/`, close every AI agent that has it open as a workspace. **OSes will block delete/move on a folder that's an active agent workspace.**

How to release:
- **Claude Code**: exit the session (`/exit` or close the terminal).
- **Cursor / Windsurf**: close the project or switch to another folder.
- **Codex CLI**: end the running session.

Once every agent has released the workspace, you can delete or move it.

---

## License

MIT
