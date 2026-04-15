---
aliases:
  - "Template list"
  - "Note template index"
tags:
  - TileMapToolKit
  - Standards
  - Meta
  - AIMindVault
type: standards
updated: 2026-03-08
agent: claude
---

# NoteTemplates index

## Common/ (shared by all vaults)

| File | Purpose | Notes |
|------|---------|-------|
| [[Common/TEMPLATE_DelegatedTaskPacket]] | Multi-agent task instruction packet | For agent division of labor |
| [[Common/TEMPLATE_FinalDecisionLite]] | Final-decision summary template | For collecting agent results |
| [[Common/TEMPLATE_ClaudeTokenLitePrompt]] | Claude token-saving request template | General |
| [[Common/TEMPLATE_JugglNote]] | General note template with a Juggl embed | General |

## Domain/ (domain vaults only)

| File | Purpose |
|------|---------|
| [[Domain/TEMPLATE_DailyNote]] | Daily log (what you learned, did, thought) |
| [[Domain/TEMPLATE_InboxCapture]] | Quick information capture (classify later) |
| [[Domain/TEMPLATE_ConceptCard]] | Concept card (definition, connections, examples) |
| [[Domain/TEMPLATE_BookNote]] | Reading note (summary, quotes, action points) |

## Project/ (project vaults only)

| File | Purpose |
|------|---------|
| [[Project/TEMPLATE_TaskNote]] | Task note (goal, done criteria, progress) |
| [[Project/TEMPLATE_Milestone]] | Milestone (target, acceptance criteria, period) |
| [[Project/TEMPLATE_DecisionLog]] | Decision log (options, reason, outcome) |
| [[Project/TEMPLATE_Retrospective]] | Retrospective (wins, improvements, next actions) |

## Usage

1. Copy the template, then replace placeholders with real values.
2. Set `updated` to today after creation.
3. Update related index / status documents as well.
4. For orchestration prompt templates see `../Orchestration/README.md`.
5. Templater setting: Template folder → `_Standards/Core/NoteTemplates`
