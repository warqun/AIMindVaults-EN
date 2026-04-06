---
type: workspace-version
tags:
  - AIMindVault
  - TileMapToolKit
  - Meta
updated: 2026-04-01
---

# Workspace Version

> 동기화 판정용 버전 번호. 형식: `YYYYMMDDNNNN` (날짜 + 당일 순번).
> 이 파일의 최상단 버전과 AIHubVault의 최상단 버전을 비교하여 동기화 여부를 판정합니다.
> 개발 히스토리: AIHubVault `_WORKSPACE_CHANGELOG.md` 참조 (Hub 전용, 배포 비대상).

| 버전           | 변경 내용 |
| ------------ | ----- |
| 202604060001 | _sync/ 폴더구조 재편 — sync_workspace.ps1 폴더 미러링 리팩토링, pre_sync.ps1 경로 갱신, 배치 배열 제거, .obsidian/app.json userIgnoreFilters 추가 |
| 202604050001 | post_note_edit_review.ps1에 인덱서 증분 빌드 자동 호출 추가 (기능 A) |
| 202604010001 | TileMapToolKit 볼트 초기 개별화 — 진입점/상태/인덱스/태그 규칙 정렬, `Contents/` 구조 초기화 |
| 202603230004 | Core 플러그인 data.json 선택적 강제 — Linter만 강제, local-rest-api는 민감 데이터(API키/인증서) 포함으로 보존 |
| 202603230003 | sync_workspace.ps1 플러그인 Core/Custom 분리 — Core 4개(local-rest-api, dataview, templater, linter) 강제 동기화, 나머지 Custom |
| 202603230002 | sync_workspace.ps1 배치 Core/Custom 분리 — Juggl_StyleGuide를 Custom으로 이동, _VAULT-INDEX.md 동기화 제거 |
| 202603230001 | Linter 플러그인 활성화 — frontmatter 키 정렬, updated 자동 갱신, 저장 시 자동 lint |
| 202603210015 | sync_workspace.ps1 Invoke-ObsidianReload 쿨다운 추가 — 리로드 무한 루프 방지 (60초) |
| 202603210014 | vault_index_build.ps1, vault_index_search.ps1 신규 — 볼트 콘텐츠 인덱서 + 검색 엔진 |
| 202603210013 | pre_sync 트램펄린 패턴, Obsidian 자동 리로드, community-plugins.json 머지 |