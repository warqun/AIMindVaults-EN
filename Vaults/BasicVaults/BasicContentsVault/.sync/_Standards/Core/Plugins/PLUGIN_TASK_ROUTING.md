---
tags:
  - TileMapToolKit
type: standard
updated: 2026-03-05
---

# PLUGIN_TASK_ROUTING — Plugin Selection Criteria by Task

## Purpose

- Fix "which plugin for which task" to reduce trial and error.

## Routing Table

| Task Type | Primary | Secondary | Notes |
|-----------|---------|-----------|-------|
| Local LLM draft generation | `chatgpt-md` | `claudian` | Local-first when Ollama connected |
| Note creation (standard format) | `templater-obsidian` | `quickadd` | Use QuickAdd for repetitive notes |
| Bulk note modification | CLI | `obsidian-shellcommands` | CLI-first for file/regex operations |
| Related document search | `smart-connections` | `dataview` | Semantic search + metadata queries |
| Status/priority management | `metadata-menu` | `obsidian-meta-bind-plugin` | UI editing + input forms |
| TODO/deadline tracking | `obsidian-tasks-plugin` | `dataview` | Tasks-first for action lists |
| Document cleanup/consistency | `obsidian-linter` | CLI | Auto-cleanup then review |
| Structure visualization | `juggl` | `mermaid-tools` | Separate graph/flow perspectives |
| Diagram creation | `mermaid-tools` | `templater-obsidian` | Recommended: templatize code blocks |
| In-Obsidian AI editing | `claudian` | `chatgpt-md` | Can separate roles by model/agent |
| External system integration | `mcp-tools` | CLI | GitHub/browser automation, etc. |

## Task Procedure (Common)

1. Define task goal: specify output file, exit criteria, verification method
2. Select routing: determine primary tool from the table above
3. Execute: supplement with secondary tool if needed
4. Verify: check links/metadata/query results
5. Record: update `_STATUS.md` + your `AGENT_STATUS.md`

## Examples

### Example 1: Create new issue note + reflect on status dashboard

1. Create issue note with `templater-obsidian`
2. Input `status`, `priority`, `epic` with `metadata-menu`
3. Verify display in `dataview` query note

### Example 2: Understand complex system relationships

1. Use `juggl` to check link gaps/isolated notes
2. Reinforce relationships with wiki links as needed
3. Pin key flows as `mermaid` diagrams
