# Juggl Style Sync (Mandatory)

> Applies to all vaults.

## Rules

- When Juggl styles (shape/color/emphasis) change, update `graph.css`.
- The style guide (`Contents/Juggl_StyleGuide/`) is managed per-vault. Not a distribution sync target.

## Juggl Authoring Rules

- Regular notes place the Juggl embed directly below the title.
- Format:
```juggl
local: filename_without_extension
```
- The `local:` value must be the **filename** (without extension), NOT the H1 heading.
  - Correct: `local: 20260317_Obsidian_AI_Platform` (filename)
  - Wrong: `local: Obsidian AI Platform — agent team composition platform` (H1 title)
- Exceptions: `_STATUS.md`, `_VAULT-INDEX.md`, `.claude/commands/*`, `.claude/rules/*`.
