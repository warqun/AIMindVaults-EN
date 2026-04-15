---
type: tag-taxonomy
updated: 2026-04-15
---

# TAGS — Tag rules and list (normalization baseline)

> Purpose: keep tags as a small normalized set so search, filtering, and agent context stay simple.
> Scope: centered on `Domain/` (not enforced in References).

## Rules

- Manage tags only in frontmatter `tags: [ ... ]` (inline `#tag` in the body is optional).
- Tags are lowercase with slash hierarchy (e.g. `system/effectpackagesystem`).
- Keep **3–8 tags** per note (avoid over-tagging).
- Add/review a new tag in this file before creating it (prevents uncontrolled growth).

---

## Core tags (recommended)

### Project / category

- `project/vamsurlike`
- `doc/design`
- `doc/spec`
- `doc/issue`
- `doc/workflow`
- `doc/reference`
- `doc/temp`

### Epic

- `epic/logic`
- `epic/content`
- `epic/visual`
- `epic/audio`
- `epic/server`
- `epic/tools`

### System (Logic first)

- `system/stat2enddamage`
- `system/skillsystem`
- `system/effectpackagesystem`
- `system/buffsystem`

### Status / priority

- `status/wip`
- `status/blocked`
- `status/decided`
- `priority/high`
- `priority/medium`
- `priority/low`

### Agent (operational)

- `agent/claude`
- `agent/codex`
