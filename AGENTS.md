# AIMindVaults — Multi-Vault Routing Hub (Codex)

> This file is the dedicated entry point for the Codex Desktop App / Codex CLI.
> Claude Code → see `CLAUDE.md`.

## Common Rules (Phase 1 Structure — Mandatory)

Load rules in the following order at session start:

1. **Always required** (Codex must Read explicitly; Claude is auto-injected):
   - `.claude/rules/core/*.md` — distribution rules (common to all agents)
   - `.claude/rules/custom/*.md` — user personal rules
2. **Read on trigger** (per work type):
   - `.claude/rules-archive/*.md` — domain / detailed rules
   - Trigger mapping is defined in `.codex/rules/skill-router.md` (planned)
   - If no mapping matches, proceed with core/custom only

These rules are Mandatory and apply equally to all AI agents.
Claude has an auto-injection mechanism, but Codex does not — at session start, Codex must explicitly Read every core/custom file.

Agents not listed here (Cursor, Windsurf, GitHub Copilot, Antigravity, etc.) may also be attached freely. Each user is responsible for cleaning up the entry-point and rule files of agents they do not use.

## Agent Identifier

- **Identifier**: `codex`
- At session end, record the working agent as `codex / YYYY-MM-DD`

## Codex Personal Rule (User Instructions Take Precedence — Mandatory)

- If the user does not explicitly specify an **action (create / modify / delete / execute)** in the prompt, Codex operates in **read-only** mode.
- Read-only scope: file exploration, content lookup, status check, comparison, summary, reporting.
- Forbidden before an explicit instruction: file changes, automation registration / execution, write-side scripts, any change to external state.
- If instructions are ambiguous, do not start a write operation — confirm briefly first.

## Session Start Order

1. This file (`AGENTS.md`)
2. `.claude/rules/core/*.md` — always required (Read every file)
3. `.claude/rules/custom/*.md` — always required (Read every file)
4. `_STATUS.md` (root) — overall vault status + cross-vault work check
5. `_AGENT_COMMS/to_codex/` — scan for messages left by Claude (check `status: open`)
6. `.codex/rules/` — Codex-specific rules (skill-router · edit-scope · status-sync · encoding-safety · vault-routing)
7. On trigger match, Read the corresponding file under `.claude/rules-archive/` (mapping in `.codex/rules/skill-router.md`)
8. (When entering a vault) The vault's `_STATUS.md`

Complete this order before editing.
`.codex/AGENT_STATUS.md` and per-vault `AGENTS.md` are legacy artifacts — Read them only if needed (mostly stubs).

## Vault Registry

**The full vault list, paths, and status live in the root `_STATUS.md` vault registry.**

The registry uses category-based tables (BasicVaults, Domains, Labs, Projects, etc.) to manage vault name · type · path · contents · working agent.

The vault ID → actual path resolution is looked up from the "Path" column of the root `_STATUS.md` vault registry.

## Vault Routing Rules

1. Explicit vault designation takes precedence
2. Keyword inference:
   - <domain keyword> → <corresponding vault ID>
   - (example: Python, pandas) → (example: Python)
   - Each user maintains the keyword mapping for their own vault set
3. If a file path is included → extract the vault from the path
4. If only root files are involved → operate at the root
5. If ambiguous → confirm with the user

## Root Scope

Files modifiable directly at the root:
- `AGENTS.md`, `CLAUDE.md`, `CODEX.md`
- `.claude/`, `.codex/`
- `_STATUS.md`, `_ROOT_VERSION.md`
- `_AGENT_COMMS/` (inter-agent communication — not a vault)
- `docs/`

Files inside vaults are modified only after entering the target vault.

## Agent Ownership Rules

See `.claude/rules/custom/agent-ownership.md`.
- Codex: in-vault note edits, repetitive tasks, background cleanup
- Concurrent-edit forbidden: `_STATUS.md`, `_WORKSPACE_VERSION.md`, `.obsidian/`

## Serena MCP — Semantic Code Analysis Tool

The Serena MCP server is connected. Prefer Serena's symbol tools over reading whole files.

### Project Activation (once per session)

Activate the target project before accessing it.

| Project | Path |
|---------|------|
| (per user) | (per user) |

### Main Tools

| Tool | Purpose |
|------|---------|
| `activate_project` | Activate a project (specify path) |
| `get_symbols_overview` | List classes / methods inside a file |
| `find_symbol` | Search by symbol name |
| `find_referencing_symbols` | Find references to a specific symbol |
| `search_for_pattern` | Code pattern search (grep replacement) |
| `replace_symbol_body` | Replace a symbol body (for edits) |

### Usage Principles

- Run `get_symbols_overview` to grasp structure before reading the whole file
- Use `find_symbol` to read only the required symbols
- Replace broad searches with `search_for_pattern`

---

## Unity CLI — Unity Editor Control

A CLI tool usable while the Unity Editor has the target project open.

| Purpose | Command |
|---------|---------|
| Inspect console logs | `unity-cli console` |
| Recompile | `unity-cli editor refresh --compile` |
| Run tests | `unity-cli test` |
| Custom Tool | `unity-cli <tool_name> --params '{...}'` |

Custom Tools live in each user's project under `Assets/Editor/UnityCliTools/`.
The `mcp__mcp-unity__*` MCP tools are not used.

---

## Codex-Specific Configuration

- `.codex/config.toml` — project configuration
- `.codex/rules/` — Codex-specific rules
- `.codex/skills/` — encapsulated work procedures

## Session End

Both the vault `_STATUS.md` and the root `_STATUS.md` must be updated.
Details: `.claude/rules/core/session-exit.md`
