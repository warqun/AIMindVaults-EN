---
tags:
  - TileMapToolKit
type: plugin-standard
plugin: dataview
updated: 2026-03-05
---

# Dataview

## Features

- Dynamic list/table generation based on frontmatter
- Automatic status dashboard aggregation

## Primary Use Cases

- Issue status boards
- Priority/assignee/epic queries

## Basic Syntax

```dataview
TABLE status, priority, updated
FROM "docs"
WHERE status != "done"
SORT updated desc
```

## Notes

- Keep frontmatter key names standardized for accurate results.
