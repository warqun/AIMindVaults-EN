---
tags:
type: plugin-standard
plugin: juggl
updated: 2026-03-05
---

# Juggl

## Features

- Visualize link relationships between notes as a graph
- Identify isolated notes and weakly connected areas

## Main uses

- Audit knowledge structure
- Review the connectivity of issue / spec / decision notes

## Operating essentials

1. Write wiki-links explicitly: `[[NoteName]]`
2. Fix the tag schema: `#project/<topic>`, `#system/<name>`
3. Unify frontmatter `type`, `status`, `epic`

## Audit checklist

- From the hub note (index), is every core note reachable
- Are new notes left isolated
- Has the same concept been duplicated under different names
