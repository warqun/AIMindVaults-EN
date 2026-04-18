---
type: standard
updated: 2026-03-08
tags:
  - AIMindVault
---

# Plugins README — Plugin operations index

## Plugin composition for this vault

This vault uses an Obsidian plugin set for AI-agent collaboration, knowledge-graph visualization, and automation.

### Community plugins (28)

| Plugin | ID | Purpose | Category |
|--------|-----|---------|----------|
| Advanced Canvas | `advanced-canvas` | Canvas extensions | Visualization |
| Advanced Tables | `table-editor-obsidian` | Markdown table editing | Editing |
| BRAT | `obsidian42-brat` | Install / manage beta plugins | Management |
| Claudian | `claudian` | Claude AI integration (BRAT) | AI |
| Colored Tags | `colored-tags` | Tag coloring | Visualization |
| Dataview | `dataview` | Data queries / views | Data |
| Git | `obsidian-git` | Git version control | Management |
| Global Search and Replace | `global-search-and-replace` | Vault-wide search / replace | Editing |
| Juggl | `juggl` | Interactive knowledge graph | Visualization |
| Linter | `obsidian-linter` | Markdown formatting | Editing |
| Local REST API | `obsidian-local-rest-api` | Vault access via REST API | AI |
| make.md | `make-md` | File browser extension | Editing |
| MCP Tools | `mcp-tools` | MCP protocol server | AI |
| Mermaid Themes | `mermaid-themes` | Mermaid diagram themes | Visualization |
| Mermaid Tools | `mermaid-tools` | Mermaid diagram tools | Visualization |
| Meta Bind | `obsidian-meta-bind-plugin` | Metadata binding UI | Data |
| Metadata Menu | `metadata-menu` | Frontmatter metadata management | Data |
| New 3D Graph | `new-3d-graph` | 3D graph view | Visualization |
| QuickAdd | `quickadd` | Fast note / template add | Automation |
| Share to NotionNext | `share-to-notionnext` | Publish to NotionNext blog | Publishing |
| Shell Commands | `obsidian-shellcommands` | Run shell commands | Automation |
| Smart Connections | `smart-connections` | Embedding-based similar notes | AI |
| TagFolder | `obsidian-tagfolder` | Virtual folders by tag | Navigation |
| Tasks | `obsidian-tasks-plugin` | Task / TODO management | Data |
| Templater | `templater-obsidian` | Advanced template engine | Automation |
| Time Machine | `obsidian-time-machine` | Note history (BRAT) | Management |
| YTranscript | `ytranscript` | YouTube transcript extraction (BRAT) | AI |
| Obsidian Sync | (core) | Sync | Management |

### Plugins that need BRAT re-install

When mirroring the vault, re-install the plugins below via BRAT.

| Plugin | Repository | Install link |
|--------|------------|--------------|
| Time Machine | `dsebastien/obsidian-time-machine` | https://github.com/dsebastien/obsidian-time-machine |
| YTranscript | `lstrzepek/obsidian-yt-transcript` | https://github.com/lstrzepek/obsidian-yt-transcript |
| Claudian | `YishenTu/claudian` | https://github.com/YishenTu/claudian |

### Enabled core plugins

File explorer, Global search, Quick switcher, Graph view, Backlink, Canvas, Outgoing links, Tag pane, Properties, Page preview, Daily notes, Templates, Note composer, Command palette, Editor status, Bookmarks, Outline, Word count, File recovery, Sync, Bases

### Disabled core plugins

Footnotes, Slash commands, Markdown importer, Zettelkasten prefixer, Random note, Slides, Audio recorder, Workspaces, Publish, Web viewer

---

## Vault settings

### App settings (`app.json`)

- `alwaysUpdateLinks`: true — auto-update links on file rename

### Appearance (`appearance.json`)

- Theme: `obsidian` (default dark)
- Active CSS snippets (8):
  - `vis-callouts` — callout styling
  - `vis-codeblocks` — code-block styling
  - `vis-emphasis` — emphasis styling
  - `vis-headings` — heading styling
  - `vis-mermaid-fix` — Mermaid rendering fixes
  - `vis-tables` — table styling
  - `vis-tags-links` — tag / link styling
  - `vis-typography` — typography

> Note: `header-colors.css` is installed but inactive.

### Hotkeys (`hotkeys.json`)

| Hotkey | Command |
|--------|---------|
| `F12` | Open 3D Graph |
| `Ctrl+Shift+Y` | Run a Shell Command |

### Property types (`types.json`)

- 17 TQ_-prefixed properties for the Tasks plugin (checkbox / text)
- Default: `aliases`, `cssclasses`, `tags`

---

## Plugin roles by category

### AI-agent integration (4)

| Plugin | Role |
|--------|------|
| Claudian | Call Claude directly from Obsidian |
| MCP Tools | MCP protocol server — external AI tools access the vault |
| Local REST API | Vault read / write over REST (for automation) |
| Smart Connections | Embedding-based similar-note suggestions |

### Visualization (5)

| Plugin | Role |
|--------|------|
| Juggl | Interactive knowledge graph (note-relationship visualization) |
| New 3D Graph | 3D graph view |
| Mermaid Tools | Edit / preview Mermaid diagrams |
| Mermaid Themes | Customize Mermaid themes |
| Advanced Canvas | Canvas extensions |

### Automation (3)

| Plugin | Role |
|--------|------|
| Templater | Advanced templates (JavaScript supported) |
| QuickAdd | Macros / quick adds |
| Shell Commands | Run CLI commands (post-edit review, etc.) |

### Data management (4)

| Plugin | Role |
|--------|------|
| Dataview | Note queries / lists / tables |
| Metadata Menu | Manage frontmatter fields |
| Meta Bind | Inline metadata binding |
| Tasks | Task / TODO tracking |

---

## Detailed plugin documents

### Common

- `PLUGIN_CAPABILITIES_FOR_AI.md`: Plugin capability map
- `PLUGIN_TASK_ROUTING.md`: Tool choice per task
- `MERMAID_JUGGL_SYNTAX.md`: Mermaid / Juggl syntax reference
- `RENDERING_SKILL_DRILLS.md`: Render / syntax practice drills

### Individual

- `PLUGIN_CLAUDIAN.md`
- `PLUGIN_CHATGPT_MD.md`
- `PLUGIN_SMART_CONNECTIONS.md`
- `PLUGIN_MCP_TOOLS.md`
- `PLUGIN_SHELL_COMMANDS.md`
- `PLUGIN_TEMPLATER.md`
- `PLUGIN_QUICKADD.md`
- `PLUGIN_DATAVIEW.md`
- `PLUGIN_METADATA_MENU.md`
- `PLUGIN_META_BIND.md`
- `PLUGIN_TASKS.md`
- `PLUGIN_LINTER.md`
- `PLUGIN_JUGGL.md`
- `PLUGIN_MERMAID_TOOLS.md`

---

## Operating procedure

1. Define the task goal.
2. Pick the 1st-choice plugin from `PLUGIN_TASK_ROUTING.md`.
3. Execute per that plugin's individual document.
4. Record results in `_STATUS.md` / `AGENT_STATUS.md`.
