# Codex Root Edit Scope

> Root `.codex` defines the boundary between hub work and vault work.

## Root Scope

- Allowed direct root edits: `CODEX.md`, `.codex/`, `CLAUDE.md`, `.claude/`, `docs/`
- Do not edit files inside `Vaults/**` until the target vault is selected

## Vault Scope

- After entering a vault, follow that vault's `_WORKFLOW.md` and `.codex/CODEX.md`
- Do not treat root routing rules as a replacement for vault-local rules
- Keep root hub edits and vault edits logically separated in the same task

## [workspace] Mode — AIHubVault Only (Mandatory)

- **Workspace edits must only be performed in AIHubVault.** Workspace files in other vaults are automatically propagated via `sync_workspace.ps1`.
- After modifying workspace files, you must record the version in AIHubVault's `_WORKSPACE_VERSION.md`.

1. Check the highest version number for the day → create a new version with +1 (format: `YYYYMMDDNNNN`)
2. Add the change description at the top of the table

**Do not report workspace edits as complete without recording the version.**

## Session Exit Status Update (Mandatory)

1. **Update `_STATUS.md` (Required)**: Directly update the vault's `_STATUS.md` (Now/Next/Blocked/Decisions). Do not end a session without updating `_STATUS.md`.
2. **Update root `_STATUS.md` (Required)**: Update the corresponding vault section in the root `_STATUS.md`.
3. **Update AGENT_STATUS (Recommended)**: `.codex/AGENT_STATUS.md` — Update when complex work or context handoff is needed. Can be skipped for simple tasks.
