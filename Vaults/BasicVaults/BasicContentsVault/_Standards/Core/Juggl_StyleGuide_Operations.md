---
aliases:
  - "Juggl Style Operations"
  - "Juggl 스타일 운영 규범"
tags:
  - Standards
  - Juggl
  - AIMindVault
type: standards
updated: 2026-03-04
agent: codex
---

# Juggl 스타일 운영 규범

## 목적
- Juggl 스타일 변경 시 문서/예시/설정이 서로 어긋나지 않도록 운영 절차를 고정한다.
- 어떤 AI가 작업하더라도 동일한 품질로 유지되게 한다.

## 단일 기준 원본 (Single Source of Truth)
- 스타일 규칙 파일: `.obsidian/plugins/juggl/graph.css`
- 설명 문서(영문): `Juggl_StyleGuide/README.md`
- 설명 문서(한글): `Juggl_StyleGuide/README_KR.md`
- 예시 인덱스: `Juggl_StyleGuide/EXAMPLE_INDEX.md`
- 예시 노트 위치: `Juggl_StyleGuide/Examples/**`

## 강제 규칙
1. 스타일 추가/변경/삭제 시, 같은 작업에서 아래 3개를 반드시 동시 업데이트한다.
- `graph.css`
- `Juggl_StyleGuide/README.md`
- `Juggl_StyleGuide/README_KR.md`

2. 예시 노트는 실제 문서 폴더(`Contents/**`)에 두지 않는다.
- 반드시 `Juggl_StyleGuide/Examples/**`만 사용한다.
- 파일명은 `EXAMPLE_` 접두사로 시작한다.

3. 분류 규칙은 경로 기반이면 README 양쪽(영/한)에 경로를 명시한다.

4. 자기 자신 노드 강조 규칙을 바꾸면 README 양쪽의 "Self Node Highlight" 섹션도 같이 갱신한다.

## 변경 절차 (필수)
1. Dry-run: 변경 대상 목록만 먼저 확인
2. Sample: 예시 노트 1~2개에서 Juggl 렌더 확인
3. Full apply: 전체 반영
4. Verify: 편집 후 검토 스크립트 실행

## 완료 조건 (Done)
- `graph.css`와 README(영/한) 내용이 서로 일치한다.
- 예시 노트가 `Juggl_StyleGuide/Examples/**`에만 존재한다.
- `post_note_edit_review.ps1` 결과가 `POST_EDIT_REVIEW_BAD=0`이다.

## 금지
- 스타일 변경 후 README 미갱신 상태로 종료 금지
- 예시 노트를 `Contents/**`에 남겨 혼선을 만드는 행위 금지