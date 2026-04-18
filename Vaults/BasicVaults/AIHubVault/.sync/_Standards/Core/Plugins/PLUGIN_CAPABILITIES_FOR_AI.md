---
tags:
type: standard
updated: 2026-03-05
---

# PLUGIN_CAPABILITIES_FOR_AI — Plugin capabilities for AI

## Purpose

- Let AI agents quickly decide "what each plugin can do."
- Keep tool selection consistent for the same kind of task.

## Core principles

1. CLI first for file I/O and bulk edits.
2. Use plugins to complement "visualization / interaction / metadata editing / automation triggers."
3. Always record results in documents (`_STATUS.md`, `AGENT_STATUS.md`).

## Capabilities per plugin

| Plugin | Core capability (AI view) | When to use |
|---|---|---|
| `claudian` | Claude chat / doc editing inside Obsidian | Planning-doc drafts, quick edits |
| `chatgpt-md` | In-Obsidian LLM chat / agent-preset operation | Local Ollama-based drafts / split work |
| `smart-connections` | Similar-note discovery / link suggestions | Find related notes, fill missing references |
| `mcp-tools` | MCP-based external tool calls | Browser / GitHub / external system integration |
| `obsidian-shellcommands` | Script-execution triggers | ~~Auto-run `_tools/open_agents.ps1`~~ (abolished) |
| `templater-obsidian` | Template-based note generation | Standard issue / meeting / spec creation |
| `quickadd` | Capture / command / template automation | Shortcut for recurring creation |
| `dataview` | Metadata queries / lists | Issue dashboards, status lists |
| `metadata-menu` | Frontmatter edit UI | Bulk entry of priority / status |
| `obsidian-meta-bind-plugin` | Form UI bound to metadata | Human + AI collaborative input forms |
| `obsidian-tasks-plugin` | Task queries / schedule management | Daily TODOs, due tracking |
| `obsidian-linter` | Auto-format document rules | Tidy frontmatter / headings / links |
| `juggl` | Note-link graph visualization / structure audit | Detect gaps in the knowledge graph |
| `mermaid-tools` | Mermaid edit / render assist | Diagram authoring and review |

## Cautions

- Plugin UI state depends on local user configuration.
- Advanced features may differ by version; if a feature name has changed, use the latest menu with the same purpose.
