---
aliases:
  - "Vault Index"
  - "Vault Map"
tags:
  - AIMindVault
  - Meta
type: _VAULT-INDEX
updated: 2026-03-11
agent: antigravity
---

# _VAULT-INDEX — Workspace Index

> A map for agents to understand "where things are" in this Vault.
> For content structure, see `Contents/CONTENTS_INDEX.md`.
> Multi-vault root entry point: root `CODEX.md` or `CLAUDE.md`.

---

## 1. Vault Root Structure

```
{VaultName}/
├── CLAUDE.md            <- Vault-specific Claude entry point
├── CODEX.md             <- Vault-specific Codex entry point
├── _VAULT-INDEX.md       <- This file (workspace index)
├── _STATUS.md            <- Master progress status
├── _WORKFLOW.md          <- Vault operational rules
├── _WORKSPACE_VERSION.md <- Workspace version tracking
├── _forge/              <- Workspace distribution hub (inbox/staging/tasks)
├── _tools/               <- Automation scripts and CLI tools
├── _Standards/           <- Vault consistency standards
├── _VaultReview/         <- Agent-generated review reports
├── Tags/                <- Tag notes
├── Juggl_StyleGuide/    <- Juggl mapping guide (generic template)
├── CLI_MEMORY/          <- CLI agent memory
├── Contents/            <- Vault content (details: Contents/CONTENTS_INDEX.md)
├── .claude/
│   ├── commands/        <- Project-specific skills
│   └── rules/           <- Auto-applied rules
├── .codex/              <- Codex-specific memory/status
└── .antigravity/        <- Antigravity-specific memory/status
```

---

## 2. _Standards/ Consistency Standards

| File/Folder | Content |
|-------------|---------|
| `Core/WritingStandards.md` | Complete writing standards for filenames, folders, frontmatter, status icons, tables, links, etc. |
| `Core/NoteProperties.md` | Note property (frontmatter) field definitions and checklist — **must read when AI generates notes** |
| `Core/MultiAgent_Coordination_Pattern.md` | Multi-agent coordination pattern reference |
| `Core/AI_ObsidianCLI_Usage.md` | AI-First Obsidian CLI operational standards |
| `Core/AI_Collaboration_Strategy.md` | AI collaboration strategy |
| `Core/AI_Note_Environment.md` | AI note environment settings |
| `Core/Encoding_BulkEdit_Safety.md` | Encoding safety rules (bulk editing) |
| `Core/Grok_Usage_Guidelines.md` | Grok usage guidelines |
| `Core/OLLAMA_ORCHESTRATION_GUIDE.md` | Ollama orchestration configuration/prompt guide |
| `Core/Juggl_StyleGuide_Operations.md` | Juggl style synchronization operational rules |
| `Core/Obsidian_CLI_Command_List.md` | Obsidian CLI command list |
| `Core/Obsidian_Plugin_Environment.md` | Obsidian plugin environment |
| `Core/Pre_Prompt_Commands.md` | Pre-prompt commands |
| `Core/Script_Creation_Rule.md` | Script creation/management rules |
| `Core/Script_Registry.md` | Script registration ledger |
| `Core/Operations/` | Operational checklists |
| `Core/Plugins/` | Plugin function/syntax index |
| `Core/NoteTemplates/` | Note template folder |
| `Core/VaultTypes/` | Vault type specs (Domain / Project) |
| `CONTENTS_SPEC.md` | Vault identity and content scope definition (vault-specific) |
| `Contents/` | Vault-specific custom rules (vault-specific) |

---

## 3. _forge/ Distribution Hub

| Folder | Purpose |
|--------|---------|
| `inbox/` | Incoming queue for external agent deliverables |
| `staging/` | Pre-deployment reviewed and prepared scripts/settings |
| `tasks/` | Deployment-related task instruction drafts |

---

## 4. _VaultReview/ Review Reports

> Agent-generated Vault analysis and review documents. Used as reference for decision-making.

---

> This file is a **Hub-Sync target**. AIHubVault is the source.
> Update this file when the structure changes.
