---
type: meta
tags:
  - forge
  - tasks
agent: claudian
updated: 2026-03-06
---

# _forge/tasks — 외부 에이전트 작업 지시 초안

AgentForge 개발 관련 Grok / Gemini / Codex에 보낼 태스크를 여기서 준비한다.

## 파일명 규칙

| 파일명 | 용도 |
|--------|------|
| `TASK_GROK_[주제].md` | Grok용 작업 지시 |
| `TASK_GEMINI_[주제].md` | Gemini용 작업 지시 |
| `TASK_CODEX_[주제].md` | Codex용 작업 지시 |

## 규칙

- `/grok-route` 결과의 Grok 프롬프트는 여기에 저장해도 됨
- 발송 완료된 태스크는 파일명에 `_SENT` 접미사 추가
