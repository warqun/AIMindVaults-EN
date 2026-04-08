# Post-Edit Review (Mandatory)

> 모든 볼트에 동일 적용.

## 규칙

- 노트 편집 완료 직후 아래 검토를 반드시 실행:
```powershell
powershell -ExecutionPolicy Bypass -File {볼트경로}\.sync\_tools\cli\post_note_edit_review.ps1 -Root {볼트경로} -Scope Contents
```
- `POST_EDIT_REVIEW_BAD=0` 확인 전에는 완료 보고 금지.
- **노트 추가/편집 작업은 콘텐츠 인덱싱까지 완료되어야 끝난다.**
  - 기본 경로: `post_note_edit_review.ps1`가 review 통과 후 `vault_index_build.ps1 -Incremental`을 자동 호출
  - 완료 조건: `POST_EDIT_INDEX_UPDATED=1`
  - `POST_EDIT_INDEX_SKIPPED=1` 또는 `POST_EDIT_INDEX_UPDATED=0`이면 아래 명령으로 수동 인덱싱 후 완료 보고:
```powershell
powershell -ExecutionPolicy Bypass -File {볼트경로}\.sync\_tools\cli\vault_index_build.ps1 -VaultRoot {볼트경로} -Incremental
```

## Obsidian CLI 우선 사용

- 조회/검색/히스토리 복구는 먼저 해당 볼트의 `.sync/_tools/cli/obsidian_ai_bridge.ps1`를 사용한다.
- 파일 직접 파싱은 CLI 결과로 부족할 때만 사용한다.
- 편집 후에는 `-Action post-review`로 검토와 인덱싱을 완료한다.
