---
tags:
  - TileMapToolKit
type: plugin-standard
plugin: dataview
updated: 2026-03-05
---

# Dataview

## Features

- Dynamic lists / tables driven by frontmatter
- Auto-aggregated status dashboards

## Main uses

- Issue status boards
- Queries by priority / assignee / epic

## Basic syntax

```dataview
TABLE status, priority, updated
FROM "docs"
WHERE status != "done"
SORT updated desc
```

## Notes

- Lock frontmatter key names to a standard for accurate results.
