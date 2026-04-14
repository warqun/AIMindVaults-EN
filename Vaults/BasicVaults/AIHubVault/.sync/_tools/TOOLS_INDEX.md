# Tools Index

> Tool list under `_tools/`. Distributed to all vaults via Hub-Sync.

---

## Node.js CLI (`cli-node/`)

> Unified entry point for all automation tools. Cross-platform CLI based on Node.js.

**Usage**: `node ".sync/_tools/cli-node/bin/cli.js" <command> [options]`

| Command | Purpose | Example |
|---------|---------|---------|
| `review` | Post-edit quality verification (frontmatter, encoding) | `aimv review -r . -s Contents` |
| `bridge` | Obsidian local-rest-api wrapper (search, read, open) | `aimv bridge -a search -q "keyword"` |
| `sync` | AIHubVault -> satellite vault workspace sync | `aimv sync -r .` |
| `pre-sync` | Auto-sync on Obsidian startup (trampoline) | `aimv pre-sync -r .` |
| `broadcast` | Instantly propagate a specific Hub file to all satellite vaults | `aimv broadcast -p "file.md"` |
| `index build` | Build vault content index | `aimv index build -r .` |
| `index search` | Index-based keyword/tag/type search | `aimv index search -q "search term"` |
| `route` | Task text-based vault/agent routing | `aimv route -t "task"` |
| `clone` | Vault mirror clone (robocopy-based) | `aimv clone -t <path> -n <name>` |
| `standards` | `_Standards/` structure verification | `aimv standards -r .` |
| `trash-clean` | Obsidian trash cleanup | `aimv trash-clean -r .` |

### bridge Action List

| Action | Permission | Description |
|--------|-----------|-------------|
| `vault-info` | Read | Query vault information |
| `search` | Read | Text search |
| `search-context` | Read | Search with context |
| `read` | Read | Read file contents |
| `open` | Read | Open note in Obsidian |
| `append` | Write | Append content to end of file |
| `create` | Write | Create new file |
| `history` | Read | File history list |
| `history-read` | Read | Read history version |
| `history-restore` | Write | Restore history version |
| `diff` | Read | Compare differences between versions |
| `plugins-list` | Read | List installed plugins |
| `plugin-install` | Write | Install plugin |
| `post-review` | Read | Run post-edit quality verification |

---

## User Tools

> Launchers for direct user execution.

| File | Purpose | How to Run |
|------|---------|-----------|
| `cli_launchers/RUN_CLAUDE.bat` | Launch Claude CLI | Double-click |
| `cli_launchers/RUN_CODEX.bat` | Launch Codex CLI | Double-click |
| `cli_launchers/RUN_GEMINI.bat` | Launch Gemini CLI | Double-click |

---

## Detailed CLI Reference

Full 14-command reference: `docs/cli-reference.md` (root)
