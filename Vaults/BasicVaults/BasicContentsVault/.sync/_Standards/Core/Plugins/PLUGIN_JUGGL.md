---
tags:
  - TileMapToolKit
type: plugin-standard
plugin: juggl
updated: 2026-03-05
---

# Juggl

## Features

- Visualize note link relationships as a graph
- Identify isolated notes/weakly connected areas

## Primary Use Cases

- Knowledge structure inspection
- Issue/spec/decision note connectivity review

## Key Operational Syntax

1. Write wiki links explicitly: `[[NoteName]]`
2. Fix tag schema: `#project/<topic>`, `#system/<name>`
3. Standardize frontmatter `type`, `status`, `epic`

## Inspection Checklist

- Can all key notes be reached from the hub note (index)?
- Are there new notes left in isolated state?
- Has the same concept been duplicated under different names?
