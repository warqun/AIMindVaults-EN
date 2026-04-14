# Juggl Style Sync (Mandatory)

> Applies uniformly to all vaults.

## Rules

- When changing Juggl styles (shape/color/emphasis), update graph.css.
- Style guides (`Contents/Juggl_StyleGuide/`) are managed per vault individually. Not a distribution sync target.

## Juggl Authoring Rules

- For regular notes, place the Juggl embed directly below the title.
- Format:
```juggl
local: filename_without_extension
```
- The `local:` value must use the **filename** (without extension). Not the H1 header title.
  - Correct: `local: 20260317_Obsidian_AI_Platform` (filename)
  - Incorrect: `local: Obsidian AI Platform — Agent Team Configuration Platform` (H1 title)
- Exceptions: `_STATUS.md`, `_VAULT-INDEX.md`, `.claude/commands/*`, `.claude/rules/*`.
