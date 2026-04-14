# AIMindVaults — Multi-Vault Routing Hub (Codex)

> This file is the entry point for Codex desktop app / Codex CLI only.
> For Claude Code → see `CLAUDE.md`.

## Shared Rules (Canonical Reference — Mandatory)

At session start, read and follow **all rule files** in the `.claude/rules/` directory.
These are mandatory rules that apply equally to all AI agents.

## Agent Identifier

- **Identifier**: `codex`
- Record as `codex / YYYY-MM-DD` in the working agent field at session exit

## Codex Personal Rules (User Instructions Take Priority — Mandatory)

- Unless the user explicitly specifies an **action (create/modify/delete/execute)** in their prompt, Codex operates in **read-only** mode.
- Read-only scope: file browsing, content viewing, status checks, comparisons, summaries, reports.
- Prohibited before explicit instruction: file changes, automation registration/execution, write-mode script execution, external state changes.
- If instructions are ambiguous, do not start modification work — briefly confirm first.

## Session Start Sequence

1. This file (`AGENTS.md`)
2. `.claude/rules/` — all shared mandatory rules (canonical)
3. `_STATUS.md` (root) — overall vault status + check other vault work
4. `.codex/rules/` — Codex-specific rules
5. `.codex/AGENT_STATUS.md`
6. Target vault's `AGENTS.md`
7. Target vault's `_STATUS.md`

Complete this sequence before editing.

## Vault Registry

### BasicVaults (Workspace Hub)

| Vault ID | Path | Role | Status |
|----------|------|------|--------|
| AIHubVault | `Vaults/BasicVaults/AIHubVault/` | AI workspace design, improvement, and distribution hub | active |
| BasicContentsVault | `Vaults/BasicVaults/BasicContentsVault/` | General-purpose content vault (distribution template — do not edit directly) | active |

> Register new vaults in this registry as they are added.
> Create vaults by cloning BasicContentsVault with `node cli.js clone`.

## Vault Routing Rules

1. Explicit vault specification takes priority
2. Keyword inference:
   - "AI workflow", "agent", "_Standards", ".forge" → AIHubVault
   - Other topics → Ask the user (guide vault creation if none exists)
3. If a file path is included → Extract vault from the path
4. If only root files are targeted → Work at root
5. If ambiguous → Ask the user

## Root Scope

Files that can be directly modified at root:
- `AGENTS.md`, `CLAUDE.md`, `CODEX.md`
- `.claude/`, `.codex/`
- `_STATUS.md`, `_ROOT_VERSION.md`

Vault internal files may only be modified after entering the target vault.

## Agent Ownership Rules

- Codex: Note editing within a single vault, repetitive tasks, background cleanup, source note pipeline execution
- Concurrent modification prohibited: `_STATUS.md`, `_WORKSPACE_VERSION.md`, `.obsidian/`
- Multi-vault structural changes and script development are handled by Claude or the user

## Codex Skills (`.codex/skills/`)

| Skill | Purpose |
|-------|---------|
| `create-video-note` | Video URL → structured note |
| `create-article-note` | Web article/text → structured note |
| `create-pdf-note` | PDF → structured note |
| `cross-vault-migration` | Cross-vault note migration |
| `sync-distribution` | Distribution sync |
| `open-note` | Open an Obsidian note |
| `open-vault` | Open an Obsidian vault |

## Opening Obsidian Notes (Mandatory)

All `.md` notes in this environment reside inside **Obsidian vaults**.
When the user says "open the note," it means **opening and focusing the note in Obsidian**.

### Correct Method: Obsidian URI Scheme

```powershell
Start-Process 'obsidian://open?vault=VaultName&file=relative_path_from_vault_root'
```

| Parameter | Description | Example |
|-----------|-------------|---------|
| `vault` | **Folder name** of the vault registered in Obsidian | `AIHubVault`, `BasicContentsVault` |
| `file` | Relative path from vault root. **Omit `.md` extension** | `Contents/Domain/Example_Note` |

- Path separator: Use `/` (not `\`)
- Non-ASCII filenames: Use as-is (no URL encoding needed)
- `Start-Process <filepath.md>`, `code`, `Invoke-Item`, etc. are prohibited as they open in VS Code

### Notes

- Obsidian must be running
- The vault must be registered in Obsidian
- If the file doesn't exist, Obsidian may suggest creating a new note — verify the path carefully

## Codex-Specific Settings

- `.codex/rules/` — Codex-specific rules
- `.codex/skills/` — Encapsulated task procedures

## Session Exit

Both vault `_STATUS.md` and root `_STATUS.md` must be updated.
Details: `.claude/rules/core/session-exit.md`
