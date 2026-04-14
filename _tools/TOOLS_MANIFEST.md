# Tools Manifest

> Only files in this list are managed as deployment targets during distribution sync.
> Folder structure is not changed; this file distinguishes core/custom.

## Classification Criteria

- **core**: Included in distribution. Essential tools for basic vault functionality.
- **custom**: Not included in distribution. Creator-specific tools for personal environment, debug, indexer, etc.
- New tools are placed in custom first. Promote to core after verification if needed.
- When promoting to core, register in this MANIFEST + record in distribution change log.

## core — Distribution Tools (Sync Target)

| File | Purpose |
|------|------|
| clone_vault.ps1 | Vault mirror clone |
| MakeCloneVault.bat | Vault clone launcher |
| cli/obsidian_ai_bridge.ps1 | Obsidian CLI wrapper |
| cli/post_note_edit_review.ps1 | Post-edit quality verification |
| cli/sync_workspace.ps1 | Hub -> vault workspace sync |
| cli/pre_sync.ps1 | Pre-sync script update |
| TOOLS_INDEX.md | Tools listing document |
| TOOLS_MANIFEST.md | This file (distribution classification criteria) |

## custom — Personal Tools (Not Synced)

| File | Purpose |
|------|------|
| cli/task_router.ps1 | Task-based agent recommendation |
| cli/open_vault.ps1 | Open Obsidian vault |
| cli_launchers/RUN_CLAUDE.bat | Launch Claude CLI |
| cli_launchers/RUN_CODEX.bat | Launch Codex CLI |
| cli_launchers/RUN_GEMINI.bat | Launch Gemini CLI |
| antigravity.exe.txt | Antigravity executable path reference |
| open_agents.ps1 | (Deprecated) Multi-vault root IDE launch |
| check_standards.ps1 | _Standards structure check (debug) |
| verify_structure.ps1 | _Standards file listing (debug) |
| cli/vault_index_build.ps1 | Vault index build |
| cli/vault_index_search.ps1 | Vault index search |
| data/vault_index.json | Index data |
