---
type: status
updated: 2026-03-21
---
# STATUS — 현재 진행 현황

> **이 문서가 이 볼트의 유일한 상태 문서다.**
> 모든 에이전트는 세션 종료 시 이 파일을 직접 갱신한다.
> AGENT_STATUS는 에이전트 자체 판단으로 선택적 기록.

## 이 볼트의 역할

> **AI 작업환경 설계·개선·배포 허브**
> - `_Standards`, `_tools`, `.claude`, `.forge` 등 AI 운영 구조 관리
> - 게임 개발/기획 작업은 이 볼트에서 수행하지 않음

## Now (현재 집중)

- **Workspace 3계층 구조 (Core/Custom/Vault-local) 구현** — sync_workspace.ps1 배치 재구성, 플러그인 Core 4개 분리 완료
- **Linter Core 활성화** — frontmatter 자동 정렬, updated 자동 갱신, Core data.json 강제 동기화
- **멀티볼트 개인화 + 볼트 개별화 규칙 신설** — 에이전트 진입점 배포 제외 명시

## Next (다음 작업)

- Custom override 메커니즘 구현 (볼트별 플러그인/가이드 제외)
- Core 영역 Obsidian UI 숨김 처리
- **배포 레포 동기화 + git push** — 변경분 반영
- 배포 버전 점검 (남동생 데스크탑 설치용)

## Blocked (막힘/결정 필요)

- 없음

## Decisions (결정 사항)

- (2026-03-23) **Workspace 3계층**: Core(강제 동기화) / Custom(동기화되지만 prune 가능) / Vault-local(미동기화)
- (2026-03-23) **Core 플러그인 4개 확정**: local-rest-api, dataview, templater, linter
- (2026-03-23) **Juggl_StyleGuide Custom 격하**: Core → Custom Batch로 이동
- (2026-03-23) **_VAULT-INDEX.md 동기화 제거**: Vault-local (볼트마다 구조 다름)
- (2026-03-23) **Linter data.json만 강제 동기화**: local-rest-api는 API키/인증서 포함으로 보존
- (2026-03-23) **에이전트 진입점 파일 배포 제외**: CLAUDE.md, CODEX.md, AGENT_STATUS.md
- (2026-03-21) **볼트 콘텐츠 인덱서 도입**: JSON 기반 메타데이터 인덱스 + 가중치 랭킹 검색
- (2026-03-21) **에이전트 체제 변경**: 4에이전트 → 2에이전트 (Claude Code + Codex)
- (2026-03-21) **트램펄린 패턴 도입**: pre_sync.ps1 자기 업데이트 시 새 프로세스로 재실행. chicken-and-egg 구조적 해결
- (2026-03-21) **버전 로그 분리**: _WORKSPACE_VERSION.md 경량화 (1행) + _WORKSPACE_CHANGELOG.md (Hub 전용)
- (2026-03-21) **Obsidian 자동 리로드**: sync 후 새 플러그인 감지 시 Local REST API로 app:reload 트리거
- (2026-03-21) **플러그인 동기화 방식 확정**: community-plugins.json 텍스트 기반 직접 머지 (Advanced URI .bat 방식 폐기)
- (2026-03-20) **네임스페이스 분리**: .claude/rules/ 및 commands/를 core/custom 분리. 신규는 custom 우선, 검증 후 core 격상
- (2026-03-20) **플러그인 동기화**: Batch 0 추가, community-plugins.json 직접 편집 대신 Advanced URI enable-plugin 방식 (이후 2026-03-21에 폐기됨)
- (2026-03-20) **파일명 규칙**: URI 예약문자(#%&?+) 파일명 사용 금지, 대체 표기(CSharp, CPP, QnA)
- (2026-03-20) **볼트 라우팅 규칙 신설**: BasicContentsVault 직접 작업 금지, 미등록 볼트 자동 등록
- (2026-03-20) **workspace 편집 순서 강화**: 수정 → 즉시 버전 기록 → 그 다음 배포/테스트
- (2026-03-15) **상태 시스템 재설계**: AGENT_STATUS 병합 방식 폐지 → `_STATUS.md` 직접 갱신 필수, AGENT_STATUS는 권장으로 격하
- (2026-03-15) **4에이전트 체제 확립**: Claude Code / Codex / Antigravity / Cursor
- (2026-03-14) **멀티볼트 환경 전환 완료**: 디렉토리 재구성 + 루트 허브 생성
- (2026-03-10) **루트 Codex 허브 도입**: 루트 `CODEX.md` + `.codex/`
- (2026-03-09) **에이전트 진입점 분리**: CLAUDE.md / CODEX.md / SESSION_RULES.md
- (2026-03-09) **스크립트 중복 방지 체계**: Script_Registry.md + Script_Creation_Rule.md
- (2026-03-08) **볼트 범위 확정**: AI 작업환경 허브 (게임 개발/기획 배제)
