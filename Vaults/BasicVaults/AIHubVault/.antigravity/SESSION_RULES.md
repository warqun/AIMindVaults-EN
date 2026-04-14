---
type: workflow
tags:
  - AIMindVault
  - Meta
  - antigravity
updated: 2026-03-19
agent: antigravity
---

# Antigravity Session Rules (DEPRECATED)

> **DEPRECATED (2026-03-21)**: Transitioned from Antigravity to Codex desktop app. Use `AGENTS.md` at vault root.

> Antigravity-specific session entry point.

## Common Rules (Authoritative Reference — Mandatory)

Read and follow **all rule files** in the root `.claude/rules/` directory.
These are mandatory rules that apply equally to all AI agents.

## Role of This Vault

**AI Workspace Design, Improvement & Distribution Hub** — Manages AI operational structures including `_Standards`, `_tools`, `.claude`, `_forge`.

## Session Start Routine (Mandatory)

1. Read all of root `.claude/rules/` — Common mandatory rules
2. Check root `_STATUS.md` — Overall vault status
3. Check `_STATUS.md` — Current status of this vault
4. Check `.antigravity/AGENT_STATUS.md` — My last work status
5. Understand workspace structure via `_VAULT-INDEX.md`

## Antigravity-Specific Items

- **Agent identifier**: `antigravity`
- Background agent — token conservation is top priority
- Workflow execution: See root `.antigravity/workflows/`
- At session end, record working agent in vault `_STATUS.md` + root `_STATUS.md` as `antigravity / YYYY-MM-DD`

## Relationship with Other Agents

| Agent | Entry Point | Common Rules |
|-------|------------|--------------|
| Antigravity (me) | `.antigravity/SESSION_RULES.md` | References `.claude/rules/` |
| Claude Code | `CLAUDE.md` | `.claude/rules/` (authoritative) |
| Codex | `.codex/CODEX.md` | References `.claude/rules/` |
| Cursor | `.cursor/rules/` | References `.claude/rules/` |
