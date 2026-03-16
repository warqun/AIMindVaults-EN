---
type: standards
tags: [juggl, style-guide, mapping]
created: 2026-03-08
status: draft
---

# Juggl 매핑 기준 설명

```juggl
local: Juggl_Mapping_Basis
```

> 새 볼트 운영 시 Juggl 스타일을 어떻게 설계하는지 기준을 설명하는 노트.
> 실제 이 볼트의 매핑은 검토 후 아래 섹션에 작성 예정.

---

## 1. Juggl이 노드에 노출하는 데이터 속성

`graph.css`의 selector에서 사용할 수 있는 속성들:

| 속성 | 출처 | 예시 |
|------|------|------|
| `path` | 파일 경로 | `node[path *= "Domain/research/"]` |
| `name` | 파일명 (확장자 제외) | `node[name *= "INDEX"]` |
| `type` | frontmatter `type:` 필드 | `node[type = "concept"]` |
| `status` | frontmatter `status:` 필드 | `node[status *= "open"]` |
| `priority` | frontmatter `priority:` 필드 | `node[priority *= "high"]` |
| `tags` | frontmatter `tags:` 배열 (문자열화) | `node[tags *= "epic/logic"]` |

> Juggl은 frontmatter를 파싱해 각 필드를 노드 속성으로 노출함.
> `*=`는 부분 일치, `=`는 완전 일치.

---

## 2. 매핑 기준 유형

### A. 경로(path) 기반

- **장점**: 폴더 구조만으로 자동 분류. frontmatter 없어도 동작.
- **단점**: 파일 이동 시 스타일도 바뀜. 경로 설계가 스타일 설계와 연동됨.
- **적합**: 폴더 구조가 문서 유형을 명확히 반영하는 볼트.

```css
node[path *= "Domain/research/"] {
  shape: hexagon;
  background-color: #0ea5a6;
}
```

### B. frontmatter type 기반

- **장점**: 파일 위치 무관. 노트 유형이 명시적.
- **단점**: 모든 노트에 `type:` frontmatter가 있어야 함.
- **적합**: 노트 유형이 다양하고 위치와 무관하게 분류하고 싶을 때.

```css
node[type = "research"] {
  shape: hexagon;
}
node[type = "guide"] {
  shape: round-rectangle;
}
```

### C. 혼합 (경로 + frontmatter)

- **장점**: 경로로 큰 분류, frontmatter로 세부 분류.
- **적합**: 대부분의 실용 볼트.

---

## 3. 스타일 요소 목록

노드에 적용 가능한 CSS 속성:

| 요소 | 속성명 | 주요 옵션 |
|------|--------|-----------|
| 모양 | `shape` | `round-rectangle`, `rectangle`, `hexagon`, `diamond`, `star`, `ellipse` |
| 배경색 | `background-color` | hex 색상 |
| 테두리색 | `border-color` | hex 색상 |
| 테두리 굵기 | `border-width` | px |
| 글자색 | `color` | hex 색상 |
| 투명도 | `opacity` | 0.0 ~ 1.0 |

---

## 4. 새 볼트 매핑 설계 절차

새 볼트에서 Juggl 스타일을 설정할 때의 순서:

1. **볼트의 문서 유형 목록 확정** — 이 볼트에서 어떤 종류의 노트가 있는가
2. **분류 기준 선택** — 경로 기반 / type 기반 / 혼합 중 택일
3. **유형별 모양·색 할당** — 아래 매핑 테이블 작성
4. **graph.css 작성** — 위 결정에 따라 selector 작성
5. **Examples 폴더 구성** — 각 유형의 예시 노트 배치해 시각 확인
6. **README_KR.md 갱신** — 결정된 매핑 문서화

---

## 5. 이 볼트(AIMindVault)의 매핑 계획

> ⚠️ 미작성 — 검토 후 작성 예정

### 문서 유형 목록

| 유형 | 설명 | 주요 경로 |
|------|------|-----------|
| (미정) | | |

### 매핑 결정

| 유형 | 기준 | 모양 | 색상 |
|------|------|------|------|
| (미정) | | | |

### 비고

- (검토 결과 작성 예정)
