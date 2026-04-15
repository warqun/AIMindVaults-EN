# AIMindVault

> Obsidian vault for designing, improving, and distributing your AI workspace.
> Includes multi-agent orchestration (Claude · Codex · Copilot), knowledge-graph visualization, automation scripts, and AI agent operational standards.

## What this vault contains

- **AI agent collaboration config** — configuration files and rules for Claude Code, Codex, and Copilot Agent
- **`_Standards/`** — frontmatter rules, plugin operational standards, encoding/editing safety guides
- **`Contents/`** — vault contents (Domain: knowledge accumulation, Project: task management)
- **`_forge/`** — vault clone scripts (`clone_vault`) and experiment/staging hub
- **Juggl style guide** — standards for knowledge-graph visualization

---

## Prerequisites

- **Obsidian** v1.5 or higher
- **(Optional)** Git — required if you want automatic version control via obsidian-git

---

## Quick Start

### Step 1: Get the vault

**ZIP download (easy)**

1. On this page, click **Code → Download ZIP**.
2. Unzip and move the folder to the location you want.

**Git clone (recommended)**

```bash
git clone https://github.com/warqun/AIMindVault.git
```

---

### Step 2: Open in Obsidian

1. Launch Obsidian → **Open folder as vault**.
2. Select the `AIMindVault` folder.

> **On first launch**: when the "Use community plugins" dialog appears → click **Turn on community plugins**.

---

### Step 3: Install plugins

The vault does not ship with plugin binaries. Install them in the order below.

#### ① Standard community plugins (24)

Search, install, and enable from `Settings → Community plugins → Browse`:

| Plugin                     | Purpose |
| -------------------------- | ------- |
| Advanced Canvas            | Advanced canvas features (card colors, edge styles, groups, etc.) |
| Advanced Tables            | Auto-aligned markdown tables with keyboard editing |
| BRAT                       | Install and manage beta / unreleased plugins via GitHub URL |
| Colored Tags               | Visual distinction through tag colors |
| Dataview                   | Query notes like a database and render as tables or lists |
| Git                        | Automatic commit / push / pull (version control) |
| Global Search and Replace  | Bulk text search and replace across the whole vault |
| Juggl                      | Interactive knowledge-graph visualization |
| Linter                     | Auto-correct note formatting (frontmatter, whitespace, line breaks, etc.) |
| Local REST API             | Let external tools (Claude, etc.) access Obsidian over HTTP |
| make.md                    | File management UI with Spaces and smart folders |
| MCP Tools                  | MCP server integration — connect AI agents with Obsidian |
| Mermaid Themes             | Customize Mermaid diagram themes |
| Mermaid Tools              | Authoring aids for Mermaid diagrams |
| Meta Bind                  | Interactive widgets inside notes (buttons, sliders, input fields) |
| Metadata Menu              | UI for managing frontmatter metadata |
| New 3D Graph               | 3D knowledge-graph visualization |
| QuickAdd                   | Quick note creation, templates, and macro execution |
| Share to NotionNext        | Export notes to Notion pages |
| Shell Commands             | Run terminal commands from inside Obsidian |
| Smart Connections          | AI-based semantic similarity suggestions between notes |
| TagFolder                  | Virtual folder views based on tags |
| Tasks                      | Task lists, due dates, filters, and recurring schedules |
| Templater                  | Advanced template authoring and automation (JS scripting) |

#### ② Beta plugins (3)

After installing and enabling BRAT, open `Settings → BRAT → Add Beta plugin` and paste each URL:

| Plugin       | GitHub URL                                          | Purpose |
| ------------ | --------------------------------------------------- | ------- |
| Claudian     | https://github.com/YishenTu/claudian                | Run the Claude AI agent directly inside Obsidian |
| Time Machine | https://github.com/dsebastien/obsidian-time-machine | Browse and restore note edit history / snapshots |
| YTranscript  | https://github.com/lstrzepek/obsidian-yt-transcript | Extract YouTube transcripts into notes |

> Detailed install steps → [`_Standards/Plugins/Installed_Plugins_Index.md`](./_Standards/Plugins/Installed_Plugins_Index.md)

---

## Vault structure

```
AIMindVault/
├── Contents/              # Vault contents
│   ├── Domain/            # Knowledge accumulation (guides, research, prompts)
│   └── Project/           # Task management (ideas, plans)
├── _Standards/            # Vault consistency baselines and plugin operational standards
├── _tools/                # Automation scripts (Node.js CLI)
├── _forge/                # Vault cloning / initialization hub
├── Juggl_StyleGuide/      # Juggl graph style guide
├── Tags/                  # Tag definition notes
├── _VaultReview/          # Agent review reports
├── _STATUS.md             # Current work state (read at session start)
├── _VAULT-INDEX.md        # Index of every document location
└── .claude/               # Claude Code configuration (rules, commands)
```

---

## AI agent integration

| Agent | Config location |
|-------|-----------------|
| Claude Code | `.claude/CLAUDE.md`, `.claude/rules/`, `.claude/commands/` |
| Codex | `.codex/` |
| GitHub Copilot | `.github/copilot-instructions.md` |

Point each AI tool's workspace at this vault's path, and they will automatically reference the rules under `_Standards/`.

---

## Plugin details

→ [`_Standards/Plugins/README.md`](./_Standards/Plugins/README.md)

---

## License

MIT
