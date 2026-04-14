# Obsidian Config File Safe Editing (Mandatory)

> Applies to all vaults.

## Rules

- Files under `.obsidian/` (plugin settings, `community-plugins.json`, etc.) are **workspace edits**.
- Following the workspace-edit rule, these are **performed only in AIHubVault** → propagated via `node cli.js sync`.

## .obsidian/ JSON Editing — Safety Rules

- **Do not use PowerShell's `ConvertFrom-Json` → `ConvertTo-Json` pipeline.**
  - There's a bug where single-element arrays convert to strings, plus encoding corruption risk.
- Edit `.obsidian/` settings only via **Read → Edit (direct text modification)**.
- Full overwrite (`Write`) is allowed only when writing content from scratch.

## Version Recording (Mandatory)

- When you modify any file under `.obsidian/`, **you must** record a version entry in AIHubVault's `_WORKSPACE_VERSION.md`.
- No completion report without a version entry.
- This rule applies to **every** `.obsidian/`-related workspace edit: plugin install, setting change, JSON edit.

## Plugin Install / Remove

- Use the `install-plugin` skill for plugin install, removal, and setting changes.
- If installing manually without the skill, still follow the safety rules above.
