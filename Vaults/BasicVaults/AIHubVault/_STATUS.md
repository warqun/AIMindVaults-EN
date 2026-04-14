---
type: status
updated: 2026-03-21
---
# STATUS — Current Progress

> **This document is the only status document for this vault.**
> All agents directly update this file at session end.
> AGENT_STATUS is an optional record at the agent's own discretion.

## Role of This Vault

> **AI Workspace Design, Improvement & Distribution Hub**
> - Manages AI operational structures: `_Standards`, `_tools`, `.claude`, `.forge`
> - Game development/planning work is NOT performed in this vault

## Now (Current Focus)

- **Workspace 3-tier structure (Core/Custom/Vault-local) implementation** — sync_workspace.ps1 batch restructuring, Core 4 plugin separation complete
- **Linter Core activation** — frontmatter auto-sorting, updated auto-refresh, Core data.json forced sync
- **Multi-vault personalization + vault individualization rules** — Agent entry point excluded from distribution

## Next (Upcoming Tasks)

- Custom override mechanism implementation (per-vault plugin/guide exclusion)
- Core area Obsidian UI hiding
- **Distribution repo sync + git push** — Reflect changes
- Distribution version check (for installation)

## Blocked (Blockers / Decisions Needed)

- None

## Decisions

- (2026-03-23) **Workspace 3-tier**: Core (forced sync) / Custom (synced but prunable) / Vault-local (not synced)
- (2026-03-23) **4 Core plugins confirmed**: local-rest-api, dataview, templater, linter
- (2026-03-23) **Juggl_StyleGuide demoted to Custom**: Moved from Core to Custom Batch
- (2026-03-23) **_VAULT-INDEX.md sync removed**: Vault-local (structure differs per vault)
- (2026-03-23) **Only Linter data.json forced sync**: local-rest-api preserved due to API keys/certificates
- (2026-03-23) **Agent entry point files excluded from distribution**: CLAUDE.md, CODEX.md, AGENT_STATUS.md
- (2026-03-21) **Vault content indexer introduced**: JSON-based metadata index + weighted ranking search
- (2026-03-21) **Agent system change**: 4 agents -> 2 agents (Claude Code + Codex)
- (2026-03-21) **Trampoline pattern introduced**: pre_sync.ps1 re-executes in new process on self-update. Structural solution for chicken-and-egg problem
- (2026-03-21) **Version log separation**: _WORKSPACE_VERSION.md lightweight (1 line) + _WORKSPACE_CHANGELOG.md (Hub only)
- (2026-03-21) **Obsidian auto-reload**: After sync, triggers app:reload via Local REST API when new plugins detected
- (2026-03-21) **Plugin sync method finalized**: Text-based direct merge of community-plugins.json (Advanced URI .bat method deprecated)
- (2026-03-20) **Namespace separation**: .claude/rules/ and commands/ split into core/custom. New items go to custom first, promoted to core after validation
- (2026-03-20) **Plugin sync**: Batch 0 added, Advanced URI enable-plugin method instead of direct community-plugins.json editing (later deprecated on 2026-03-21)
- (2026-03-20) **Filename rules**: URI reserved characters (#%&?+) prohibited in filenames, alternative notation (CSharp, CPP, QnA)
- (2026-03-20) **Vault routing rules established**: Direct work on BasicContentsVault prohibited, unregistered vaults auto-registered
- (2026-03-20) **Workspace edit order reinforced**: Edit -> immediate version record -> then deployment/testing
- (2026-03-15) **Status system redesign**: AGENT_STATUS merge method abolished -> `_STATUS.md` direct update required, AGENT_STATUS demoted to recommended
- (2026-03-15) **4-agent system established**: Claude Code / Codex / Antigravity / Cursor
- (2026-03-14) **Multi-vault environment transition complete**: Directory restructuring + root hub creation
- (2026-03-10) **Root Codex hub introduced**: Root `CODEX.md` + `.codex/`
- (2026-03-09) **Agent entry point separation**: CLAUDE.md / CODEX.md / SESSION_RULES.md
- (2026-03-09) **Script duplication prevention system**: Script_Registry.md + Script_Creation_Rule.md
- (2026-03-08) **Vault scope confirmed**: AI workspace hub (game development/planning excluded)
