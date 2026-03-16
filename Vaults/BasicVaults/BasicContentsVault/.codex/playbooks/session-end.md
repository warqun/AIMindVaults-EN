# Playbook: 세션 종료

> 사용 시점: 작업 완료 후 Codex 세션 종료 전
> 대응 Claude 스킬: `/vault-update`

---

## Step 1 — post-review (문서 수정이 있었던 경우)

```powershell
powershell -ExecutionPolicy Bypass -File .\_tools\cli\post_note_edit_review.ps1
```

`POST_EDIT_REVIEW_BAD=0` 확인. 실패 시 복구 후 다시 확인.

---

## Step 2 — AGENT_STATUS.md 갱신

`.codex/AGENT_STATUS.md` 업데이트:

```markdown
## 이번 세션 요약
- 작업 범위: [한 줄]
- 완료: [항목 목록]
- 보류/리스크: [있을 경우]

## 이번 세션에서 한 일 (Done)
- [파일별 변경 내용]

## 다음에 할 일 (Next)
- [다음 세션 진입점]

## 막힌 것 / 질문 (Blocked)
- [없음 또는 항목]
```

---

## Step 3 — _STATUS.md 병합 판단

아래 중 하나에 해당하면 _STATUS.md 업데이트:
- [ ] 다음 작업을 Claude가 이어서 할 예정
- [ ] 파일 수정 작업이 미완료 상태로 종료
- [ ] 불일치 감지 (Claude와 다른 이해)

해당 없으면 병합 생략 (AGENT_STATUS만 갱신).

---

## Step 4 — 체크리스트 출력

```
[ ] post-review BAD_COUNT=0 확인
[ ] AGENT_STATUS.md 갱신 완료
[ ] _STATUS.md 병합 여부 판단
[ ] 인덱스/링크 무결성 확인
[ ] 끊어진 위키링크 없음
```

---

## 빠른 사용

세션 종료 시 이 파일 참조하여 순서대로 실행.
