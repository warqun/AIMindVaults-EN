---
type: guide
tags:
  - AIMindVault
  - Meta
updated: 2026-04-08
---

# AIMindVaults Setup Guide

> Reference document for setting up AIMindVaults on a new PC or sharing with others.
> AI agents can reference this document during onboarding to guide users through missing installations.

---

## Quick Start

1. Copy the AIMindVaults folder to your desired location or `git clone`
2. Install and launch Obsidian
3. Vault manager → **"Open folder as vault"** → select `Vaults/BasicVaults/AIHubVault`
4. Repeat for `Vaults/BasicVaults/BasicContentsVault`
5. On first open, approve "Trust author and enable plugins" → automatic sync runs

---

## External Software Installation

### 1. Obsidian (Required)

The vault viewer. Notes cannot be viewed without it.

- **Download**: https://obsidian.md/download
- **Install**: Run the downloaded installer
- **Verify**: Search for "Obsidian" in the Start menu

### 2. Obsidian CLI (Required)

Enables terminal control of Obsidian. Required for agent automation and script integration.

- **How to enable**:
  1. Launch Obsidian
  2. Settings (gear icon, bottom-left) → General
  3. Toggle **"Enable CLI"** on
- **Verify**: Run `obsidian --help` in terminal — help text should appear

> If the installer is outdated, you may see "Please download the latest installer". In that case, reinstall the latest version from https://obsidian.md/download.

### 3. Node.js (Conditional)

Required by some community plugins such as local-rest-api. Not needed if using Obsidian purely as a viewer without AI agents.

- **Download**: https://nodejs.org/ (LTS version recommended)
- **Install**: Run the downloaded installer. Proceed with default options.
- **Verify**: Run `node --version` in terminal — version number should appear

### 4. AI Agent (Optional)

Install the agent if you plan to use AI agents.

| Agent | Installation | Notes |
|-------|-------------|-------|
| Claude Code | `npm install -g @anthropic-ai/claude-code` | Requires Node.js |
| Codex | Codex desktop app or CLI | Separate installation |

---

## Registering Vaults in Obsidian

1. Launch Obsidian
2. Click the vault switcher (vault icon, bottom-left)
3. Select "Open folder as vault"
4. Choose the `AIMindVaults/Vaults/BasicVaults/AIHubVault` folder
5. Click "Trust author and enable plugins"
6. Repeat for remaining vaults

### Initial Sync Trigger

When a vault is opened in Obsidian, the Shell Commands plugin automatically runs `syncworkspace` via the `on-layout-ready` event. This creates the `.sync/` folder and synchronizes the workspace from the Hub.

---

## Agent Reference

When an agent starts a session in a new environment:

1. Run the §6 environment check from `AGENT_ONBOARDING.md` to assess the current state
2. If anything is missing, cite the relevant section of this document to guide installation
3. If vaults are not registered, guide through the "Registering Vaults in Obsidian" procedure above
