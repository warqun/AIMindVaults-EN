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

> The distribution ships with only AIHubVault + BasicContentsVault.
> Create additional vaults by cloning BasicContentsVault with `node cli.js clone`, then register each new vault in the table above.
> Recommended category pattern (use only what applies):
>
> ```
> Vaults/Domains_<area>/<YourDomainVault>/    ← domain knowledge vaults
> Vaults/Projects_<area>/<YourProjectVault>/  ← project work vaults
> Vaults/Personal/<YourPersonalVault>/        ← personal notes
> ```

## Vault Routing Rules

1. Explicit vault naming takes priority.
2. Keyword inference: apply only to vaults that exist in the registry above. Do not infer routes to vaults that have not been created.
   - "AI workflow", "agent", "_Standards", "workspace", "sync script" → AIHubVault
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

## External Tool Integrations (optional)

Users may wire project-specific CLIs or MCP servers (Unity, Blender, etc.) into their workflow. Document usage policies under `.claude/rules/custom/<tool-name>.md` so agents know when to prefer one tool over another.

---

## Codex-specific Config

- `.codex/config.toml` — project config.
- `.codex/rules/` — Codex-only rules.
- `.codex/skills/` — encapsulated procedures.

## Session Exit

Update both the vault `_STATUS.md` and the root `_STATUS.md`.
Details: `.claude/rules/core/session-exit.md`.
