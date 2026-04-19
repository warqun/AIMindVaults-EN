---
type: workspace-version
tags:
  - AIMindVault
  - Meta
updated: 2026-04-19
---

# Workspace Version

> Version number for sync comparison. Format: `YYYYMMDDNNNN` (date + same-day sequence).
> Sync is triggered by comparing the top version in this file with AIHubVault's top version.
> Hub-only changelog (not distributed): see AIHubVault `_WORKSPACE_CHANGELOG.md`.

| Version      | Change summary                                               |
| ------------ | ------------------------------------------------------------ |
| 202604190003 | sync-workspace.js plugin prune logic added — Hub is authoritative. Plugin folders under satellite `.obsidian/plugins/` absent in Hub are removed (CORE_PLUGINS exempt). `community-plugins.json` reconciled to (CORE ∪ Hub ids); target-unique ids dropped. Added `removedCount`, `[PRUNE]`/`[DROP]` logs. Fixes Hub-Sync that previously behaved as add-only. |
| 202604190002 | Plugin Core/Custom separation · distribution bundle trimmed by actual usage — Core 6 (local-rest-api, advanced-uri, shellcommands, dataview, templater, linter) + Custom A 11 (juggl, mermaid-tools, make-md, obsidian-git, ytranscript, mcp-tools, quickadd, metadata-menu, global-search-and-replace, obsidian42-brat, tasks-plugin) retained. 10 plugins with 0-to-negligible usage removed. `PLUGIN_META_BIND.md` removed. `community-plugins.json` updated. |
| 202604190001 | Claudian plugin removed — `.obsidian/plugins/claudian/` directory deleted, `"claudian"` entry removed from `.obsidian/community-plugins.json`, `.sync/_Standards/Core/Plugins/PLUGIN_CLAUDIAN.md` deleted. Low user adoption — excluded from default distribution bundle. |
| 202604150001 | English distribution initial release — baseline version set. |
