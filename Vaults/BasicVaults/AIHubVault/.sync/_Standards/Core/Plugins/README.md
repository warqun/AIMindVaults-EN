---
type: standard
updated: 2026-03-08
tags:
  - TileMapToolKit
  - AIMindVault
---

# Plugins README — Plugin Operations Standard Index

## Plugin Configuration for This Vault

This vault uses a set of Obsidian plugins for AI agent collaboration, knowledge graph visualization, and automation.

### Community Plugins (28)

| Plugin | ID | Purpose | Category |
|--------|-----|---------|----------|
| Advanced Canvas | `advanced-canvas` | Canvas extended features | Visualization |
| Advanced Tables | `table-editor-obsidian` | Markdown table editing | Editing |
| BRAT | `obsidian42-brat` | Beta plugin install/management | Management |
| Claudian | `claudian` | Claude AI integration (BRAT) | AI |
| Colored Tags | `colored-tags` | Tag color differentiation | Visualization |
| Dataview | `dataview` | Data query/views | Data |
| Git | `obsidian-git` | Git version control | Management |
| Global Search and Replace | `global-search-and-replace` | Global search/replace | Editing |
| Juggl | `juggl` | Interactive knowledge graph | Visualization |
| Linter | `obsidian-linter` | Markdown format cleanup | Editing |
| Local REST API | `obsidian-local-rest-api` | REST API vault access | AI |
| make.md | `make-md` | File browser extension | Editing |
| MCP Tools | `mcp-tools` | MCP protocol server | AI |
| Mermaid Themes | `mermaid-themes` | Mermaid diagram themes | Visualization |
| Mermaid Tools | `mermaid-tools` | Mermaid diagram tools | Visualization |
| Meta Bind | `obsidian-meta-bind-plugin` | Metadata binding UI | Data |
| Metadata Menu | `metadata-menu` | Frontmatter metadata management | Data |
| New 3D Graph | `new-3d-graph` | 3D graph view | Visualization |
| QuickAdd | `quickadd` | Quick note/template addition | Automation |
| Share to NotionNext | `share-to-notionnext` | NotionNext blog deployment | Deployment |
| Shell Commands | `obsidian-shellcommands` | Shell command execution | Automation |
| Smart Connections | `smart-connections` | AI embedding-based similar notes | AI |
| TagFolder | `obsidian-tagfolder` | Tag-based virtual folders | Navigation |
| Tasks | `obsidian-tasks-plugin` | Task/todo management | Data |
| Templater | `templater-obsidian` | Advanced template engine | Automation |
| Time Machine | `obsidian-time-machine` | Note history (BRAT) | Management |
| YTranscript | `ytranscript` | YouTube subtitle extraction (BRAT) | AI |
| Obsidian Sync | (core) | Synchronization | Management |

### Plugins Requiring BRAT Reinstall

When mirror-cloning, the following plugins must be reinstalled via BRAT.

| Plugin | Repository | Install Link |
|--------|-----------|--------------|
| Time Machine | `dsebastien/obsidian-time-machine` | https://github.com/dsebastien/obsidian-time-machine |
| YTranscript | `lstrzepek/obsidian-yt-transcript` | https://github.com/lstrzepek/obsidian-yt-transcript |
| Claudian | `YishenTu/claudian` | https://github.com/YishenTu/claudian |

### Enabled Core Plugins

File explorer, Global search, Quick switcher, Graph view, Backlink, Canvas, Outgoing links, Tag pane, Properties, Page preview, Daily notes, Templates, Note composer, Command palette, Editor status, Bookmarks, Outline, Word count, File recovery, Sync, Bases

### Disabled Core Plugins

Footnotes, Slash commands, Markdown importer, Zettelkasten prefixer, Random note, Slides, Audio recorder, Workspaces, Publish, Web viewer

---

## Vault Settings

### App Settings (`app.json`)

- `alwaysUpdateLinks`: true — Auto-update links when renaming files

### Theme & Appearance (`appearance.json`)

- Theme: `obsidian` (default dark)
- Active CSS snippets (8):
  - `vis-callouts` — Callout styling
  - `vis-codeblocks` — Code block styling
  - `vis-emphasis` — Emphasis styling
  - `vis-headings` — Heading styling
  - `vis-mermaid-fix` — Mermaid rendering fix
  - `vis-tables` — Table styling
  - `vis-tags-links` — Tag/link styling
  - `vis-typography` — Typography

> Note: `header-colors.css` is installed but inactive.

### Hotkeys (`hotkeys.json`)

| Hotkey | Command |
|--------|---------|
| `F12` | Open 3D Graph |
| `Ctrl+Shift+Y` | Execute Shell Command |

### Property Types (`types.json`)

- 17 TQ_ prefixed properties defined for Tasks plugin (checkbox/text)
- Defaults: `aliases`, `cssclasses`, `tags`

---

## Plugin Roles by Category

### AI Agent Integration (4)

| Plugin | Role |
|--------|------|
| Claudian | Call Claude AI directly within Obsidian |
| MCP Tools | MCP protocol server — external AI tools access vault |
| Local REST API | Read/write vault via REST API (for automation) |
| Smart Connections | Embedding-based similar note recommendations |

### Visualization (5)

| Plugin | Role |
|--------|------|
| Juggl | Interactive knowledge graph (note relationship visualization) |
| New 3D Graph | 3D graph view |
| Mermaid Tools | Mermaid diagram editing/preview |
| Mermaid Themes | Mermaid theme customization |
| Advanced Canvas | Canvas extension |

### Automation (3)

| Plugin | Role |
|--------|------|
| Templater | Advanced templates (JavaScript support) |
| QuickAdd | Macros/quick addition |
| Shell Commands | CLI command execution (post-edit review, etc.) |

### Data Management (4)

| Plugin | Role |
|--------|------|
| Dataview | Note queries/lists/tables |
| Metadata Menu | Frontmatter field management |
| Meta Bind | Metadata inline binding |
| Tasks | Todo/task tracking |

---

## Per-Plugin Documentation

### Shared Documents

- `PLUGIN_CAPABILITIES_FOR_AI.md`: Plugin capability map
- `PLUGIN_TASK_ROUTING.md`: Tool selection criteria by task
- `MERMAID_JUGGL_SYNTAX.md`: Mermaid/Juggl syntax reference
- `RENDERING_SKILL_DRILLS.md`: Rendering/syntax proficiency drills

### Individual Documents

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

## Operational Order

1. Define task goal
2. Select primary plugin from `PLUGIN_TASK_ROUTING.md`
3. Execute using the individual plugin document procedure
4. Record results in `_STATUS.md`/`AGENT_STATUS.md`
