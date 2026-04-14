---
type: meta
tags:
  - forge
  - inbox
agent: claudian
updated: 2026-03-06
---

# _forge/inbox — External Agent Results Inbox

Paste results from external agents (Grok, Gemini, etc.) related to AgentForge development here.

## Usage

| File Name Convention | Purpose |
|---------------------|---------|
| `RESULT_GROK_[topic].md` | Grok results |
| `RESULT_GEMINI_[topic].md` | Gemini results |
| `RESULT_CODEX_[topic].md` | Codex results |

## Currently Pending

- `RESULT_GROK_scripts.md` — install.ps1 / update.ps1 / export.ps1 (Grok Think mode request in progress)

## Rules

- After receiving results, tell Claudian "results are in" and it will process via Read
- Processed files are moved to `staging/` or deleted
