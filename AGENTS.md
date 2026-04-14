# AIMindVaults — Multi-Vault Routing Hub (Codex)

> This file is the entry point for the Codex desktop app / Codex CLI.
> Claude Code → see `CLAUDE.md`.

## Shared Rules (Canonical Reference — Mandatory)

At session start, read and follow **every rule file** under `.claude/rules/`.
These rules apply to every AI agent uniformly — they are Mandatory.

## Agent Identifier

- **Identifier**: `codex`.
- At session end, log the working agent as `codex / YYYY-MM-DD`.

## Codex Personal Rule (User Instruction Takes Precedence — Mandatory)

- If the user's prompt does not explicitly request an **action (create/modify/delete/execute)**, Codex operates in **read-only** mode.
- Read-only scope: file exploration, content inspection, state checks, comparison, summarization, reporting.
- Forbidden before explicit instruction: file modification, scheduling/running automation, writing scripts, changing external state.
- When instruction is ambiguous, do not start a change operation — confirm briefly first.

## Session Start Order

1. This file (`AGENTS.md`).
2. All of `.claude/rules/` — shared mandatory rules (canonical).
3. `_STATUS.md` (root) — overall vault state + cross-vault conflict check.
4. `.codex/rules/` — Codex-specific rules.
5. `.codex/AGENT_STATUS.md`.
6. Target vault's `AGENTS.md`.
7. Target vault's `_STATUS.md`.

Complete this sequence before editing anything.

## Vault Registry

### BasicVaults (workspace hub)

| Vault ID | Path | Role | Status |
|----------|------|------|--------|
| AIHubVault | `Vaults/BasicVaults/AIHubVault/` | AI-workspace design / improvement / distribution hub | active |
| BasicContentsVault | `Vaults/BasicVaults/BasicContentsVault/` | General-purpose content store (distribution — do not edit directly) | active |

### Domains (domain-knowledge vaults) — examples

| Vault ID | Path | Role | Status |
|----------|------|------|--------|
| Unity | `Vaults/Domains_Game/Unity/` | Unity engine domain knowledge | active |
| GameDesign | `Vaults/Domains_Game/GameDesign/` | Game design / planning | active |
| CapCut | `Vaults/Domains_Video/CapCut/` | CapCut video-editing domain knowledge | active |
| Notion | `Vaults/Domains_Infra/Notion/` | Notion workspace operations | active |
| Git | `Vaults/Domains_VCS/Git/` | Git version-control knowledge | active |
| Blender | `Vaults/Domains_3D/Blender/` | Blender 3D domain knowledge | active |

### Projects (project vaults) — examples

| Vault ID | Path | Role | Status |
|----------|------|------|--------|
| Project_AIMindVaults | `Vaults/Projects_Infra/Project_AIMindVaults/` | AIMindVaults multi-vault system project | active |

> The distribution ships with only AIHubVault + BasicContentsVault. The rows above are examples of how users typically organize their own vaults.

## Vault Routing Rules

1. Explicit vault naming takes priority.
2. Keyword inference:
   - "AI workflow", "agent", "_Standards", ".forge" → AIHubVault
   - "Unity", "unity engine" → Unity
   - "CapCut", "video editing" → CapCut
   - "Notion", "notion operations" → Notion
   - "Obsidian plugin", "plugin dev" → ObsidianDev
   - "Git", "version control" → Git
   - "Blender", "3D" → Blender
   - (Extend this list as the user adds their own vaults.)
3. If the request includes a file path → extract the vault from the path.
4. If only root files are in scope → work at the root.
5. If ambiguous → confirm with the user.

## Root Scope

Directly editable at the root:
- `AGENTS.md`, `CLAUDE.md`, `CODEX.md`
- `.claude/`, `.codex/`
- `_STATUS.md`, `_ROOT_VERSION.md`
- `docs/`

Files inside a vault are only editable after entering the target vault per the entry protocol.

## Agent Ownership Rules

See `.claude/rules/custom/agent-ownership.md`.
- Codex: note editing within a single vault, repetitive work, background cleanup.
- No concurrent edit: `_STATUS.md`, `_WORKSPACE_VERSION.md`, `.obsidian/`.

## Serena MCP — Semantic Code Analysis (if available)

When the Serena MCP server is connected, prefer its symbol tools over reading whole files.

### Project activation (once per session)

Activate the target project before accessing it.

### Key tools

| Tool | Purpose |
|------|---------|
| `activate_project` | Activate a project (by path) |
| `get_symbols_overview` | List classes/methods in a file |
| `find_symbol` | Search by symbol name |
| `find_referencing_symbols` | Find references to a symbol |
| `search_for_pattern` | Pattern search (grep alternative) |
| `replace_symbol_body` | Replace a symbol's body (editing) |

### Principles

- Use `get_symbols_overview` to understand structure before reading a whole file.
- Use `find_symbol` to read only the symbols you need.
- Replace broad grep with `search_for_pattern`.

---

## Unity CLI — Unity Editor Control (if used)

Available when the Unity editor is open on the target project.

| Purpose | Command |
|---------|---------|
| Console logs | `unity-cli console` |
| Recompile | `unity-cli editor refresh --compile` |
| Run tests | `unity-cli test` |
| Custom tool | `unity-cli <tool_name> --params '{...}'` |

Do not use `mcp__mcp-unity__*` MCP tools when unity-cli is available.

---

## Codex-specific Config

- `.codex/config.toml` — project config.
- `.codex/rules/` — Codex-only rules.
- `.codex/skills/` — encapsulated procedures.

## Session Exit

Update both the vault `_STATUS.md` and the root `_STATUS.md`.
Details: `.claude/rules/core/session-exit.md`.
