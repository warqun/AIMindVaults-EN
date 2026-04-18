---
tags:
type: plugin-standard
plugin: obsidian-shellcommands
updated: 2026-03-05
---

# Shell Commands

## Features

- Bind Obsidian events / commands to local scripts
- ~~Startup-routine automation (`_tools/open_agents.ps1`)~~ → **Discontinued** (one IDE launch from the multi-vault root is enough)

## Main uses

- ~~Auto-launch dev tools on vault start~~ → abolished
- Shortcut execution of recurring verification scripts

> [!NOTE]
> Unhook the `on-layout-ready` → `open_agents.ps1` binding.
> Obsidian → Settings → Shell Commands → Events, and remove that event.

## Basic procedure

1. Split the command into a `_tools/` script
2. Register the command in the plugin
3. Bind to an event (`on-layout-ready`, etc.)

## Notes

- Put a confirmation step before write / delete commands.
