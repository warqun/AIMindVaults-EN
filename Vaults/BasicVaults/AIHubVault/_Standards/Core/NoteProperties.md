---
aliases:
  - "Note Properties"
tags:
  - Standards
  - Meta
  - AIMindVault
type: standards
updated: 2026-03-08
agent: claude
---

# NoteProperties

## 필수 Frontmatter
- type
- tags
- updated 또는 created (형식: YYYY-MM-DD)

## 권장 Frontmatter
- agent (claude|codex|gemini|antigravity|human)
- status (필요 시)
- topic (이슈/리포트 성격 문서에서 권장)

## 문서 타입 예시
- standards
- template
- design
- spec
- issue-design
- issue-spec
- temp-draft
- report

## 규칙
- 모든 새 노트는 YAML Frontmatter(---)로 시작한다.
- 날짜는 YYYY-MM-DD 형식만 허용한다.
- 새 폴더 생성 시 _VAULT-INDEX.md에 등록한다.
