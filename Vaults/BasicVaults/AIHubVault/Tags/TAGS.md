---
type: tag-taxonomy
updated: 2026-03-02
---

# TAGS — Tag Rules/List (Normalization Reference)

> Purpose: Keep tags as a "normalized small set" to simplify search/filter/agent context.
> Scope: Primarily for `Domain/` (not enforced in References).

## Rules

- Tags are managed only in frontmatter `tags: [ ... ]` (inline `#tag` in body is optional)
- Tags use **lowercase + slash hierarchy** (e.g. `system/effectpackagesystem`)
- Keep **3-8 tags** per note (no excessive tagging)
- Before creating a new tag, add/review it in this document (prevent uncontrolled proliferation)

---

## Core Tags (Recommended)

### Project/Category

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

### System (Logic Priority)

- `system/stat2enddamage`
- `system/skillsystem`
- `system/effectpackagesystem`
- `system/buffsystem`

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

