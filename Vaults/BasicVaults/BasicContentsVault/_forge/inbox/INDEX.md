---
type: meta
tags:
  - forge
  - inbox
  - AIMindVault
agent: claudian
updated: 2026-03-06
---

# _forge/inbox — 외부 에이전트 결과 수신함

AgentForge 개발 관련 외부 에이전트(Grok, Gemini 등) 결과물을 여기에 붙여넣는다.

## 사용법

| 파일명 규칙 | 용도 |
|------------|------|
| `RESULT_GROK_[주제].md` | Grok 결과물 |
| `RESULT_GEMINI_[주제].md` | Gemini 결과물 |
| `RESULT_CODEX_[주제].md` | Codex 결과물 |

## 현재 대기 중

- `RESULT_GROK_scripts.md` — install.ps1 / update.ps1 / export.ps1 (Grok Think 모드 요청 중)

## 규칙

- 결과물 수신 후 Claudian에게 "결과 넣었어" 하면 Read로 처리
- 처리 완료된 파일은 `staging/` 으로 이동 또는 삭제
