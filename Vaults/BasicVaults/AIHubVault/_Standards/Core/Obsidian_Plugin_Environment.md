---
aliases:
  - "Obsidian Plugin Environment"
  - "Obsidian Environment"
tags:
  - Standards
  - Obsidian
  - Plugins
  - Meta
  - AIMindVault
type: standards
updated: 2026-03-06
agent: codex
---

# Obsidian_Plugin_Environment

```juggl
local: Obsidian_Plugin_Environment
```

## Purpose

- This note defines the actual Obsidian environment used by this vault so AI agents do not confuse vault structure, plugin behavior, and note-writing expectations.
- Treat this note as the vault-level reference for "how this workspace behaves inside Obsidian".

## Vault Baseline

- Vault root: `C:/Obsidian/MemoryVault/AIMindVault`
- Obsidian setting: `alwaysUpdateLinks = true`
- Theme: default `obsidian`
- Enabled CSS snippets:
  - `vis-callouts`
  - `vis-codeblocks`
  - `vis-emphasis`
  - `vis-headings`
  - `vis-mermaid-fix`
  - `vis-tables`
  - `vis-tags-links`
  - `vis-typography`
- Additional snippet present but not enabled in `appearance.json`: `header-colors.css`

## Core Plugin State

Enabled core plugins currently include:

- File Explorer
- Global Search
- Quick Switcher
- Graph View
- Backlinks
- Canvas
- Outgoing Links
- Tag Pane
- Properties
- Page Preview
- Daily Notes
- Templates
- Note Composer
- Command Palette
- Editor Status
- Bookmarks
- Outline
- Word Count
- File Recovery
- Sync
- Bases

Disabled core plugins that matter operationally:

- Footnotes
- Slash Command
- Markdown Importer
- Random Note
- Slides
- Audio Recorder
- Workspaces
- Publish
- Web Viewer

## Community Plugins Installed

### AI and Automation Relevant

| Plugin | Version | Operational Meaning |
|---|---:|---|
| Claudian | 1.3.67 | Claude-oriented Obsidian workflow integration |
| MCP Tools | 0.2.27 | MCP-based tool bridge inside Obsidian workflows |
| Smart Connections | 4.1.8 | AI-assisted semantic relation/search support |
| Local REST API | 3.4.4 | Local API surface for Obsidian automation |
| Shell commands | 0.23.0 | Runs external scripts and startup automation |
| Templater | 2.18.1 | Template-driven note generation |
| QuickAdd | 2.12.0 | Command/macros/capture automation |
| make.md | 1.3.4 | Folder-note style organization and workspace utilities |

### Metadata, Query, and Structure Relevant

| Plugin | Version | Operational Meaning |
|---|---:|---|
| Dataview | 0.5.68 | Metadata/query-driven notes and dashboards |
| Metadata Menu | 0.8.12 | Metadata editing and field control |
| Meta Bind | 1.4.6 | Interactive metadata/UI bindings |
| Tasks | 7.23.1 | Structured task parsing and querying |
| Linter | 1.31.2 | Formatting/consistency automation |
| Juggl | 1.5.0 | Interactive graph and per-note Juggl blocks |
| TagFolder | 0.18.13 | Tag-oriented navigation model |
| Colored Tags | 6.1.1 | Visual tag differentiation |

### Editing and Visualization Relevant

| Plugin | Version | Operational Meaning |
|---|---:|---|
| Global Search and Replace | 0.5.0 | High-risk bulk edit capability |
| Advanced Tables | 0.22.1 | Markdown table editing support |
| Mermaid Tools | 1.3.0 | Mermaid authoring helpers |
| Mermaid Themes | 0.1.3 | Mermaid rendering theme overrides |
| Advanced Canvas | 6.0.0 | Expanded canvas workflows |
| New 3D Graph | 2.4.1 | Alternate graph visualization |
| BRAT | 2.0.2 | Beta plugin management/testing |

## AI-Critical Interpretation Rules

### 1. Folder Note Semantics

- In this vault, some folders contain a note with the same basename as the folder.
- That note is a folder note, not automatically the place for new records.
- Default assumption:
  - folder note = index, overview, routing, or MoC
  - separate record = new note inside that folder
- Example:
  - `prompt_log/codex/codex.md` = folder note
  - actual stored logs should be separate `LOG_*.md` notes inside `prompt_log/codex/`
- Before writing in any workspace-like folder, inspect existing naming patterns first.

### 2. Plugin Behavior Must Be Respected

- `make.md` can reinforce folder-based organization patterns, so folder note structures should be treated as intentional.
- `Juggl` is actively used in this vault. Normal notes are expected to carry a Juggl block directly under H1 unless the note is an exception defined in writing rules.
- `Metadata Menu`, `Dataview`, `Meta Bind`, and `Tasks` mean frontmatter quality is not cosmetic; it affects behavior.
- `Linter` means careless formatting drift can create avoidable churn.
- `Global Search and Replace` exists, but bulk automation is still high-risk and should remain restricted by `_Standards/Encoding_BulkEdit_Safety.md`.

### 3. Rendering Is Not Pure Markdown

- CSS snippets actively restyle headings, tables, callouts, emphasis, tags/links, typography, code blocks, and Mermaid rendering.
- A note that looks structurally fine in raw markdown may render differently inside Obsidian.
- Mermaid output may differ from plain default Mermaid because both `mermaid-tools` and `mermaid-themes` are installed and a Mermaid CSS fix snippet is enabled.

## Existing Standards and Plugin Docs

- Base note-writing rules: [[_Standards/WritingStandards]]
- Required properties: [[_Standards/NoteProperties]]
- Plugin routing/index: [[_Standards/Plugins/README]]

## Recommended AI Read Order Before Obsidian Editing

1. [[_WORKFLOW]]
2. [[_STATUS]]
3. Agent status file (`.codex/AGENT_STATUS.md` or equivalent)
4. [[_Standards/WritingStandards]]
5. [[_Standards/NoteProperties]]
6. This note
8. Relevant plugin note under [[_Standards/Plugins/README]] if the task depends on plugin behavior
9. Target folder pattern check before creating or editing notes

## Operational Guidance For Agents

- Do not assume raw filesystem structure alone explains note intent; Obsidian plugin conventions may redefine how a folder is used.
- Do not assume "write in this folder" means "edit the folder note".
- Do not assume note rendering is neutral markdown.
- Do not assume metadata fields are optional just because markdown renders without them.
- Do not use bulk replace workflows on Korean markdown unless the safety process explicitly allows it.

## Maintenance Trigger

Update this note when any of the following changes:

- community plugin install or removal
- major plugin version changes that alter workflow meaning
- folder note conventions
- Juggl/frontmatter expectations
- CSS snippets affecting reading/writing behavior
- AI-facing Obsidian automation path changes
