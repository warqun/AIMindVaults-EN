---
aliases:
  - "Writing Standards"
tags:
  - Standards
  - Meta
  - AIMindVault
type: standards
updated: 2026-03-04
agent: codex
---

# WritingStandards

## 기본 원칙
- 한국어로 작성하되 코드/식별자/명령어는 원문을 유지한다.
- 한 노트에는 한 주제만 다룬다.
- 제목(H1)은 문서당 1개만 사용한다.

## 구조 원칙
- 기본 작업 문서는 Contents/ 하위에 위치한다.
- 새 폴더를 만들면 _VAULT-INDEX.md에 즉시 등록한다.
- 진행 상태 변경은 _STATUS.md에 반영한다.

## 링크/형식 규칙
- 내부 링크는 [[WikiLink]]를 사용한다.
- 표는 결정사항, 비교항목, 진행상태 정리에 우선 사용한다.
- 코드 블록은 언어 태그를 명시한다(csharp, yaml, json 등).

## AI 협업 작성 규범
- 한 턴 한 목표 원칙을 유지한다.
- 대용량 로그는 원문 전체 대신 핵심 10~30줄만 인용한다.
- 결론에는 근거 1줄 + 다음 액션 1줄을 포함한다.
- 멀티 에이전트 작업은 요약 결과 파일 기준으로 통합한다.

## Juggl 임베드 규칙
- 일반 노트는 제목(H1) 바로 아래에 Juggl 블록을 넣는다.
- 형식:
`juggl
local: 노트_제목
`
- 예외: 인덱스/상태/시스템 제어 문서(_STATUS.md, _VAULT-INDEX.md, .claude/commands/*, .claude/rules/*).

## Encoding/Bulk-Edit Safety (필수)
- 대량 수정 시 UTF-8 고정 읽기/쓰기를 사용한다.
- 기본 인코딩 의존 명령(`Set-Content`, `Add-Content` 기본값) 단독 사용 금지.
- 대량 수정 전/후 인코딩 검증을 실행한다.
- 상세 규칙: [[_Standards/Encoding_BulkEdit_Safety]]

## Post-Edit Review (강제)
- 노트 편집이 끝나면 반드시 인코딩/손상 검토를 실행한다.
- 실행 명령:
```powershell
powershell -ExecutionPolicy Bypass -File .\_tools\cli\post_note_edit_review.ps1
```
- 통과 기준: `POST_EDIT_REVIEW_BAD=0`, `POST_EDIT_REVIEW_OK=1`
- 실패 시: 추가 편집 중단 후 원인 복구 -> 재검토

## Juggl 스타일 운영 (필수)
- Juggl 스타일 변경 시 graph.css와 Juggl_StyleGuide/README.md, Juggl_StyleGuide/README_KR.md를 같은 작업에서 동시 갱신한다.
- 예시 노트는 Juggl_StyleGuide/Examples/**만 사용하고 Contents/**에는 두지 않는다.
- 상세 규범: [[_Standards/Juggl_StyleGuide_Operations]]
## Mandatory: Issue Note Governance (2026-03-04)
- Issue-note creation is a core workflow for both planning and development; treat it as mandatory.
- Never skip naming rules: `DISS_*` (design), `SISS_*` (spec), `ISSUE_INDEX*` (index only).
- Every new issue note must include required frontmatter: `type`, `tags`, `updated|created`, `agent`, `status`, `priority`.
- Every new issue note must include a `juggl` block directly under H1:
```juggl
local: <NOTE_BASENAME>
```
- On creation, update related index tables in the same task (system index first, then epic/master indexes when relevant).
- Link integrity is mandatory: all wiki links and file paths must resolve to the renamed/latest note ids.
- Completion gate is mandatory: run `_tools/cli/post_note_edit_review.ps1` and require `POST_EDIT_REVIEW_BAD=0`.
- Bulk auto-normalization for issue notes is forbidden; only file-by-file minimal edits are allowed.