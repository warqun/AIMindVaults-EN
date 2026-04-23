# AIMindVaults — Multi-Vault Routing Hub

> This directory is the top-level working directory that manages multiple Obsidian vaults.
> Always follow the vault entry protocol when working on individual vaults.
> Shared mandatory rules are defined in `.claude/rules/core/` and auto-applied.

## Intent-Based Entry Guide

First identify the **intent category** from the user's message, then read the corresponding entry points. If the intent is unclear, fall back to the keyword mapping in § "Vault Entry Protocol".

| Intent | Entry points (in order) |
|--------|-------------------------|
| **Current status / priorities** | Root `_STATUS.md` → target vault `_STATUS.md` |
| **Restore previous session context** | Root `_SESSION_HANDOFF_CLAUDE.md` · `_SESSION_HANDOFF_CODEX.md` → target vault `_SESSION_HANDOFF_*` |
| **Create a new note** | Vault routing (§ Vault Entry Protocol keyword mapping) → target vault `CLAUDE.md` → `/juggl-note` or `/note-from-*` |
| **Search / investigate existing content** | `aimv index search -r <vault>` (single) or `aimv index master-search` (cross-vault) |
| **Domain knowledge reference** | Domains_* vaults (e.g., Unity, Python, Cooking, AI) · each vault's `_VAULT-INDEX.md` |
| **Project / tool work** | Projects_* / Lab_* vaults · target vault's `_STATUS.md` Now·Next |
| **Multi-Hub system changes** | Core layer → `Vaults/BasicVaults/CoreHub/` · Custom layer → `AIHubVault/` · root rules/skills → `.claude/` |
| **Distribution / Git push** | Corresponding language distribution repo (`Korean` / `English`) |
| **Add / modify rules or skills** | `.claude/rules/core/` (distribution target) · `.claude/rules/custom/` (personal) · `.claude/commands/` |
| **Personal records / retrospectives** | Diary vault (AI access `ai_scope=none` by default) |
| **Multi-agent collaboration** | `.claude/rules/custom/agent-ownership.md` + target vault `AGENT_STATUS.md` |

Each intent points to a concrete entry file at the intersection of **time (past/present) × target (vault/Hub/root) × action (read/edit/deploy)**. When crossing vault boundaries after entry, still follow the required read order in "Vault Entry Protocol".

## Vault List and Paths

**For the full vault list, paths, and status, see the vault registry in the root `_STATUS.md`.**

The registry manages vault name · type · path · content · working agent, organized by category (BasicVaults, Domains, Labs, Projects, etc.).

## Vault Entry Protocol (Mandatory)

### 1. Identify the target vault

- Explicit specification: "In AIHubVault ~", "BasicContentsVault ~"
- Keyword inference (see mapping below):

| Keyword | Vault ID |
|---------|----------|
| _Standards, workspace, sync script | AIHubVault (workspace-only Hub) |
| content, note writing, knowledge management | BasicContentsVault |
| Unity | Unity |
| CapCut, video editing | CapCut |
| Notion | Notion |
| CI/CD, deployment sync, pipeline | CICD |
| search, indexing, indexer, text matching, Search | Search |
| AI usage, agent usage, prompt, AI tools | AI |
| AppFlowy, self-host, Notion migration | AppFlowy |
| Discord, bot, Welcome flow, Rules Screening, community moderation | Discord |
| AIMindVaults project, multi-vault plan, distribution plan | Project_AIMindVaults |
| Obsidian plugin, plugin development | ObsidianDev |
| combat system, CombatToolKit, skill system, effect package | CombatToolKit |
| tilemap, TileMap, map generation, chunk, procedural generation | TileMapToolKit |
| JissouGame, jissou | JissouGame |
| game design, level design, balancing, GameDesign | GameDesign |
| game art, visual techniques, Fake 2D, rendering style, shader style | GameArt |
| Blender, 3D modeling, mesh, texturing | Blender |
| Git, version control, branch, commit | Git |
| AI assets, Meshy, AI texturing, AI 3D generation, AI_Gen4Game | AI_Gen4Game |
| light and color, color theory, contrast, color temperature | LightAndColor |
| art insight, aesthetic sense, taste, trends, classics, mood and emotion | ArtInsight |
| crowdfunding, funding, revenue model, fundraising | Funding |
| Python, pandas, numpy, pip | Python |
| JavaScript, Node.js, npm, TypeScript | JavaScript |
| AI coding, code style, clean code, naming convention, refactoring | AI_Coding |
| cooking, culinary science, ingredients, cooking techniques, food culture | Cooking |
| cooking philosophy, recipe research, cooking channels, recipe analysis | CookingLab |
| diary, retrospective, growth log, personal memo | Diary |
| Unity manual, Script API, Unity docs | Unity_Documentation (readonly) |

