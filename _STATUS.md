---
type: status-hub
updated: 2026-04-04
---

# STATUS HUB — 멀티볼트 레지스트리

> 전체 볼트 목록과 최근 AI 작업 기록.
> 상세 작업 내역은 각 볼트의 `_STATUS.md` 참조.
> 세션 시작 시 최근 작업 날짜 순으로 확인하여 진행 상황 파악.

## 루트 환경

최근 루트 레벨 변경: `_ROOT_VERSION.md` 참조

## 볼트 레지스트리

### BasicVaults

| 볼트 | 타입 | 콘텐츠 | 작업 에이전트 |
|------|------|--------|-------------|
| AIHubVault | Hub | AI 작업환경 설계·개선·배포 원본 | claude / 2026-03-23 |

> BasicContentsVault는 AIHubVault의 배포용 복제 볼트. `/create-vault` 스킬 참조.

### Domains

| 볼트          | 타입     | 콘텐츠                     | 작업 에이전트             |
| ----------- | ------ | ----------------------- | ------------------- |
| Unity       | Domain | Unity 엔진 도메인 지식         | claude / 2026-04-02 |
| GameDesign  | Domain | 게임 기획·디자인 도메인 지식        | -                   |
| CapCut      | Domain | CapCut 영상편집 도메인 지식      | -                   |
| Notion      | Domain | Notion 워크스페이스 운영 도메인 지식 | claude / 2026-03-18 |
| Git         | Domain | Git 버전 관리 도메인 지식        | -                   |
| Blender     | Domain | Blender 3D 모델링 도메인 지식   | -                   |
| AI_Gen4Game | Domain | AI 활용 게임 에셋 제작          | -                   |
| GameArt     | Domain | 게임 아트/비주얼 프로덕션 기법       | claude / 2026-04-04 |
| CICD        | Domain | CI/CD 및 배포 동기화 도메인 지식   | claude / 2026-03-21 |
| Search      | Domain | 검색 엔진, 인덱싱, 텍스트 매칭 도메인 지식 | claude / 2026-03-21 |
| AI          | Domain | AI 활용 기술 도메인 지식 (에이전트, 프롬프트, 도구 가이드) | claude / 2026-03-21 |
| AppFlowy    | Domain | AppFlowy 셀프호스트 설치·운영·이관 도메인 지식 | claude / 2026-03-23 |

### Labs

| 볼트 | 타입 | 콘텐츠 | 작업 에이전트 |
|------|------|--------|-------------|
| ObsidianDev | Lab | Obsidian 플러그인 개발 (지식 + 개발) | claude / 2026-03-20 |

### Projects_GameTool (게임 개발 도구)

| 볼트 | 타입 | 콘텐츠 | 작업 에이전트 |
|------|------|--------|-------------|
| CombatToolKit | Project | 게임 전투 시스템 개발 툴킷 — CombatTestBed Phase A~B 완료, 전투 풀 파이프라인 작동 확인, Phase C~E 잔여 | claude / 2026-04-04 |
| TileMapToolKit | Project | 게임 타일맵 시스템 개발 툴킷 | codex / 2026-04-01 |

### Projects_Game (게임 개발 프로젝트)

| 볼트 | 타입 | 콘텐츠 | 작업 에이전트 |
|------|------|--------|-------------|
| JissouGame | Project | Unity 기반 게임 개발 프로젝트 — 하루루프 이벤트 4분류, 잠자리 경쟁(선객/노림), 뒤지기 상세 UX(시야제한/운반3종), 도구무기 분류(봉손 제약), 월드구조 고정가변 설계 완료. 다음: 공원 상세 맵, 서식지별 이벤트 테이블 | claude / 2026-04-04 |

### Projects_Infra (인프라)

| 볼트 | 타입 | 콘텐츠 | 작업 에이전트 |
|------|------|--------|-------------|
| Project_AIMindVaults | Project | AIMindVaults 멀티볼트 시스템 프로젝트 | claude / 2026-03-23 |

### Personal

| 볼트 | 타입 | 콘텐츠 | 작업 에이전트 |
|------|------|--------|-------------|
| Diary | Personal | 개인 다이어리, 회고, 성장 로그 | claude / 2026-03-21 |

### References

| 볼트 | 타입 | 콘텐츠 | 비고 |
|------|------|--------|------|
| Unity_Documentation | Reference | Unity 6.3 공식 매뉴얼·스크립트 API | readonly |
