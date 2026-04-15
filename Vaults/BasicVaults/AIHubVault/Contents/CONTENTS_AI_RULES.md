---
type: standard
tags:
  - domain
updated: 2026-04-15
---

# CONTENTS_AI_RULES — AIMindVault-specific AI work rules

> Overrides/augments the rules in `_Standards/Core/`.

## Task priority

1. Read `_STATUS.md` first — identify the current focus of work.
2. Use `_VAULT-INDEX.md` to locate relevant files.
3. For broad scopes, consult the related guides under `_Standards/Core/`.

## File modification rules

- Modifying files under `_Standards/Core/` affects every vault. Decide carefully.
- Files under `_Standards/Contents/` are specific to this vault and may be modified freely.
- Files under `_forge/staging/` are review-complete and waiting for distribution. Verify before deleting.

## Note creation notes

- Frontmatter rules: see `_Standards/Core/NoteProperties.md`.
- `type`: `standard` | `template` | `guide` | `idea` | `plan` | `report`
- Always include `AIMindVault` in `tags`.
- Glossary: see [[CONTENTS_GLOSSARY]].

## Prohibited

- No full bulk edits across `_Standards/Core/`.
- No arbitrary deletion or modification of `_forge/inbox/` files (they are outputs from external agents).
