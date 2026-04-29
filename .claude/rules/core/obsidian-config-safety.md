# Safe Editing of Obsidian Config Files (Mandatory)

> Applied uniformly to every vault.

## Rules

- Files under `.obsidian/` (plug-in settings, `community-plugins.json`, etc.) are **workspace edits**.
- Per the workspace-edit rules, edits happen **only in the AIHubVault** → propagation via `node cli.js sync`.

## `.obsidian/` JSON Editing — Safety Rules

- **Do not use the PowerShell `ConvertFrom-Json` → `ConvertTo-Json` pipeline.**
  - Has a known bug where a single-element array becomes a string, plus encoding-corruption risk.
- Edit `.obsidian/` config files using **Read → Edit (direct text edit)** only.
- Full overwrites (`Write`) are allowed only when you author the content yourself.

## Version Recording (Mandatory)

- After any edit under `.obsidian/`, **always** record the version in the AIHubVault `_WORKSPACE_VERSION.md`.
- Do not report task completion without the version record.
- This applies to **all** workspace edits related to `.obsidian/` — plug-in installs, setting changes, JSON edits, etc.

## Plug-In Install / Removal

- Use the `install-plugin` skill to install / remove plug-ins or change their settings.
- Even when installing manually without the skill, follow the safety items above.
