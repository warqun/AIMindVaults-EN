# Distribution Sync (Mandatory)

> Applies uniformly to all vaults.

## Rules

- When modifying shared rules (`.claude/rules/`), shared skills (`.claude/commands/`), or workspace files (`_Standards/`, `_tools/` inside `.sync/`), verify whether the change is a distribution sync target.
- After completing a distribution-target change, log it in the changelog at the bottom of `AIHubVault/Contents/Project/plan/AIMindVaults_plan/20260317_Distribution_Sync_Rules.md`.
- Actual distribution sync is performed by Antigravity via the `sync-distribution` workflow. Claude Code does not directly access the distribution path.
- Personal notes inside `Contents/`, additional vaults (Unity, VamSurLike, etc.), and `.obsidian/` settings are not distribution targets.
