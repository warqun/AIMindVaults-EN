---
type: guide
tags:
  - AIMindVault
  - Meta
updated: 2026-04-15
---

# Setup Guide

> First-time installation on a new machine, or a handoff reference.
> Agents also use this during onboarding to detect what's missing and walk the user through it.

---

## Quick start

1. Copy the `AIMindVaults` folder anywhere on disk (or `git clone`).
2. Install Obsidian and launch it.
3. Vault switcher → **Open folder as vault** → pick `Vaults/BasicVaults/AIHubVault`.
4. Repeat for `Vaults/BasicVaults/BasicContentsVault`.
5. On first open, click **Trust author and enable plugins** — Hub-Sync runs automatically.

That's it for the happy path. The sections below exist for troubleshooting and for agents verifying the environment.

---

## Required software

### 1. Obsidian (required)

The vault viewer. Without it, there's nothing to look at.

- Download: https://obsidian.md/download
- Install the downloaded package with defaults.
- Verify: launch Obsidian from the Start menu / Applications.

### 2. Obsidian CLI (required)

Lets the terminal drive Obsidian. Agent automation and scripts depend on it.

- Enable: Obsidian → Settings (gear icon) → **General** → toggle **Enable CLI**.
- Verify: `obsidian --help` in a terminal prints the help text.

> If you see "Please download the latest installer", your installer is outdated. Re-download from https://obsidian.md/download and reinstall.

### 3. Node.js (conditional)

Required by the `aimv` CLI and several community plugins (e.g. local-rest-api). Skip only if you're using Obsidian purely as a read-only viewer with no agents.

- Download: https://nodejs.org/ (LTS recommended)
- Install with defaults.
- Verify: `node --version` prints a version string.

### 4. AI agent (optional)

Install whichever agents you plan to use.

| Agent | Install | Notes |
|-------|---------|-------|
| Claude Code | `npm install -g @anthropic-ai/claude-code` | Needs Node.js |
| Codex | Codex desktop app or CLI | Separate install |

---

## Registering vaults in Obsidian

1. Launch Obsidian.
2. Click the vault switcher (vault icon, lower-left).
3. **Open folder as vault**.
4. Select `AIMindVaults/Vaults/BasicVaults/AIHubVault`.
5. Click **Trust author and enable plugins**.
6. Repeat for any other vault you want to open.

### What happens on first open

Shell Commands fires `syncworkspace` on the `on-layout-ready` event. The `.sync/` folder is created and the Hub's workspace is pulled down. You don't need to do anything — just wait for the first open to settle.

---

## Agent reference

When an agent starts a session in a fresh environment:

1. Run the environment check from `AGENT_ONBOARDING.md` §6 to see what's present.
2. For anything missing, quote the matching section above and walk the user through it.
3. If a vault isn't registered in Obsidian yet, point the user at "Registering vaults in Obsidian".

---

## Context window tuning (optional)

MCP servers and plugins you add on top of the default can grow the baseline. Use the knobs below to keep it in check. (For background and architecture, see the README; for detailed numbers and interpretation, see `docs/context-optimization.md`.)

### 1. Scope MCP servers

**Global `~/.claude/settings.json`** — keep only servers you need in every session:

```json
{
  "mcpServers": {
    "notion": { "command": "npx", "args": ["-y", "@notionhq/notion-mcp-server"] }
  }
}
```

**Per-project `.claude/settings.json`** — move domain-specific servers into the project that uses them:

```json
{
  "mcpServers": {
    "blender": { "command": "uvx", "args": ["blender-mcp"] }
  }
}
```

These are loaded only when Claude Code runs with that project as CWD.

### 2. Scope plugins

Disable globally:

```json
{
  "enabledPlugins": { "bkit@bkit-marketplace": false }
}
```

Re-enable per project when needed:

```json
{
  "enabledPlugins": { "bkit@bkit-marketplace": true }
}
```

### 3. Desktop / Claude.ai connectors

Not controlled by Claude Code settings. Disable unused Desktop MCP / Claude.ai Connectors in their respective app settings.

### Back up before changing settings

```bash
cp ~/.claude/settings.json ~/.claude/settings.json.backup-$(date +%Y%m%d)
```
