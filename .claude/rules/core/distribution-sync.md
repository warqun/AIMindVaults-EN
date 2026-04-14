# Distribution Sync (Mandatory)

> Applies to all vaults.

## Rules

- When modifying shared rules (`.claude/rules/`), shared skills (`.claude/commands/`), or workspace files (`.sync/` under `_Standards/`, `_tools/`), verify whether the change is a distribution target.
- After a distribution-targeted change, record it in the change log at the bottom of `AIHubVault/Contents/Project/plan/AIMindVaults_plan/20260317_distribution_sync_rule.md`.
- The actual distribution sync runs through the `sync-distribution` workflow. Agents do not access distribution paths directly.
- Personal notes under `Contents/`, additional vaults (Unity, VamSurLike, etc.), and `.obsidian/` settings are NOT distribution targets.
