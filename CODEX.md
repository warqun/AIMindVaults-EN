# AIMindVaults — Codex Multi-Vault Hub

> This is the root Codex entry for the AIMindVaults multi-vault hub.
> Use it to route work to the correct vault or stay at root for shared agent configuration work.
> Detailed Codex rules live in `.codex/`.

## Read First

1. `.codex/CODEX.md`
2. `.codex/rules/vault-routing.md`
3. `.codex/rules/edit-scope.md`
4. `.codex/rules/status-sync.md`
5. `.codex/rules/encoding-safety.md`
6. `.codex/AGENT_STATUS.md`

## Vault Entry Protocol

1. Identify the target vault
2. Read `_STATUS.md` (루트) — 전체 볼트 현황 + 다른 볼트 작업 확인
3. Read `{vault}/.codex/CODEX.md`
4. Read `{vault}/_STATUS.md`
4. Read any additional local rules needed for the task

## Vault Registry

| Vault ID | Path | Role | Status |
|---------|------|------|------|
| AIHubVault | `Vaults/BasicVaults/AIHubVault/` | AI 작업환경 설계·개선·배포 허브 | active |
| BasicContentsVault | `Vaults/BasicVaults/BasicContentsVault/` | 범용 콘텐츠 저장소 | active |

## Root Work Scope

- `CODEX.md`
- `.codex/`
- `CLAUDE.md`
- `.claude/`
- `.cursor/`
- `docs/`

Vault-internal files are not root-scope edits. Enter the vault first.
