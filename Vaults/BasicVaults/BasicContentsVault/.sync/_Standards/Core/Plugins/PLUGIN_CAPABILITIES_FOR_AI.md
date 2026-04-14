---
tags:
  - TileMapToolKit
type: standard
updated: 2026-03-05
---

# PLUGIN_CAPABILITIES_FOR_AI — Plugin Capability Definitions for AI

## Purpose

- Enable AI agents to quickly determine "what each plugin can do."
- Maintain consistent tool selection for the same tasks.

## Core Principles

1. CLI first for file I/O and bulk modifications.
2. Plugins are supplementary for "visualization/interaction/metadata editing/automation triggers."
3. Always record results in documents (`_STATUS.md`, `AGENT_STATUS.md`).

## Plugin Capabilities

| Plugin | Key AI Capability | Recommended Use Case |
|--------|-------------------|---------------------|
| `claudian` | Claude conversation/document work inside Obsidian | Planning document drafts, quick edits |
| `chatgpt-md` | LLM conversation/agent preset operations inside Obsidian | Local Ollama-based drafts/division of labor |
| `smart-connections` | Similar note discovery/connection recommendations | Finding related notes, filling reference gaps |
| `mcp-tools` | MCP-based external tool invocation | Browser/GitHub/external system integration |
| `obsidian-shellcommands` | Script execution triggers | ~~`_tools/open_agents.ps1` auto-execution~~ (deprecated) |
| `templater-obsidian` | Template-based note generation | Standard issue/meeting/spec creation |
| `quickadd` | Capture/command/template automation | Shortcut for repetitive creation tasks |
| `dataview` | Metadata query/list generation | Issue dashboards, status lists |
| `metadata-menu` | Frontmatter editing UI | Priority/status batch input |
| `obsidian-meta-bind-plugin` | Form UI and metadata binding | Human+AI collaborative input forms |
| `obsidian-tasks-plugin` | Task query/schedule management | Daily TODOs, deadline tracking |
| `obsidian-linter` | Document format auto-cleanup | Frontmatter/header/link cleanup |
| `juggl` | Note link relationship visualization/structure inspection | Knowledge graph gap detection |
| `mermaid-tools` | Mermaid editing/rendering assistance | Diagram creation/review |

## Notes

- Plugin UI state is affected by local user settings.
- Advanced features may vary by version; use the latest menu serving the same purpose if feature names differ.
