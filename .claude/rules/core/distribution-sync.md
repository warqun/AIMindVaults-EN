# Distribution Sync (Mandatory)

> Applied uniformly to every vault.

## Rules

- When changing shared rules (`.claude/rules/`), shared skills (`.claude/commands/`), or workspace files (`_Standards/` and `_tools/` under `.sync/`), check whether the change must be reflected in the distribution.
- After completing a deployment-relevant change, record it in the change log at the bottom of the distribution-sync rules note (under the AIHubVault project plan).
- Antigravity performs the actual distribution sync via the `sync-distribution` workflow. Claude Code does not access the distribution paths directly.
- Personal notes under `Contents/`, additional vaults (Unity, side projects, etc.), and `.obsidian/` settings are not deployment targets.
