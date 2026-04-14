# Obsidian Config File Safe Editing (Mandatory)

> Applies uniformly to all vaults.

## Rules

- Files under `.obsidian/` (plugin settings, `community-plugins.json`, etc.) are **workspace edits**.
- Per workspace editing rules, these must be **performed only in AIHubVault** and propagated via `node cli.js sync`.

## .obsidian/ JSON File Editing — Safety Rules

- **Do not use PowerShell's `ConvertFrom-Json` + `ConvertTo-Json` pipeline.**
  - Risk of single-element arrays being converted to strings, and encoding corruption.
- Edit `.obsidian/` config files using **Read + Edit (direct text modification)** only.
- Full overwrite (`Write`) is allowed only when composing the content from scratch.

## Version Logging (Mandatory)

- After modifying any file under `.obsidian/`, **you must** log the version in AIHubVault's `_WORKSPACE_VERSION.md`.
- Do not report task completion without a version log entry.
- This rule applies to **all** workspace edits related to `.obsidian/`, including plugin installation, settings changes, and JSON editing.

## Plugin Install/Uninstall

- Use the `install-plugin` skill for plugin installation, removal, and settings changes.
- Even when installing manually without the skill, follow the safety rules in this document.
