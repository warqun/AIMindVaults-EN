---
type: meta
tags:
  - forge
  - inbox
  - AIMindVault
agent: claudian
updated: 2026-03-06
---

# _forge/inbox — External Agent Result Inbox

Paste outputs from external agents (Grok, Gemini, etc.) related to AgentForge development here.

## Usage

| File Naming Convention | Purpose |
|----------------------|---------|
| `RESULT_GROK_[topic].md` | Grok output |
| `RESULT_GEMINI_[topic].md` | Gemini output |
| `RESULT_CODEX_[topic].md` | Codex output |

## Currently Pending

- `RESULT_GROK_scripts.md` — install.ps1 / update.ps1 / export.ps1 (Grok Think mode request in progress)

## Rules

- After receiving a result, tell Claudian "result is in" and it will process via Read
- Processed files are moved to `staging/` or deleted
