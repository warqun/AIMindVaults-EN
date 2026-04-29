# Tools Manifest

> When syncing the distribution, only the files in this list are managed as deployment targets.
> The folder structure is unchanged; this file distinguishes core / custom.

## Classification

- **core**: included in the distribution. Tools required for the vault's basic functionality.
- **custom**: not deployed. Personal env, debug, indexer, etc. — creator-only.
- New tools go to custom first. Promote to core only after validation.
- When promoting to core, register here in MANIFEST and record it in the deploy change log.

## core — Distribution Tools (sync target)

| File | Purpose |
|------|---------|
| MakeCloneVault.bat | Vault-clone launcher (invokes `BasicContentsVault/.sync/clone_vault.ps1`) |
| setup_new_environment.ps1 | Initial setup of a new environment (vault registration, sync, index) |
| cli/obsidian_ai_bridge.ps1 | Obsidian CLI wrapper |
| cli/post_note_edit_review.ps1 | Post-edit quality check |
| cli/sync_workspace.ps1 | Hub → vault workspace sync |
| cli/pre_sync.ps1 | Update scripts before syncing |
| TOOLS_INDEX.md | Tool-list document |
| TOOLS_MANIFEST.md | This file (deployment classification) |

## custom — Personal Tools (not a sync target)

| File | Purpose |
|------|---------|
| cli/task_router.ps1 | Task-based agent recommendation |
| cli/open_vault.ps1 | Open an Obsidian vault |
| cli_launchers/RUN_CLAUDE.bat | Run Claude CLI |
| cli_launchers/RUN_CODEX.bat | Run Codex CLI |
| cli_launchers/RUN_GEMINI.bat | Run Gemini CLI |
| antigravity.exe.txt | Antigravity-executable path reference |
| open_agents.ps1 | (Deprecated) multi-vault-root IDE launcher |
| check_standards.ps1 | Inspect `_Standards/` structure (debug) |
| verify_structure.ps1 | Print `_Standards/` file list (debug) |
| cli/vault_index_build.ps1 | Vault-index build |
| cli/vault_index_search.ps1 | Vault-index search |
| data/vault_index.json | Index data |
