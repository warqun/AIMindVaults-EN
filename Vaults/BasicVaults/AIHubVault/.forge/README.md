---
type: meta
tags: [forge, deploy]
agent: claude
updated: 2026-03-08
---

# .forge — 외부 에이전트 결과물 스테이징

이 볼트(AIMindVault)의 작업환경 구성을 다른 볼트로 배포하기 위한 공간.

## 구조

| 폴더 | 용도 |
|------|------|
| `inbox/` | 외부 에이전트(Grok·Codex 등) 결과물 수신 대기 |
| `staging/` | 배포 전 검토·준비 완료된 스크립트·설정 |
| `tasks/` | 배포 관련 작업 지시 초안 |

## 워크플로우

```
외부 에이전트 결과물
    → inbox/ (수신)
    → 검토
    → staging/ (배포 준비 완료)
    → 대상 볼트에 배포
```

## 관련 문서

- [[_tools/GitMirrorSync_DecisionPoints]] — 볼트 복제/동기화 결정 사항
- [[_tools/clone_vault.ps1]] — 볼트 복제 스크립트
