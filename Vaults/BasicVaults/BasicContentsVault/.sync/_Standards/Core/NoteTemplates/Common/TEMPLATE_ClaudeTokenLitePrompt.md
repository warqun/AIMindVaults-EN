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
- Keep Claude input short and precise to reduce token consumption.

## Template
```md
Goal:
- (One single goal for this request)

Context (minimal):
- Project/path:
- Current state in 2-3 lines:

Input Data:
- Only necessary files/logs (max 3)

Output Format:
- Choose: checklist / action items / 10-line summary

Constraints:
- Length: max N lines
- Scope: this task only

Completion Criteria:
- 1-2 items that define when this is done
```

## Short Example
```md
Goal: Identify root cause of 1 SkillSystem issue
Context: Reviewing docs/issues/systems/Logic_ISSUE_INDEX_SkillSystem.md
Input Data: ISSUE note + last 10 log lines
Output Format: 2 potential causes + 1 immediate action
Constraints: 8 lines max
Completion Criteria: Next experiment step is clear
```
