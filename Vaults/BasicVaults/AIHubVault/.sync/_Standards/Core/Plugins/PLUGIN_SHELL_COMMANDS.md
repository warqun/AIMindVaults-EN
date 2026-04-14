---
tags:
  - TileMapToolKit
type: plugin-standard
plugin: obsidian-shellcommands
updated: 2026-03-05
---

# Shell Commands

## Features

- Connect Obsidian events/commands to local scripts
- ~~Startup routine automation (`_tools/open_agents.ps1`)~~ → **Deprecated** (opening IDE once from multi-vault root is sufficient)

## Primary Use Cases

- ~~Auto-launch dev tools on vault startup~~ → Deprecated
- Shortcut execution of repetitive verification scripts

> [!NOTE]
> You must disconnect `open_agents.ps1` from the `on-layout-ready` event.
> Remove the event in Obsidian → Settings → Shell Commands → Events.

## Basic Procedure

1. Separate commands into `_tools/` scripts
2. Register commands in the plugin
3. Connect to events (on-layout-ready, etc.)

## Caution

- Write/delete commands should have a separate confirmation step.
