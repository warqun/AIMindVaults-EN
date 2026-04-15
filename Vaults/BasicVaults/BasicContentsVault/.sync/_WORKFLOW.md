---
tags:
  - AIMindVault
type: workflow
updated: 2026-04-15
agent: claude
---

# WORKFLOW — Vault Operation Rules

## 0) Session bootstrap (mandatory)

- If starting from the multi-vault root hub, first confirm the target vault via the root `CLAUDE.md`, then read this document.
- No matter what task is requested, read the following documents before starting actual work:
  1) `_STATUS.md` (required)
  2) Agent entry point (CLAUDE.md / CODEX.md / SESSION_RULES.md / .cursor/rules/)
  3) AGENT_STATUS (optional — when you need history of a complex task)
- Do not start work if this pre-read sequence is skipped.

> Purpose: minimize conflicts, inconsistencies, and wasted context when multiple agents take turns operating the same Vault.

## 1) State sharing rules

### Agent roster

| Agent | Primary role | Entry point | AGENT_STATUS |
|-------|--------------|-------------|--------------|
| Claude Code | Vault design, documentation, orchestration | `CLAUDE.md` | `.claude/AGENT_STATUS.md` (recommended) |
| Claudian | Content work inside Obsidian (Contents only) | `CLAUDE.md` + systemPrompt | — |
| Codex | Structuring, bulk automation, Vault organization | `CODEX.md` | `.codex/AGENT_STATUS.md` (recommended) |
| Cursor | Code editing, refactoring | `.cursor/rules/` (auto-loaded) | `.cursor/AGENT_STATUS.md` (recommended) |

### Rules

- **`_STATUS.md` is the single required state document** — every agent updates it directly at session end.
- **AGENT_STATUS is optional** — update at the agent's own discretion when a task is complex or context handoff is required.
- **At session start**: reading `_STATUS.md` is required; reading AGENT_STATUS is optional.
- **Root `_STATUS.md`**: per-vault summary. Update the relevant vault's section at session end.

## 2) Size / context saving guide

- Keep `_STATUS.md` / `AGENT_STATUS.md` as a summary only (one session worth).
- Move long-term accumulations to separate files and leave only links.

## 3) Tag management rules

- Canonical tag baseline: `Tags/TAGS.md`
- Masking (legacy → canonical) mapping and procedure: `Tags/TAG_MASK.md`
- Default tags: `AIMindVault`, `Meta`

## 4) Obsidian CLI bridge rules

- Tool list: `_tools/TOOLS_INDEX.md`
- Principle: prefer the Obsidian CLI (`aimv bridge`) whenever possible; fall back to plugins/MCP only for unsupported operations.
- Available actions: `vault-info`, `search`, `search-context`, `read`, `open`, `append`, `create`, `history`, `history-read`, `history-restore`, `diff`, `plugins-list`, `plugin-install`, `post-review`.

## 5) Edit-mode separation (mandatory)

Every edit belongs to exactly one of the modes below. Do not mix modes.

### Contents mode (content work)

- **Target**: files under `Contents/**`
- **Nature**: authoring / editing content related to the vault's topic
- **Forbidden**: modifying `_Standards/`, `_tools/`, `.claude/`, `.codex/`, `.forge/`, or vault root files
- **Exceptions**: registering a new document in `_VAULT-INDEX.md` and updating state in `_STATUS.md` are allowed

#### Contents mode reference order

| Order | File | Role |
|-------|------|------|
| 1 | `_Standards/CONTENTS_SPEC.md` | Vault purpose, scope, and artifacts |
| 2 | `Contents/CONTENTS_GLOSSARY.md` | Vault-specific glossary |
| 3 | `Contents/CONTENTS_AI_RULES.md` | AI work rules |
| 4 | `_Standards/Contents/*` | Detailed vault-specific custom rules |

#### Contents mode internal branches

| Branch | Target | Nature |
|--------|--------|--------|
| `[Contents/Domain]` | `Contents/Domain/**` | Knowledge accumulation (guides, research, prompts, agent workflows) |
| `[Contents/Project]` | `Contents/Project/**` | Goal delivery and task management (ideas, plans, issues) |

- You may edit both Domain and Project within one task, but declare the target branch when declaring the mode.

### workspace mode (environment work)

- **Target**: `_Standards/`, `_tools/`, `.claude/`, `.codex/`, `.forge/`, vault root files, `Tags/`, `Juggl_StyleGuide/`
- **Nature**: changes to vault structure, settings, rules, scripts, or agent configuration
- **Forbidden**: editing `Contents/**` content bodies
- **Exception**: batch frontmatter tag / metadata updates inside `Contents/` are treated as workspace work

#### workspace mode — AIHubVault only (mandatory)

- **workspace edits must be performed in AIHubVault.** Other vaults receive workspace files via `aimv sync`.
- After editing a workspace file, you must record the version in `_WORKSPACE_VERSION.md`.

1. Find the highest version for today → create the next one as `+1` (format: `YYYYMMDDNNNN`).
2. Add the change summary to the top of the table.

### Mode operation rules

1. **Declare the mode at work start**: before editing, the agent explicitly declares `[Contents/Domain]`, `[Contents/Project]`, or `[workspace]`.
2. **Declare explicitly when switching**: finish the previous mode's edits, then switch.
3. **When the user's instruction spans modes**: the agent splits the work by mode and runs them sequentially.

---
