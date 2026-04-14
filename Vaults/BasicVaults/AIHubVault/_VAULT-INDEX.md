---
aliases:
  - "Vault index"
  - "Vault map"
tags:
  - AIHubVault
  - Meta
type: folder-index
updated: 2026-04-15
---

# _VAULT-INDEX — Workspace Index

> Map for agents to find the workspace structure of this vault.
> Content structure: see `Contents/CONTENTS_INDEX.md`.
> Multi-vault root entry points: root `CLAUDE.md` or `AGENTS.md`.

---

## 1. Vault root layout

```
{VaultName}/
├── CLAUDE.md             ← vault-specific Claude entry point
├── AGENTS.md             ← vault-specific Codex entry point
├── _VAULT-INDEX.md       ← this file (workspace index)
├── _STATUS.md            ← current progress
├── _WORKFLOW.md          ← vault operational rules
├── _WORKSPACE_VERSION.md ← workspace version tracker
├── .sync/                ← sync machinery (Hub marker + CLI tools)
│   ├── .hub_marker       ← Hub-only
│   └── _tools/cli-node/  ← Node.js CLI (`aimv`)
├── _Standards/           ← vault consistency standards
├── Tags/                 ← tag definition notes
├── Juggl_StyleGuide/     ← Juggl mapping guide (generic template)
├── Contents/             ← vault content (see Contents/CONTENTS_INDEX.md)
├── .claude/
│   ├── commands/         ← vault-specific skills
│   └── rules/            ← auto-applied rules
└── .codex/               ← Codex-specific memory / state
```

---

## 2. `_Standards/` consistency baselines

| File / folder | Purpose |
|---------------|---------|
| `Core/AI_Rules_Index.md` | Full index of AI-agent rules |
| `Core/Script_Registry.md` | Registry of automation scripts |
| `Core/Hub_Sync_Targets.md` | Files / folders propagated by Hub-Sync |
| `Core/VaultTypes/` | Vault-type specs (Domain / Project / Lab / …) |
| `Core/Plugins/` | Plugin feature / syntax index |
| `Core/NoteTemplates/` | Note templates |
| `CONTENTS_SPEC.md` | Vault identity + content scope (vault-specific) |
| `Contents/` | Vault-specific custom rules |

---

## 3. Notes

- This file is **a Hub-Sync target**. AIHubVault is the source.
- Update this file together with any structural change.
