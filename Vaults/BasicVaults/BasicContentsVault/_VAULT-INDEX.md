---
aliases:
  - "Vault index"
  - "Vault map"
tags:
  - Meta
type: _VAULT-INDEX
updated: 2026-04-15
agent: claude
---

# _VAULT-INDEX — Workspace Index

> Map used by agents to locate the "workspace" inside this Vault.
> For content structure, see `Contents/CONTENTS_INDEX.md`.
> The multi-vault root entry point is the root `CODEX.md` or `CLAUDE.md`.

---

## 1. Vault root structure

```
{VaultName}/
├── CLAUDE.md            ← Vault-specific Claude entry point
├── CODEX.md             ← Vault-specific Codex entry point
├── _VAULT-INDEX.md      ← this file (workspace index)
├── _STATUS.md           ← master progress state
├── _WORKFLOW.md         ← Vault operational rules
├── _WORKSPACE_VERSION.md ← workspace version tracker
├── _tools/              ← automation scripts and CLI tools
├── _Standards/          ← Vault consistency baselines
├── _VaultReview/        ← agent-generated review reports
├── Tags/                ← tag notes
├── Juggl_StyleGuide/    ← Juggl mapping guide (generic template)
├── CLI_MEMORY/          ← CLI agent memory
├── Contents/            ← vault contents (details: Contents/CONTENTS_INDEX.md)
├── .claude/
│   ├── commands/        ← project-specific skills
│   └── rules/           ← auto-applied rules
└── .codex/              ← Codex-specific memory / state
```

---

## 2. _Standards/ consistency baselines

| File / folder | Contents |
|---------------|----------|
| `Core/WritingStandards.md` | Full authoring baseline: filenames, folders, frontmatter, status icons, tables, links |
| `Core/NoteProperties.md` | Note property (frontmatter) field definitions and checklist — **required reading when AI creates a note** |
| `Core/MultiAgent_Coordination_Pattern.md` | Reference material for multi-agent coordination patterns |
| `Core/AI_ObsidianCLI_Usage.md` | AI-First Obsidian CLI operating baseline |
| `Core/AI_Collaboration_Strategy.md` | AI collaboration strategy |
| `Core/AI_Note_Environment.md` | AI note environment setup |
| `Core/Encoding_BulkEdit_Safety.md` | Encoding safety rules (bulk edits) |
| `Core/Grok_Usage_Guidelines.md` | Grok usage guidelines |
| `Core/OLLAMA_ORCHESTRATION_GUIDE.md` | Ollama orchestration / prompt guide |
| `Core/Juggl_StyleGuide_Operations.md` | Juggl style-sync operational rules |
| `Core/Obsidian_CLI_Command_List.md` | Obsidian CLI command list |
| `Core/Obsidian_Plugin_Environment.md` | Obsidian plugin environment |
| `Core/Pre_Prompt_Commands.md` | Pre-prompt command list |
| `Core/Script_Creation_Rule.md` | Script creation / management rule |
| `Core/Script_Registry.md` | Script registry |
| `Core/Operations/` | Operational checklists |
| `Core/Plugins/` | Plugin capability / syntax index |
| `Core/NoteTemplates/` | Note template folder |
| `Core/VaultTypes/` | Vault type specs (Domain / Project) |
| `CONTENTS_SPEC.md` | Vault identity and content-scope definition (vault-specific) |
| `Contents/` | Vault-specific custom rules (vault-specific) |

---

## 3. _VaultReview/ review reports

> Vault analysis / review documents produced by agents. Reference when making decisions.

---

> This file is **subject to hub sync**, with AIHubVault as the source of truth.
> Update this file alongside any structural change.
