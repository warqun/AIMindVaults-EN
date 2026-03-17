---
type: workspace-version
tags:
  - AIMindVault
  - Meta
updated: 2026-03-17
---

# Workspace Version Log

> 작업환경(동기화 대상) 변경 시 버전 번호를 부여하고 기록합니다.
> 형식: `YYYYMMDDNNNN` (날짜 + 당일 순번 0001~)
> 볼트 진입 시 이 파일의 최상단 버전과 AIHubVault의 최상단 버전을 비교하여 동기화 여부를 판정합니다.
> 사용자가 workspace를 수정했다면 위 형식에 맞는 버전 로그를 남겨야 다른 볼트에 동기화됩니다.

| 버전           | 변경 내용                                                                                                             |
| ------------ | ----------------------------------------------------------------------------------------------------------------- |
| 202603170012 | CLAUDE.md — 상세 규칙 참조에 AI_Rules_Index.md 추가, 죽은 참조(NoteProperties.md) 제거                                         |
| 202603170011 | _Standards/Core/AI_Rules_Index.md 신규 — .claude/rules/ 11개 규칙 전체 인덱스, 3계층 규칙 체계 문서화                                  |
| 202603170010 | _WORKFLOW.md 전면 재작성 — Claudian 에이전트 등록, 삭제된 문서 참조 제거, CLI 브리지·편집모드 섹션 현행화                                        |
| 202603170009 | CLAUDE.md 편집 모드 섹션 확장 — Contents/workspace 금지·예외 규칙, 모드 운용 규칙 3조 추가                                                |
| 202603170008 | _tools/cli_launchers/RUN_OBSIDIAN_VAMSURLIKE.bat 삭제 — 하드코딩 경로, Hub 배포 부적합                                             |
| 202603170007 | _tools/TOOLS_INDEX.md 신규 — 사용자용/AI전용 도구 목록 문서화. cli/README.md 삭제                                                |
| 202603170006 | obsidian_ai_bridge.ps1 — open 액션 추가 (Obsidian에서 노트 열기, path 또는 file name 지원)                                     |
| 202603170005 | claudian-settings.json — systemPrompt에 Claudian 자기인식 및 workspace 모드 금지 규칙 추가 (AIHubVault, BasicContentsVault 양쪽) |
| 202603170004 | .antigravity/SESSION_RULES.md — 토큰 절약 및 실행 위임 섹션 추가 (파일탐색 최소화, 핑퐁 방식, 컨텍스트 비대화 방지, 비용 사전 판단)                      |
| 202603170003 | _tools/MakeCloneVault.bat 재생성 — clone_vault.ps1 실행 런처 (부모경로+볼트명 입력 방식)                                            |
| 202603170002 | sync_workspace.ps1 — Prune 기본 활성화. Hub에서 삭제한 파일이 다른 볼트에서도 자동 삭제됨. -NoPrune으로 비활성화 가능                              |
| 202603170001 | 원본 정리 — _Standards/Core/ 참조문서 14개, _VaultReview/, _tools/ 일회성 5개, CLI_MEMORY/ 삭제. Script_Registry.md 갱신           |
| 202603150009 | Hub_Sync_Targets.md — NOT Synced 섹션 제거, 명시 대상만 동기화됨 강조                                                            |
| 202603150008 | 배포 준비 — 하드코딩 절대경로(C:\AIMindVaults) 제거, 상대경로로 전환 (_WORKFLOW, _VAULT-INDEX, VaultTypes, SESSION_RULES, 루트 에이전트 파일)  |
| 202603150007 | Hub-Sync 파이프라인이 완전히 작동                                                                                            |
| 202603150006 | sync_workspace.ps1 — Hub 자동탐색(_forge/ 마커), SELF 버그 수정, 실패 시 Windows 토스트 알림 추가                                     |
| 202603150005 | _Standards/Core/Hub_Sync_Targets.md 신규 — 동기화 대상 목록 문서화                                                            |
| 202603150004 | workspace 편집을 AIHubVault 전용으로 변경, 다른 볼트는 sync_workspace.ps1로 전파 (버전 기록 규칙 3단계 제거)                                 |
| 202603150003 | 상태 시스템 재설계 — _STATUS.md 직접 갱신 필수, AGENT_STATUS 권장으로 전환 (session-exit.md 신규, 4에이전트 전 진입점·commands·_WORKFLOW 일괄 수정) |
| 202603150002 | 4에이전트 전 진입점에 workspace 버전 기록 강제 규칙 명시 (edit-mode-separation, edit-scope, SESSION_RULES)                           |
| 202603150001 | Cursor 에이전트 등록 (SESSION_RULES.md), sync_workspace.ps1 UTF-8 BOM 수정, VerifyContent 동기화 완료                          |
| 202603140001 | _tools/ 스크립트 5개 하드코딩 경로를 자동탐지($ScriptDir)로 수정                                                                     |
| 202603110006 | _WORKFLOW.md workspace 모드에 버전 기록 강제 규칙 추가                                                                         |
| 202603110005 | open_agents.ps1 폐지 (멀티볼트 루트 IDE 1회 실행으로 대체), PLUGIN_SHELL_COMMANDS/CAPABILITIES 갱신                                |
| 202603110004 | sync_workspace.ps1 신규 생성, SESSION_RULES.md 동기화 스크립트 호출로 변경, Script_Registry 등록                                    |
| 202603110003 | _VAULT-INDEX.md 작업환경 전용으로 재구성, Contents/CONTENTS_INDEX.md 분리                                                      |
| 202603110002 | VaultTypes 문서 3종 갱신 (폴더 구조 일반화, AI 에이전트 통일)                                                                       |
| 202603110001 | Hub-Sync 프로토콜 도입, CLAUDE.md/ANTIGRAVITY.md 진입 프로토콜 갱신                                                             |
