---
tags:
  - TileMapToolKit
type: workflow
updated: 2026-03-17
agent: claude
---

# WORKFLOW — Vault Operational Rules

## 0) Session Bootstrap (Mandatory)

- If starting from the root multi-vault hub: First confirm the target vault via the root `CLAUDE.md`, then read this document.
- Regardless of the task instruction received, read the following documents before starting actual work.
  1) `_STATUS.md` (required)
  2) Agent entry point (CLAUDE.md / CODEX.md / SESSION_RULES.md / .cursor/rules/)
  3) AGENT_STATUS (optional — when complex work history review is needed)
- Do not start work without completing the pre-read procedure above.

> Purpose: Minimize conflicts, inconsistencies, and context waste when multiple agents operate the same Vault in rotation.

## 1) Status Sharing Rules

### Agent List

| Agent | Primary Role | Entry Point | AGENT_STATUS |
|-------|-------------|-------------|--------------|
| Claude Code | Vault design, document authoring, orchestration | `CLAUDE.md` | `.claude/AGENT_STATUS.md` (recommended) |
| Claudian | In-Obsidian content work (Contents only) | `CLAUDE.md` + systemPrompt | — |
| Codex | Structuring, bulk automation, Vault organization | `CODEX.md` | `.codex/AGENT_STATUS.md` (recommended) |
| Antigravity | Research, investigation, content generation | `.antigravity/SESSION_RULES.md` | `.antigravity/AGENT_STATUS.md` (recommended) |
| Cursor | Code editing, refactoring | `.cursor/rules/` (auto-load) | `.cursor/AGENT_STATUS.md` (recommended) |

### Rules

- **`_STATUS.md` = the only required status document** — all agents update it directly at session end
- **AGENT_STATUS = optional record** — updated at the agent's own discretion for complex tasks or context transfer
- **At session start**: Reading `_STATUS.md` is required; reading AGENT_STATUS is optional
- **Root `_STATUS.md`**: Per-vault summary. Update the relevant vault section at session end

## 2) Capacity/Context Conservation Guide

- Keep `_STATUS.md`/`AGENT_STATUS.md` as summaries only (one session's worth)
- For long-term accumulation, use separate files and leave only links

## 3) Tag Operation Rules

- Official tag reference: `Tags/TAGS.md`
- Masking (existing -> official) mapping/procedure: `Tags/TAG_MASK.md`
- Default tags: `AIMindVault`, `Meta`

## 4) Obsidian CLI Bridge Rules

- Tool list: `_tools/TOOLS_INDEX.md`
- Principle: Perform tasks via Obsidian CLI (`aimv bridge`) first; supplement with plugins/MCP only for unsupported tasks.
- Available actions: `vault-info`, `search`, `search-context`, `read`, `open`, `append`, `create`, `history`, `history-read`, `history-restore`, `diff`, `plugins-list`, `plugin-install`, `post-review`

## 5) Edit Mode Separation (Mandatory)

All editing tasks belong to one of the modes below. Do not mix modes.

### Contents Mode (Content Work)

- **Scope**: Files under `Contents/**`
- **Nature**: Creating and editing content related to the vault's subject
- **Prohibited**: Modifying `_Standards/`, `_tools/`, `.claude/`, `.codex/`, `.forge/`, vault root files
- **Exception**: Registering new documents in `_VAULT-INDEX.md` and updating `_STATUS.md` status are allowed

#### Contents Mode Reference Order

| Order | File | Role |
|-------|------|------|
| 1 | `_Standards/CONTENTS_SPEC.md` | Vault purpose, scope, and deliverables definition |
| 2 | `Contents/CONTENTS_GLOSSARY.md` | Vault-specific glossary |
| 3 | `Contents/CONTENTS_AI_RULES.md` | AI task rules |
| 4 | `_Standards/Contents/*` | Vault-specific custom rule details |

#### Contents Mode Internal Branches

| Branch | Scope | Nature |
|--------|-------|--------|
| `[Contents/Domain]` | `Contents/Domain/**` | Knowledge accumulation (guides, research, prompts, agent workflows) |
| `[Contents/Project]` | `Contents/Project/**` | Goal achievement and task management (ideas, plans, issues) |

- Domain and Project can be modified simultaneously within one task, but the target branch must be specified in the mode declaration.

### workspace Mode (Environment Work)

- **Scope**: `_Standards/`, `_tools/`, `.claude/`, `.codex/`, `.forge/`, vault root files, `Tags/`, `Juggl_StyleGuide/`
- **Nature**: Vault structure, settings, rules, scripts, and agent configuration changes
- **Prohibited**: Modifying `Contents/**` body content
- **Exception**: Batch frontmatter tag/metadata updates within `Contents/` are allowed as workspace work

#### workspace Mode — AIHubVault Only (Mandatory)

- **Workspace editing is performed only in AIHubVault.** Other vaults' workspace files are auto-propagated via `aimv sync`.
- After modifying workspace files, version must be recorded in `_WORKSPACE_VERSION.md`.

1. Check the day's highest version number -> create new version as +1 (format: `YYYYMMDDNNNN`)
2. Add the change description to the top of the table

### Mode Operation Rules

1. **Declare mode at work start**: The agent specifies `[Contents/Domain]`, `[Contents/Project]`, or `[workspace]` before starting edits.
2. **Explicit declaration when switching modes**: Switch only after previous mode edits are complete.
3. **When user instructions span multiple modes**: The agent separates by mode and executes sequentially.

---
