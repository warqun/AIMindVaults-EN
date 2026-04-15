---
aliases:
  - "Claude Token Lite Prompt"
tags:
  - TileMapToolKit
  - Standards
  - Template
  - AIMindVault
  - Claude
  - Token
type: template
updated: 2026-03-04
agent: codex
---

# TEMPLATE_ClaudeTokenLitePrompt

```juggl
local: TEMPLATE_ClaudeTokenLitePrompt
```

## Purpose
- Keep Claude input short and accurate to cut token usage.

## Template
```md
Goal:
- (one single goal for this request)

Context (minimum):
- Project / path:
- Current state, 2–3 lines:

Input data:
- Only the needed files / logs (max 3)

Output format:
- Pick one: checklist / action list / 10-line summary

Constraints:
- Length: max N lines
- Scope: this task only

Done criteria:
- 1–2 things whose change marks done
```

## Short example
```md
Goal: Hypothesize the cause of one SkillSystem issue
Context: reviewing docs/issues/systems/Logic_ISSUE_INDEX_SkillSystem.md
Input data: issue note + last 10 log lines
Output format: 2 causes + 1 immediate action
Constraints: within 8 lines total
Done: the next single experiment is clear
```
