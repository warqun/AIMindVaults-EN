---
type: standards
tags:
  - AIMindVault
  - Juggl
  - StyleGuide
updated: 2026-03-04
agent: codex
---

# Juggl Style Guide

This folder explains how current Juggl graph styles classify notes.
All linked example notes are temporary (`EXAMPLE_` prefix) and isolated under `Juggl_StyleGuide/Examples` to avoid confusion with real docs.

## 1) Concept (hexagon, teal)
- Rule: path contains `Juggl_StyleGuide/Examples/01-concept/`
- Example: [[EXAMPLE_JUGGL_Concept]]

```juggl
local: EXAMPLE_JUGGL_Concept
```

## 2) Design (round-rectangle, blue)
- Rule: path contains `Juggl_StyleGuide/Examples/02-design/`
- Example: [[EXAMPLE_JUGGL_Design]]

```juggl
local: EXAMPLE_JUGGL_Design
```

## 3) Spec (rectangle, indigo)
- Rule: path contains `Juggl_StyleGuide/Examples/03-spec/`
- Example: [[EXAMPLE_JUGGL_Spec]]

```juggl
local: EXAMPLE_JUGGL_Spec
```

## 4) Issues (diamond, priority color)
- Rule: path contains `Juggl_StyleGuide/Examples/issues/`
- Base color: neutral slate (not alarm-red by default)
- Priority color override (issue notes only, based on tags `priority/*`):
- `priority: high` -> red
- `priority: medium` -> yellow
- `priority: low` -> sky blue (recommended)
- Hub: [[EXAMPLE_JUGGL_Issue]]
- Priority/Status samples:
- [[EXAMPLE_JUGGL_Issue_High_InProgress]]
- [[EXAMPLE_JUGGL_Issue_Medium_Open]]
- [[EXAMPLE_JUGGL_Issue_Low_Done]]
- [[EXAMPLE_JUGGL_Issue_High_Reopened]]

```juggl
local: EXAMPLE_JUGGL_Issue
```

## 5) Debug (star, purple)
- Rule: path contains `Juggl_StyleGuide/Examples/04-debug/`
- Example: [[EXAMPLE_JUGGL_Debug]]

```juggl
local: EXAMPLE_JUGGL_Debug
```

## 6) Temp (muted gray)
- Rule: path contains `Juggl_StyleGuide/Examples/temp/`
- Example: [[EXAMPLE_JUGGL_Temp]]

```juggl
local: EXAMPLE_JUGGL_Temp
```

## 7) Status Border (applies to all notes)
- `미결`, `todo`, `open` -> orange border
- `진행중` family, `방향 확정` -> green border
- `문제재발`, `reopen`, `regression` -> red border
- `완결`, `완료`, `done`, `closed`, `resolved` -> normal border (no special highlight)

## Note
- These are demonstration notes only.
- Remove all `EXAMPLE_` notes when no longer needed.
- If style rules change, update both `graph.css` and this guide (EN/KR) together.

