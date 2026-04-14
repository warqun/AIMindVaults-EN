---
aliases:
  - "Template List"
  - "Note Template Index"
tags:
  - TileMapToolKit
  - Standards
  - Meta
  - AIMindVault
type: standards
updated: 2026-03-08
agent: claude
---

# NoteTemplates Index

## Common/ (Shared Across All Vaults)

| File | Purpose | Notes |
|------|---------|-------|
| [[Common/TEMPLATE_DelegatedTaskPacket]] | Multi-agent task delegation packet | For agent task distribution |
| [[Common/TEMPLATE_FinalDecisionLite]] | Final conclusion summary template | For collecting agent results |
| [[Common/TEMPLATE_ClaudeTokenLitePrompt]] | Claude token-saving request template | General purpose |
| [[Common/TEMPLATE_JugglNote]] | General note template with Juggl | General purpose |

## Domain/ (Domain Vault Specific)

| File | Purpose |
|------|---------|
| [[Domain/TEMPLATE_DailyNote]] | Daily log (things learned, done, and thoughts) |
| [[Domain/TEMPLATE_InboxCapture]] | Quick information capture (sort later) |
| [[Domain/TEMPLATE_ConceptCard]] | Concept card (definition, connections, examples) |
| [[Domain/TEMPLATE_BookNote]] | Book note (summary, quotes, action points) |

## Project/ (Project Vault Specific)

| File | Purpose |
|------|---------|
| [[Project/TEMPLATE_TaskNote]] | Task note (goal, completion criteria, progress) |
| [[Project/TEMPLATE_Milestone]] | Milestone (targets, success criteria, timeline) |
| [[Project/TEMPLATE_DecisionLog]] | Decision log (options, rationale, outcome) |
| [[Project/TEMPLATE_Retrospective]] | Retrospective (what went well, improvements, next actions) |

## Usage Rules
1. Copy the template and replace placeholders with actual values.
2. Set the updated date to today after creation.
3. Update related index/status documents accordingly.
4. For orchestration prompt templates, refer to `../Orchestration/README.md`.
5. Templater setting: Template folder → `_Standards/Core/NoteTemplates`
