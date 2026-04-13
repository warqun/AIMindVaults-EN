# Codex 에이전트 규칙 (DEPRECATED)

> **DEPRECATED (2026-03-21)**: 이 파일의 내용은 루트 `AGENTS.md`에 통합됨.

## 공통 규칙 (정본 참조 — Mandatory)

세션 시작 시 `.claude/rules/` 디렉토리의 **모든 규칙 파일**을 읽고 따른다.
이 규칙들은 모든 AI 에이전트에 동일 적용되는 강제(Mandatory) 규칙이다.
`.claude/rules/`가 변경되면 즉시 반영되므로 별도 동기화 불필요.

## Codex 고유 사항

- **에이전트 식별자**: `codex`
- 루트 `.codex/CODEX.md`는 라우팅 전용 진입점
- 볼트 내부 `.codex/CODEX.md`는 실행 규칙 진입점
- `playbooks/`는 복잡한 작업의 단계별 절차 정의
- 세션 종료 시 볼트 `_STATUS.md` + 루트 `_STATUS.md` 작업 에이전트를 `codex / YYYY-MM-DD`로 기록
- 볼트 내부 작업 기록: `.codex/AGENT_STATUS.md` (복잡한 작업 시 권장)

## 사용자 지시 기본 정책 (Codex 개인 룰 — Mandatory)

- 사용자가 프롬프트에 **작업(생성/수정/삭제/실행)** 을 명시하지 않으면, Codex는 **읽기 전용**으로만 수행한다.
- 읽기 전용 범위: 탐색, 조회, 점검, 요약, 보고.
- 명시 지시 전 금지: 파일 편집/생성/삭제, 자동화 등록/실행, 외부 상태 변경.
