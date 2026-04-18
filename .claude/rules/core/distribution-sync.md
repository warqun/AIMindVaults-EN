# Distribution Sync (Mandatory)

> Applies to all vaults.

## Rules

- When modifying shared rules (`.claude/rules/`), shared skills (`.claude/commands/`), or workspace files (`.sync/` under `_Standards/`, `_tools/`), verify whether the change is a distribution target.
- After a distribution-targeted change, record it in the root `_ROOT_VERSION.md` log.
- The actual distribution sync is performed by the maintainer. Agents do not access distribution paths directly.
- Personal notes under `Contents/`, user-added vaults, and `.obsidian/` settings are NOT distribution targets.
