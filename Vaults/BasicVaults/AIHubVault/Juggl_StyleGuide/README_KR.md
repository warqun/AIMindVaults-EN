---
type: standards
tags:
  - AIMindVault
  - Juggl
  - StyleGuide
updated: 2026-03-04
agent: codex
---

# Juggl 스타일 가이드 (요약)

이 폴더는 현재 Juggl 그래프 스타일이 노트를 어떤 기준으로 분류하는지 설명합니다.
예시 노트는 모두 임시(`EXAMPLE_` 접두어)이며, 실제 문서와 혼동되지 않도록 `Juggl_StyleGuide/Examples` 아래에만 둡니다.

## 1) Concept (육각형, 청록)
- 기준: `Juggl_StyleGuide/Examples/01-concept/` 경로
- 예시: [[EXAMPLE_JUGGL_Concept]]

```juggl
local: EXAMPLE_JUGGL_Concept
```

## 2) Design (둥근 사각형, 파랑)
- 기준: `Juggl_StyleGuide/Examples/02-design/` 경로
- 예시: [[EXAMPLE_JUGGL_Design]]

```juggl
local: EXAMPLE_JUGGL_Design
```

## 3) Spec (사각형, 남색)
- 기준: `Juggl_StyleGuide/Examples/03-spec/` 경로
- 예시: [[EXAMPLE_JUGGL_Spec]]

```juggl
local: EXAMPLE_JUGGL_Spec
```

## 4) Issues (마름모, 우선순위 색)
- 기준: `Juggl_StyleGuide/Examples/issues/` 경로
- 기본 색: 중립 회청색(기본 빨강 사용 안 함)
- 우선순위 색상(이슈 노트에만 적용, `tags: priority/*` 기준):
- `priority: high` -> 빨강
- `priority: medium` -> 노랑
- `priority: low` -> 하늘색(권장)
- 허브: [[EXAMPLE_JUGGL_Issue]]
- 우선순위/상태 예시:
- [[EXAMPLE_JUGGL_Issue_High_InProgress]]
- [[EXAMPLE_JUGGL_Issue_Medium_Open]]
- [[EXAMPLE_JUGGL_Issue_Low_Done]]
- [[EXAMPLE_JUGGL_Issue_High_Reopened]]

```juggl
local: EXAMPLE_JUGGL_Issue
```

## 5) Debug (별 모양, 보라)
- 기준: `Juggl_StyleGuide/Examples/04-debug/` 경로
- 예시: [[EXAMPLE_JUGGL_Debug]]

```juggl
local: EXAMPLE_JUGGL_Debug
```

## 6) Temp (회색, 약한 강조)
- 기준: `Juggl_StyleGuide/Examples/temp/` 경로
- 예시: [[EXAMPLE_JUGGL_Temp]]

```juggl
local: EXAMPLE_JUGGL_Temp
```

## 7) 상태 외곽선 (모든 노트 공용)
- `미결`, `todo`, `open` -> 주황 외곽선
- `진행중` 계열, `방향 확정` -> 초록 외곽선
- `문제재발`, `reopen`, `regression` -> 빨강 외곽선
- `완결`, `완료`, `done`, `closed`, `resolved` -> 기본 외곽선(특수 강조 없음)

## 참고
- 예시 노트는 시각 확인용 임시 노트입니다.
- 더 이상 필요 없으면 `EXAMPLE_` 노트를 정리합니다.
- 스타일 규칙이 바뀌면 `graph.css`와 가이드(영문/한글)를 반드시 같이 갱신합니다.

