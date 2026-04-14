---
name: sync-distribution
description: Procedure for syncing source multi-vault changes to the distribution multi-vault
---

# Distribution Sync

**Purpose**: Sync deployment-targeted file changes from the source `C:\AIMindVaults` to the distribution `C:\SellingVault\Korean\AIMindVaults`.

## Prerequisites

- Check the change log: Review "unreflected" items at the bottom of `AIHubVault/Contents/Project/plan/AIMindVaults_plan/20260317_Distribution_Sync_Rules.md`.

## Step 1: Read the Change Log

Collect all items with `unreflected` status from the change log table in the above planning document.

## Step 2: Verify Reflection Criteria

Validate whether each change item falls under the following deployment targets:
- `.claude/rules/core/*` — based on `MANIFEST.md` list
- `.claude/commands/core/*` — based on `MANIFEST.md` list
- `.claude/rules/MANIFEST.md`, `.claude/commands/MANIFEST.md`
- `.codex/skills/*` (skills)
- `.codex/rules/*` (Codex-specific rules)
- `_Standards/`, `_tools/`, `Juggl_StyleGuide/` (workspace)
- Root/vault configuration files (`CLAUDE.md`, `AGENTS.md`, `_WORKFLOW.md`, etc.)

**Excluded from sync**:
- `.claude/rules/custom/*`, `.claude/commands/custom/*` (user-only)
- `Contents/` personal notes, additional vaults, `.obsidian/` settings

## Step 3: Execute File Sync

- Copy/overwrite from source to the same location in the distribution.
- Do not delete files that exist only in the distribution and not in the source.

## Step 3-1: Verify Deleted Files Against Source (Mandatory)

- Before reflecting deleted files in git, check whether the file exists in the source.
- If it exists in the source -> copy to restore.
- If it does not exist in the source either -> reflect the deletion.

## Step 4: Vault Registry Caution

- The vault registry in root `CLAUDE.md`/`AGENTS.md` differs between source and distribution.
- Do not sync the vault registry section.

## Step 5: Update the Change Log

- Update the status of synced items from `unreflected` to `reflected (YYYY-MM-DD)`.
- Report results to the user.
