# AIMindVaults — Multi-Vault Routing Hub

> This directory is the top-level working directory that manages multiple Obsidian vaults.
> Always follow the vault entry protocol when working on individual vaults.
> Shared mandatory rules are defined in `.claude/rules/` and auto-applied.

## Vault Registry

### BasicVaults (Workspace Hub)

| Vault ID | Path | Role | Status |
|----------|------|------|--------|
| AIHubVault | `Vaults/BasicVaults/AIHubVault/` | **Workspace source of truth (Hub)** — AI workspace design, improvement, and distribution hub | active |
| BasicContentsVault | `Vaults/BasicVaults/BasicContentsVault/` | General-purpose content vault (distribution template — do not edit directly) | active |

> Register new vaults in this registry as they are added.
> Create vaults by cloning BasicContentsVault with `node cli.js clone`.

## Vault Entry Protocol (Mandatory)

1. **Identify the target vault**
   - Explicit specification: "In AIHubVault ~", "BasicContentsVault ~"
   - Keyword inference:
     - "AI workflow", "agent", "_Standards", "workspace", "sync script" → AIHubVault
     - Other topics → Ask the user (guide vault creation if none exists)
   - If a file path is included → Extract vault from the path
   - If ambiguous → Ask the user

2. **Required reading on vault entry** (in order)
   - `_SESSION_HANDOFF_CLAUDE.md` (root) — Previous Claude session context, changed files, incomplete items
   - `_SESSION_HANDOFF_CODEX.md` (root) — Previous Codex session context (check for conflicts/dependencies)
   - `_STATUS.md` (root) — Overall vault status + check for conflicts with other vault work
   - `{vault-path}/CLAUDE.md` — Vault-specific rules
   - `{vault-path}/_STATUS.md` — Current progress

3. **Workspace sync review** (when target vault is not AIHubVault)
   - Compare the top version in `{vault-path}/_WORKSPACE_VERSION.md` with AIHubVault's top version
   - If there is a difference → Sync from AIHubVault before starting work
   - Details: See sync scripts in AIHubVault `.sync/`

4. **Cross-vault work rules**
   - When modifying 2 or more vaults, separate by vault and execute sequentially
   - Complete edits in the current vault before switching to another

## Root Scope

Files that can be directly modified at root:
- `_STATUS.md` (multi-vault status hub)
- `CLAUDE.md` (this file)
- `CODEX.md` (Codex root entry point)
- `.claude/` (root Claude settings)
- `.codex/` (root Codex settings)
- `docs/` (root documentation)

Vault internal files may only be modified after completing the vault entry protocol.

## Injection Structure (from 2026-04-18)

### Always Injected (every session)

- `.claude/rules/core/_essentials.md` — **Unified core**: report language, token economy, vault routing, edit mode, Post-Edit Review, note writing, session exit
- `.claude/rules/core/_skill-router.md` — Trigger keyword → Skill / rule file mapping
- Rest of `.claude/rules/core/` — Distribution rules (distribution-sync, encoding-safety, juggl-style-sync, obsidian-config-safety, script-creation-approval, script-management, temp-file-management, user-guidance slim)
- `.claude/rules/custom/` — User's personal rules

### Conditional Load (Skill Router on trigger)

- `.claude/rules-archive/` — Excluded from auto-injection. On detecting trigger keywords, Read per `_skill-router.md` instructions. Includes consolidated-source rules (token-optimization, session-exit, note-writing, vault-routing, post-edit-review, edit-mode-separation) and on-demand docs (vault-individualization, user-guidance-detail).

### Namespace

```
.claude/rules/core/       ← distribution rules (sync targets, auto-injected)
.claude/rules/custom/     ← user rules (not synced, auto-injected)
.claude/rules-archive/    ← not auto-injected, Read via Skill Router
.claude/commands/core/    ← distribution skills (sync targets)
.claude/commands/custom/  ← user skills (not synced)
```

Each folder's `MANIFEST.md` lists files subject to distribution.

### User Personalization Rules

The following rules live in `.claude/rules/custom/`. Not subject to distribution sync:
- Multi-vault personalization (`multivault-personalization.md`) — Custom agent/plugin/skill settings

### Agent Mandatory Requirements

- **When creating vaults**: Follow `vault-individualization.md` rules to specify name/category/CLAUDE.md/tags.
- **When customizing multi-vault settings**: Reference `multivault-personalization.md` to reflect user's agent/plugin choices.
- **Agent entry point files** (`CLAUDE.md`, `CODEX.md`, `AGENT_STATUS.md`) are vault-specific files and are not included in distribution sync.

### Namespace Structure

```
.claude/rules/core/     ← Distribution rules (sync target)
.claude/rules/custom/   ← User rules (not synced)
.claude/commands/core/   ← Distribution skills (sync target)
.claude/commands/custom/ ← User skills (not synced)
```

Each folder's `MANIFEST.md` lists the distribution files.
