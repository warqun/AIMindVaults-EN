# Tools Index

> List of tools under `_tools/`. Distributed to every vault via Hub-Sync.

---

## User-Facing Tools

> Tools the user runs directly. Double-click or invoke manually from PowerShell.

| File | Purpose | How to run |
|------|---------|------------|
| `MakeCloneVault.bat` | Vault-clone launcher (invokes `BasicContentsVault/.sync/clone_vault.ps1`) | Double-click |
| `setup_new_environment.ps1` | Initial setup of a new environment (diagnose, register vaults, sync, index) | `.\setup_new_environment.ps1` or `-DiagnoseOnly` |
| `cli_launchers/RUN_CLAUDE.bat` | Run Claude CLI | Double-click |
| `cli_launchers/RUN_CODEX.bat` | Run Codex CLI | Double-click |
| `cli_launchers/RUN_GEMINI.bat` | Run Gemini CLI | Double-click |

---

## AI-Agent-Only Tools

> Tools that AI agents (Claude Code, Claudian, Codex, etc.) invoke automatically during work. Users do not need to run them directly.

| File | Purpose | Invocation example |
|------|---------|--------------------|
| `cli/obsidian_ai_bridge.ps1` | Obsidian CLI wrapper — search / read / open / create / plug-in management | `-Action open -Path "Contents/note.md"` |
| `cli/post_note_edit_review.ps1` | Post-edit quality check (frontmatter, encoding, etc.) | Auto-run after edits |
| `cli/sync_workspace.ps1` | AIHubVault → other-vault workspace sync | `-NoPrune` (disable delete-sync) |
| `cli/task_router.ps1` | Recommend a working agent based on task text | `-Task "verify vault structure"` |

### `obsidian_ai_bridge.ps1` Action List

| Action | Permission | Description |
|--------|-----------|-------------|
| `vault-info` | Read | Vault info |
| `search` | Read | Text search |
| `search-context` | Read | Search with context |
| `read` | Read | Read file content |
| `open` | Read | Open a note in Obsidian |
| `append` | Write | Append content to a file |
| `create` | Write | Create a new file |
| `history` | Read | List file history |
| `history-read` | Read | Read a history version |
| `history-restore` | Write | Restore a history version |
| `diff` | Read | Compare versions |
| `plugins-list` | Read | List installed plug-ins |
| `plugin-install` | Write | Install a plug-in |
| `post-review` | Read | Run the post-edit quality check |

---

## Reference Files

| File | Description |
|------|-------------|
| `antigravity.exe.txt` | Antigravity executable-path reference |
| `open_agents.ps1` | (Deprecated) replaced by single multi-vault-root IDE invocation |
| `check_standards.ps1` | Inspect `_Standards/` structure (debug) |
| `verify_structure.ps1` | Print `_Standards/` file list (debug) |
