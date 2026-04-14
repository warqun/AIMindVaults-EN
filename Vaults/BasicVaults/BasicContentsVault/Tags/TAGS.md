---
type: tag-taxonomy
tags:
updated: (date)
---

# TAGS — Tag Rules/List (Normalization Reference)

> Purpose: Keep tags as a "normalized minimum" to simplify search/filter/agent context.
> After vault creation, define this vault's tag taxonomy here.

## Rules

- Tags are managed only in frontmatter `tags: [ ... ]` (body `#tag` is optional)
- Tags use **lowercase + slash hierarchy**
- Keep **3-8 tags** per note (no excessive tagging)
- Before creating a new tag, add/review it in this document (prevent uncontrolled proliferation)

---

## Core Tags (Recommended)

### Document Type

- `doc/design`
- `doc/spec`
- `doc/issue`
- `doc/workflow`
- `doc/reference`
- `doc/temp`

### Status/Priority

- `status/wip`
- `status/blocked`
- `status/decided`
- `priority/high`
- `priority/medium`
- `priority/low`

### Agent (Operations)

- `agent/claude`
- `agent/codex`

