---
description: Sync changes from the source multi-vault to the distribution multi-vault
---

# Distribution Sync Workflow (sync-distribution)

**Purpose**: Sync deployment-targeted file changes from the source `C:\AIMindVaults` to the distribution `C:\SellingVault\Korean\AIMindVaults`.

## Prerequisites

- Check the change log: Review "unreflected" items at the bottom of `AIHubVault/Contents/Project/plan/AIMindVaults_plan/20260317_Distribution_Sync_Rules.md`.

## Step-by-Step Execution

### Step 1: Read the Change Log
- Collect all items with `unreflected` status from the change log table in the above planning document.

### Step 2: Verify Reflection Criteria
- Validate whether each change item falls under the following deployment targets:
  - `.claude/rules/core/*` (deployment rules) — based on `MANIFEST.md` list
  - `.claude/commands/core/*` (deployment skills) — based on `MANIFEST.md` list
  - `.claude/rules/MANIFEST.md`, `.claude/commands/MANIFEST.md` (manifests themselves)
  - `.antigravity/workflows/*` (workflows)
  - `_Standards/`, `_tools/`, `Juggl_StyleGuide/` (workspace)
  - Root/vault configuration files (`CLAUDE.md`, `_WORKFLOW.md`, etc.)
- **Excluded from sync**:
  - `.claude/rules/custom/*`, `.claude/commands/custom/*` (user-only — never touch)
  - `Contents/` personal notes, additional vaults, `.obsidian/` settings
  - Distribution management files (`distribution_sync.md`, `sync-distribution.md`)

### Step 3: Execute File Sync
- Copy/overwrite the corresponding files from the source path to the same location in the distribution path.
- Do not delete files that exist only in the distribution and not in the source (protect distribution-only content).
- Create new files as needed, overwrite modified files.

### Step 3-1: Verify Deleted Files Against Source (Mandatory)
- Before committing deleted files (`D` status) in the distribution to git, **always check whether the file exists in the source**.
- If it exists in the source → it was not deleted but missing from distribution, so **copy from source to restore**.
- If it does not exist in the source either → it is a genuine deletion target, so reflect the deletion in git.
- **Never batch-commit deleted files without verifying against the source.**

### Step 4: Vault Registry Caution
- The vault registry in the root `CLAUDE.md` differs between source and distribution (distribution has AIHubVault + BasicContentsVault only).
- Do not sync the vault registry section.

### Step 5: Update the Change Log
- Update the status of synced items from `unreflected` to `reflected (YYYY-MM-DD)`.
- Report results to the user.
