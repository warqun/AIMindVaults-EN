# Edit Mode Separation (Mandatory)

> Applies to all vaults.

## Rules

- Every edit happens in one of two modes: `[Contents]` or `[workspace]`.
- `[Contents]` mode: may modify only `Contents/**`. Cannot touch `_Standards/`, `_tools/`, `.codex/`, `.claude/`, or vault-root files.
- `[workspace]` mode: may modify only `_Standards/`, `_tools/`, `.codex/`, `.claude/`, and vault-root files. Cannot touch `Contents/**`.
- Inside Contents mode, further declare `[Contents/Domain]` (knowledge accumulation) or `[Contents/Project]` (task management).
- Mode transitions must be explicitly declared. Never mix both modes in a single task.

## [workspace] mode — AIHubVault Only (Mandatory)

- **All workspace edits happen in AIHubVault.** Other vaults receive them via `node cli.js sync`.
- **Obsidian plugin install/config is also a workspace edit.** Change `.obsidian/plugins/` in AIHubVault → propagate via sync. Do not install plugins directly in individual vaults.
- When you modify a workspace file, **immediately** record a version entry in AIHubVault's `_WORKSPACE_VERSION.md`. The version entry comes before testing, deployment, or any downstream work.

**Workspace edit order (mandatory):**
1. Modify the file
2. **Immediately** record a version in `_WORKSPACE_VERSION.md` (same-day max + 1, format `YYYYMMDDNNNN`)
3. Then proceed with test, deployment, sync, etc.

**Do not move to the next step without the version entry.**

## Root-Level Edits — Version Recording (Mandatory)

- When you change any multi-vault root file (`.claude/`, `.antigravity/`, root config files, etc.), record a version entry in `_ROOT_VERSION.md`.
- Version format: `R` + 3-digit sequence (e.g., `R001`, `R002`).
- Add the new entry at the top of the table.

**Do not report a root-level edit complete without the version entry.**

## Reference

- Details: each vault's `_WORKFLOW.md` § 5) Edit Mode Separation.
