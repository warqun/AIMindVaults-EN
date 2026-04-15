---
tags:
  - TileMapToolKit
type: standard
updated: 2026-03-05
---

# PLUGIN_TASK_ROUTING — Plugin choice per task

## Purpose

- Pin down "which plugin for which task" to cut trial and error.

## Routing table

| Task type | 1st choice | 2nd choice | Notes |
|---|---|---|---|
| Local-LLM draft generation | `chatgpt-md` | `claudian` | Prefer local when Ollama is connected |
| Note creation (standard form) | `templater-obsidian` | `quickadd` | Use QuickAdd for recurring notes |
| Bulk note edits | CLI | `obsidian-shellcommands` | File / regex work: CLI first |
| Related-document discovery | `smart-connections` | `dataview` | Semantic + metadata queries |
| Status / priority management | `metadata-menu` | `obsidian-meta-bind-plugin` | UI edits + input forms |
| TODO / due tracking | `obsidian-tasks-plugin` | `dataview` | Tasks first for execution lists |
| Document cleanup / consistency | `obsidian-linter` | CLI | Auto-tidy then review |
| Structural visualization | `juggl` | `mermaid-tools` | Split graph vs. flow view |
| Diagram authoring | `mermaid-tools` | `templater-obsidian` | Template the code block |
| In-Obsidian AI edits | `claudian` | `chatgpt-md` | Split roles by model / agent |
| External system integration | `mcp-tools` | CLI | GitHub / browser automation, etc. |

## Common procedure

1. Define the task goal: result file, done condition, verification method.
2. Route: pick the 1st-choice tool by the table above.
3. Execute: supplement with the 2nd choice as needed.
4. Verify: check links / metadata / query results.
5. Record: update `_STATUS.md` and your `AGENT_STATUS.md`.

## Examples

### Example 1: Create a new issue note + reflect in the status dashboard

1. Create the issue note with `templater-obsidian`.
2. Enter `status`, `priority`, `epic` via `metadata-menu`.
3. Verify display in the `dataview` query note.

### Example 2: Understand a complex system relationship

1. Use `juggl` to find link gaps / isolated notes.
2. Fill required relationships with wiki-links.
3. Pin the core flow with a `mermaid` diagram.