- If a file path is included → Extract vault from the path.
- If ambiguous → Ask the user.
- **Resolve vault ID → actual path via the "Path" column in the root `_STATUS.md` vault registry.**

### 2. Required reading on vault entry (in order)

- `_SESSION_HANDOFF_CLAUDE.md` (root) — Previous Claude session context
- `_SESSION_HANDOFF_CODEX.md` (root) — Previous Codex session context (check conflicts/dependencies)
- `_STATUS.md` (root) — Overall vault status + check conflicts with other vault work
- `{vault-path}/CLAUDE.md` — Vault-specific rules
- `{vault-path}/_STATUS.md` — Current progress

### 3. Workspace sync review (when target vault ≠ AIHubVault)

- Compare the top version in `{vault-path}/_WORKSPACE_VERSION.md` with AIHubVault's top version.
- If there is a difference → Sync from AIHubVault before starting work.
- Detailed protocol: AIHubVault sync scripts under `.sync/`.

### 4. Cross-vault work rules

- When modifying 2+ vaults, separate by vault and execute sequentially.
- Complete the current vault's edits before switching.

## Root Scope

Files that can be directly modified at root:
- `_STATUS.md` (multi-vault status hub)
- `CLAUDE.md` (this file)
- `CODEX.md` (Codex root entry point)
- `.claude/` (root Claude settings)
- `.codex/` (root Codex settings)
- `.cursor/` (root Cursor settings)
- `docs/` (root documentation)

Vault internal files may only be modified after completing the vault entry protocol.

## Injection Structure (from 2026-04-18 Phase 1)

### Always Injected (every session)

- `.claude/rules/core/_essentials.md` — **Unified core**: report language, token economy, vault routing, edit mode, Post-Edit Review, note writing, session exit
- `.claude/rules/core/_skill-router.md` — Trigger keyword → rule file mapping
- Rest of `.claude/rules/core/` — Distribution rules (distribution-sync, encoding-safety, juggl-style-sync, obsidian-config-safety, script-creation-approval, script-management, temp-file-management, user-guidance)
- `.claude/rules/custom/` — Personal user rules

### Conditional Load (Skill Router on trigger)

- `.claude/rules-archive/` — Excluded from auto-injection. Read per `_skill-router.md` instructions when trigger keywords are detected.

### Namespace

```
.claude/rules/core/       ← distribution rules (sync target, auto-injected)
.claude/rules/custom/     ← user rules (not synced, auto-injected)
.claude/rules-archive/    ← not auto-injected, manual Read via Skill Router
.claude/commands/core/    ← distribution skills (sync target)
.claude/commands/custom/  ← user skills (not synced)
```

Each folder's `MANIFEST.md` lists files subject to distribution.

## Agent Mandatory Requirements

- **On every user message**: Evaluate work type based on `_essentials.md` + `_skill-router.md`. On detecting trigger keywords, Read the corresponding rule file before starting work.
- **When creating vaults**: Follow `vault-individualization.md` rules to specify name/category/CLAUDE.md/tags.
- **When customizing multi-vault settings**: Reference `multivault-personalization.md` to reflect the user's agent/plugin choices.
- **Agent entry point files** (`CLAUDE.md`, `CODEX.md`, `AGENT_STATUS.md`) are vault-specific and are not included in distribution sync.
