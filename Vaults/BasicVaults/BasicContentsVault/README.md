# AIMindVault

> An Obsidian vault for AI workspace design, improvement, and distribution.
> Includes multi-agent orchestration (Claude, Codex, Copilot), knowledge graph visualization, automation scripts, and AI agent operation standard documents.

## What This Vault Contains

- **AI Agent Collaboration Settings** — Claude Code, Codex, Copilot Agent configuration files and rules
- **`_Standards/`** — Frontmatter rules, plugin operation standards, encoding/editing safety guides
- **`Contents/`** — Vault content (Domain: knowledge accumulation, Project: work management)
- **`_forge/`** — Vault cloning scripts (clone_vault) and experimentation/staging hub
- **Juggl Style Guide** — Knowledge graph visualization standards

---

## Prerequisites

- **Obsidian** v1.5 or later
- **(Optional)** Git — for automatic version control via obsidian-git

---

## Quick Start

### Step 1: Get the Vault

**ZIP Download (Simple)**

1. Click **Code -> Download ZIP** on this page
2. Extract and move the folder to your preferred location

**Git Clone (Recommended)**

```bash
git clone https://github.com/warqun/AIMindVault.git
```

---

### Step 2: Open in Obsidian

1. Launch Obsidian -> **Open folder as vault**
2. Select the `AIMindVault` folder

> **First launch**: When the "Community plugins" popup appears -> click **Turn on community plugins**

---

### Step 3: Install Plugins

The vault does not include plugin binaries. Install them manually in the following order.

#### 1. Standard Community Plugins (24)

Search, install, and enable in `Settings -> Community plugins -> Browse`:

| Plugin Name                     | Purpose |
| ------------------------- | ------- |
| Advanced Canvas           | Enhanced canvas features (card colors, edge styles, groups, etc.) |
| Advanced Tables           | Markdown table auto-alignment and keyboard editing support |
| BRAT                      | Install and manage beta/unreleased plugins via GitHub URL |
| Colored Tags              | Apply colors to tags for visual distinction |
| Dataview                  | Query notes like a database — display as tables, lists |
| Git                       | Git auto-commit, push, pull (version control) |
| Global Search and Replace | Bulk search and replace across the entire vault |
| Juggl                     | Interactive knowledge graph visualization |
| Linter                    | Auto-correct note formatting (frontmatter, spacing, line breaks, etc.) |
| Local REST API            | HTTP API access to Obsidian from external tools (Claude, etc.) |
| make.md                   | File management, Spaces, smart folder UI |
| MCP Tools                 | MCP server integration — connect AI agents with Obsidian |
| Mermaid Themes            | Customize Mermaid diagram themes |
| Mermaid Tools             | Mermaid diagram authoring helper |
| Meta Bind                 | Interactive widgets in notes (buttons, sliders, inputs) |
| Metadata Menu             | Frontmatter metadata management UI |
| New 3D Graph              | 3D knowledge graph visualization |
| QuickAdd                  | Quick note creation, templates, macro execution |
| Share to NotionNext       | Export notes to Notion pages |
| Shell Commands            | Run terminal commands directly within Obsidian |
| Smart Connections         | AI-based semantic note similarity recommendations |
| TagFolder                 | Tag-based virtual folder view |
| Tasks                     | Todo lists, due dates, filters, recurring schedules |
| Templater                 | Advanced template authoring and automation (JS scripting support) |

#### 2. Beta Plugins (3)

After installing and enabling BRAT, enter the following URLs in `Settings -> BRAT -> Add Beta plugin`:

| Plugin         | GitHub URL                                          | Purpose |
| ------------ | --------------------------------------------------- | ------- |
| Claudian     | https://github.com/YishenTu/claudian                | Run Claude AI agent directly within Obsidian |
| Time Machine | https://github.com/dsebastien/obsidian-time-machine | Browse and restore note edit history/snapshots |
| YTranscript  | https://github.com/lstrzepek/obsidian-yt-transcript | Extract YouTube video subtitles and insert into notes |

> Detailed installation instructions -> [`_Standards/Plugins/Installed_Plugins_Index.md`](./_Standards/Plugins/Installed_Plugins_Index.md)

---

## Vault Structure

```
AIMindVault/
├── Contents/              # Vault content
│   ├── Domain/            # Knowledge accumulation (guides, research, prompts)
│   └── Project/           # Work management (ideas, plans)
├── _Standards/            # Vault consistency standards and plugin operation rules
├── _tools/                # Automation scripts (PowerShell CLI)
├── _forge/                # Vault cloning and initialization hub
├── Juggl_StyleGuide/      # Juggl graph style guide
├── Tags/                  # Tag definition notes
├── _VaultReview/          # Agent review reports
├── _STATUS.md             # Current work status (check at session start)
├── _VAULT-INDEX.md        # Full document location index
└── .claude/               # Claude Code settings (rules, commands)
```

---

## AI Agent Integration

| Agent | Configuration Location |
|---------|-------------|
| Claude Code | `.claude/CLAUDE.md`, `.claude/rules/`, `.claude/commands/` |
| Codex | `.codex/` |
| GitHub Copilot | `.github/copilot-instructions.md` |

Set this vault path as the workspace for each AI tool, and the rules in `_Standards/` will be automatically referenced.

---

## Plugin Details

-> [`_Standards/Plugins/README.md`](./_Standards/Plugins/README.md)

---

## License

MIT
