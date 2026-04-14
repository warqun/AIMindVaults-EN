# Edit Mode Separation (Mandatory)

> Applies uniformly to all vaults.

## Rules

- All edits must be performed in either `[Contents]` mode or `[workspace]` mode.
- `[Contents]` mode: Only `Contents/**` content may be modified. Modifying `_Standards/`, `_tools/`, `.codex/`, `.claude/`, or vault root files is prohibited.
- `[workspace]` mode: Only `_Standards/`, `_tools/`, `.codex/`, `.claude/`, and vault root files may be modified. Modifying `Contents/**` is prohibited.
- Within Contents mode: Declare a sub-mode branch of either `[Contents/Domain]` (knowledge accumulation) or `[Contents/Project]` (task management).
- An explicit declaration is required when switching modes. Mixing both modes within a single task is prohibited.

## [workspace] Mode — AIHubVault Only (Mandatory)

- **Workspace edits must be performed only in AIHubVault.** Workspace files in other vaults are automatically propagated via `node cli.js sync`.
- **Obsidian plugin installation/configuration is also a workspace edit.** Changes to `.obsidian/plugins/` must be made in AIHubVault and propagated via sync. Do not install plugins directly in individual vaults.
- After modifying workspace files, **immediately** log the version in AIHubVault's `_WORKSPACE_VERSION.md`. Version logging takes priority over testing, deployment, or any follow-up tasks.

**Workspace edit sequence (Mandatory):**
1. Modify the file
2. **Immediately** log the version in `_WORKSPACE_VERSION.md` (current day's max number + 1, format: `YYYYMMDDNNNN`)
3. Then proceed with testing, deployment, sync, and other follow-up tasks

**Do not proceed to the next step without logging the version.**

## Root-Level Edits — Version Logging (Mandatory)

- When modifying the multi-vault root (`.claude/`, `.antigravity/`, root config files, etc.), you must log the version in `_ROOT_VERSION.md`.
- Version format: `R` + 3-digit sequence number (e.g., `R001`, `R002`)
- Add the change entry to the top of the table.

**Do not report root-level edits as complete without a version log entry.**

## Reference

- Detailed rules: Each vault's `_WORKFLOW.md` § 5) Edit Mode Separation
