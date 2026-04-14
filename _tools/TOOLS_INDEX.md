# Tools Index

> Tool listing under `_tools/`. Distributed to all vaults via Hub-Sync.

---

## User Tools

> Tools that the user runs directly. Double-click or invoke manually from PowerShell.

| File                                          | Purpose                           | How to Run                                |
| ------------------------------------------- | ---------------------------- | ------------------------------------ |
| `MakeCloneVault.bat`                        | Vault clone launcher (enter parent path + vault name)     | Double-click                                 |
| `clone_vault.ps1`                           | Obsidian vault mirror clone (robocopy) | `.\clone_vault.ps1 -TargetPath <path>` |
| `cli_launchers/RUN_CLAUDE.bat`              | Launch Claude CLI                | Double-click                                 |
| `cli_launchers/RUN_CODEX.bat`               | Launch Codex CLI                 | Double-click                                 |
| `cli_launchers/RUN_GEMINI.bat`              | Launch Gemini CLI                | Double-click                                 |

---

## AI Agent Tools

> Tools that AI agents (Claude Code, Claudian, Codex, etc.) call automatically during work. Users do not need to run these directly.

| File | Purpose | Usage Example |
|------|------|----------|
| `cli/obsidian_ai_bridge.ps1` | Obsidian CLI wrapper — search, read, open, create, plugin management | `-Action open -Path "Contents/note.md"` |
| `cli/post_note_edit_review.ps1` | Post-edit quality verification (frontmatter, encoding, etc.) | Runs automatically after editing |
| `cli/sync_workspace.ps1` | AIHubVault -> other vault workspace sync | `-NoPrune` (disable deletion sync) |
| `cli/task_router.ps1` | Task text-based agent recommendation | `-Task "vault structure verification"` |

### obsidian_ai_bridge.ps1 Action List

| Action | Permission | Description |
|------|------|------|
| `vault-info` | Read | Query vault information |
| `search` | Read | Text search |
| `search-context` | Read | Search with context |
| `read` | Read | Read file content |
| `open` | Read | Open note in Obsidian |
| `append` | Write | Append content to file |
| `create` | Write | Create new file |
| `history` | Read | List file history |
| `history-read` | Read | Read history version |
| `history-restore` | Write | Restore history version |
| `diff` | Read | Compare differences between versions |
| `plugins-list` | Read | List installed plugins |
| `plugin-install` | Write | Install plugin |
| `post-review` | Read | Run post-edit quality verification |

---

## Reference Files

| File | Description |
|------|------|
| `antigravity.exe.txt` | Antigravity executable path reference |
| `open_agents.ps1` | (Deprecated) Replaced by single multi-vault root IDE launch |
| `check_standards.ps1` | `_Standards/` structure check (debug) |
| `verify_structure.ps1` | `_Standards/` file listing (debug) |
