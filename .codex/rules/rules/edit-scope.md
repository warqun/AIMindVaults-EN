# Codex Root Edit Scope

> Root `.codex` defines the boundary between hub work and vault work.

## Root Scope

- Allowed direct root edits: `CODEX.md`, `.codex/`, `CLAUDE.md`, `.claude/`, `docs/`
- Do not edit files inside `Vaults/**` until the target vault is selected

## Vault Scope

- After entering a vault, follow that vault's `_WORKFLOW.md` and `.codex/CODEX.md`
- Do not treat root routing rules as a replacement for vault-local rules
- Keep root hub edits and vault edits logically separated in the same task

## [workspace] 모드 — AIHubVault 전용 (강제)

- **workspace 편집은 AIHubVault에서만 수행한다.** 다른 볼트의 workspace 파일은 `aimv sync`로 자동 전파된다.
- workspace 파일 수정 후 반드시 AIHubVault의 `_WORKSPACE_VERSION.md`에 버전을 기록한다.

1. 당일 최대 버전 번호 확인 → +1로 새 버전 생성 (형식: `YYYYMMDDNNNN`)
2. 변경 내용을 테이블 최상단에 추가

**버전 기록 없이 workspace 작업을 완료 보고하지 않는다.**

## 세션 종료 시 상태 갱신 (강제)

1. **`_STATUS.md` 갱신 (필수)**: 볼트 `_STATUS.md`를 직접 갱신 (Now/Next/Blocked/Decisions). `_STATUS.md` 갱신 없이 세션을 종료하지 않는다.
2. **루트 `_STATUS.md` 갱신 (필수)**: 루트 `_STATUS.md`의 해당 볼트 섹션 갱신.
3. **AGENT_STATUS 갱신 (권장)**: `.codex/AGENT_STATUS.md` — 복잡한 작업이나 맥락 전달 필요 시 갱신. 단순 작업이면 생략 가능.
