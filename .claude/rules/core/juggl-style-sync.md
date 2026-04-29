# Juggl Style Sync (Mandatory)

> Applied uniformly to every vault.

## Rules

- When you change a Juggl style (shape / color / emphasis), update `graph.css`.
- The style guide (`Contents/Juggl_StyleGuide/`) is managed per vault. It is not a sync-distribution target.

## Juggl Authoring Rules

- Place a Juggl embed directly under the H1 of any regular note.
- Format:
```juggl
local: filename_without_extension
```
- The `local:` value is the **filename** (without extension), not the H1 title.
  - Correct: `local: 20260317_Obsidian_AI_Platform` (filename)
  - Wrong: `local: Obsidian AI Platform — Agent Team Composition Platform` (H1 title)
- Exceptions: `_STATUS.md`, `_VAULT-INDEX.md`, `.claude/commands/*`, `.claude/rules/*`.
