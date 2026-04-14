---
type: version-log
tags:
  - AIMindVault
  - root
updated: 2026-04-08
---

# Root Version Log

Change history for multi-vault root level. Tracks changes to `.claude/`, `.antigravity/`, root configuration files, etc.

| Version | Date | Changes |
|---------|------|---------|
| R053 | 2026-04-13 | Full removal of remaining PS1 references. Converted 200+ files to Node.js CLI references across Codex skills (3), CODEX.md (28), .codex/rules/ (84), .codex/skills/session-end (27), .github/copilot-instructions (28), .antigravity/SESSION_RULES (28), AGENT_ONBOARDING_CLAUDE/CODEX, .codex/rules/edit-scope, agent-ownership, Hub _WORKFLOW, Hub_Sync_Targets, TOOLS_INDEX |
| R052 | 2026-04-13 | Created `docs/` (architecture, cli-reference, customization). Converted 6 core commands from PS1 to Node.js CLI. Updated AGENT_ONBOARDING.md PS1 references + docs integration. Added docs references to README.md |
| R051 | 2026-04-13 | Converted 8 core/custom rules from PS1 to Node.js CLI references. Removed all PS1 files. Added standards command. Overhauled Script_Registry |
| R050 | 2026-04-13 | Deleted TestVault. Registered 4 vault root `CLAUDE.md` entries (GameDesign, Blender, Git, AI_Gen4Game) + routing keywords. Created `Domains_3D`, `Domains_VCS`, `Domains_AI_Asset` categories |
| R049 | 2026-04-13 | Standardized frontmatter `tags`. Flattened hierarchical tags, converted PascalCase to kebab-case, removed vault identifier tags (~696 files in 2 passes). Added tag rules to `note-writing.md` — default format + user override structure. Added type/tag system explanation to `AGENT_ONBOARDING.md` section 8 |
| R048 | 2026-04-13 | Processed 86 empty type entries. Created `folder-index` core type (note-writing.md). Assigned folder-index to 51 Domain.md/Project.md entries, design to 27 CombatToolKit Legacy entries, reference to 5 Grok logs, individual types (plan/knowledge/study-note) to 3 entries |
| R047 | 2026-04-13 | Fixed `master_index_build.ps1` Resolve-Path trailing backslash bug (added TrimEnd). Created `/sync-all` core skill — batch workspace sync for all satellite vaults. Registered in MANIFEST |
| R046 | 2026-04-13 | Standardized frontmatter `type`. Added core type list (21 types) + vault-specific type extension rules to `note-writing.md`. Merged 72 synonyms (standards->standard, knowledge-note/domain->knowledge, planning-note->plan, research-note->research), absorbed 12 one-off types, removed 156 EXAMPLE_JUGGL notes from satellite vaults. Declared vault-specific types in ObsidianDev and Unity CLAUDE.md |
| R045 | 2026-04-13 | Created `Vaults/Domains_Dev/JavaScript/` new vault. Added JavaScript registry and routing keywords to root `CLAUDE.md` and `_STATUS.md` |
| R044 | 2026-04-13 | Added collection scope and boundaries to `vault-individualization.md` CLAUDE.md required fields. Added rule to `vault-routing.md` for referencing candidate vault CLAUDE.md collection scope during routing decisions |
| R043 | 2026-04-08 | Created `user-guidance.md` core rule. Agent guidance instructions for 12 core feature user confusion scenarios. Registered in MANIFEST. Added unregistered vault URI prohibition rules to `create-vault.md` and `open-vault.md`. Added vault registration guidance to `AGENT_ONBOARDING.md` section 16 |
| R042 | 2026-04-08 | Added "Infinite Recursive Path Deletion (Incident Rule)" section to `temp-file-management.md`. PowerShell flatten-and-delete as priority 1, robocopy mirror as priority 2. Listed failing methods (7z, Remove-Item, rd, .NET Delete) |
| R041 | 2026-04-08 | Created `Vaults/Domain_Art/ArtInsight/` new vault. Added ArtInsight registry and routing keywords to root `AGENTS.md`, `CLAUDE.md`, `_STATUS.md`. Individualized ArtInsight entry docs/status docs/content rules. Wrote first note `20260408_Aesthetic_Sense_Standards_of_Discernment.md` |
| R040 | 2026-04-08 | Added content indexer priority search mandatory rule. Created `token-optimization.md` section 0 (indexer -> fallback order). Added mandatory index build on first access to `vault-routing.md`. Added initial build step after creation to `vault-individualization.md` |
| R039 | 2026-04-08 | Renamed vault CodeStyle to AI_Coding. Updated root CLAUDE.md registry/routing and root _STATUS.md registry. Replaced all vault internal tags with AI_Coding |
| R038 | 2026-04-08 | Reinforced mandatory content indexing completion. AIHub `.sync/_tools/cli/post_note_edit_review.ps1` now runs indexer in separate PowerShell process for stable success detection. Added `POST_EDIT_INDEX_UPDATED=1` verification and manual fallback procedure to root `.codex/skills/create-video-note`, `create-article-note`, `create-pdf-note` |
| R037 | 2026-04-08 | Strengthened content indexing rules. Added mandatory post-edit indexing condition (`POST_EDIT_INDEX_UPDATED=1`) to `post-edit-review.md`. Updated `/reindex` skill paths for `.sync/_tools/cli/` structure |
| R036 | 2026-04-08 | Added Codex-specific source note pipelines. Created root `.codex/skills/create-article-note/` and `.codex/skills/create-pdf-note/`. Extended `.codex/skills/create-video-note/` to same standard |
| R035 | 2026-04-06 | Promoted `/open-notes` skill from custom/ to core/. Added 3-stage safety checks: active vault detection, path conversion, file existence verification. Registered in MANIFEST |
| R034 | 2026-04-06 | Created `AGENT_ONBOARDING.md` — universal agent onboarding document. Environment overview, 14 core conventions compressed, rule file path references |
| R033 | 2026-04-06 | Removed Juggl_StyleGuide from `distribution-sync.md` deployment. Changed `juggl-style-sync.md` to per-vault individual management. Renamed `docs/` to `.docs/` across all vaults. Deleted `recent_files.txt`. Moved `Juggl_StyleGuide/` to per-vault `Contents/` |
| R032 | 2026-04-05 | Created `/reindex` skill (`.claude/commands/core/reindex.md`) — single/all vault content index rebuild. Registered in MANIFEST |
| R031 | 2026-04-05 | Created `/open-notes` skill (`.claude/commands/custom/open-notes.md`) — open multiple notes in new tabs via local-rest-api. Registered in global CLAUDE.md skill list |
| R030 | 2026-04-02 | Added rule to `session-exit.md` — when writing per-vault handoff, must leave reference in root handoff |
| R029 | 2026-04-01 | Split session handoff by agent. `_SESSION_HANDOFF.md` split into `_SESSION_HANDOFF_CLAUDE.md` + `_SESSION_HANDOFF_CODEX.md`. Updated `session-exit.md` rules and `CLAUDE.md` entry protocol |
| R028 | 2026-04-01 | Created JissouGame new vault. Established `Projects_Game` category. Updated root `AGENTS.md`, `CLAUDE.md`, `_STATUS.md`, `.claude/rules/core/vault-individualization.md` |
| R027 | 2026-04-01 | Created TileMapToolKit new vault. Added registry/routing to root `AGENTS.md`, `CLAUDE.md`, `_STATUS.md` |
| R026 | 2026-04-01 | Added frontmatter `agent` field rule to `note-writing.md` — cumulative record of all agents that worked on a note, not just the latest |
| R025 | 2026-03-23 | Created vault individualization rule (`.claude/rules/core/vault-individualization.md`) — standardized vault name/category/CLAUDE.md/tags on creation |
| R024 | 2026-03-23 | Created multi-vault personalization rule (`.claude/rules/custom/multivault-personalization.md`) — agent/plugin/skill custom settings |
| R023 | 2026-03-21 | Created Personal category + `Vaults/Personal/Diary/` diary vault. Registered in root CLAUDE.md and _STATUS.md. Added routing keywords |
| R022 | 2026-03-21 | Introduced session handoff system. Created root `_SESSION_HANDOFF.md`. Added handoff writing rules to `session-exit.md`. Added handoff reading to root `CLAUDE.md` entry protocol |
| R021 | 2026-03-21 | Created 2 new vaults: `Vaults/Domains_Infra/AI` (AI domain), `Vaults/Projects_Infra/Project_AIMindVaults` (project) — preparing for AIHubVault content separation |
| R020 | 2026-03-21 | Added mandatory wiki link rule to `note-writing.md` — new notes must include at least 1 wiki link to related notes in the same vault |
| R019 | 2026-03-21 | Added H1 title rules to `note-writing.md` — URI reserved characters and emoji prohibited (mandatory). Added emoji prohibition to file names |
| R018 | 2026-03-21 | Created `Vaults/Domains_Infra/Search/` new vault. Search engine, indexing, and text matching domain knowledge hub. Registered in root CLAUDE.md and _STATUS.md |
| R017 | 2026-03-21 | Created `Vaults/Domains_Infra/CICD/` new vault. CI/CD and deployment sync domain knowledge hub. Registered in root CLAUDE.md and _STATUS.md |
| R016 | 2026-03-21 | Codex desktop app transition. Created `AGENTS.md` for root + 11 vaults (2-stage routing + execution structure). Converted playbooks to `.codex/skills/` SKILL.md format. Migrated `.antigravity/workflows/` to `.codex/skills/`. Created `agent-ownership.md` conflict prevention rules. Marked existing CODEX.md and .antigravity as deprecated |
| R015 | 2026-03-19 | Created `.claude/rules/vault-routing.md`: mandatory vault routing rules. Prohibited direct work on BasicContentsVault. Required vault registry check before content placement |
| R014 | 2026-03-19 | Switched agent rules to canonical reference pattern. Deleted 8 duplicated Cursor/Codex/Antigravity rules. Replaced with `.claude/rules/` canonical references + agent-specific `agent-rules` files. Added canonical references to Codex/Antigravity entry points within AIHubVault |
| R013 | 2026-03-19 | Redesigned root `_STATUS.md` to lightweight registry structure (removed Now/Next/Blocked, replaced with vault type + content + agent work date). Revised root update rules in `session-exit.md`. Registered all 11 vaults |
| R012 | 2026-03-18 | Created `Vaults/Lab_Infra/ObsidianDev/` new vault. Established Lab category (Domain+Project hybrid). Added Labs section to root CLAUDE.md |
| R011 | 2026-03-18 | Created `.claude/commands/auto-organize.md`: auto-categorize notes/vaults into folders skill. AI suggestion + user approval pattern |
| R010 | 2026-03-18 | Created `Vaults/Domains_Infra/Notion/` new vault. Added registry to root CLAUDE.md + _STATUS.md section |
| R009 | 2026-03-18 | Created `.claude/commands/create-vault.md`: vault creation skill. BasicContentsVault-based cloning + post-creation process definition |
| R008 | 2026-03-18 | Added metaphorical/figurative expression prohibition to `note-writing.md`. Task names and titles must directly describe content |
| R007 | 2026-03-17 | Added Juggl `local:` value must use filename rule to `juggl-style-sync.md` (not H1 title) |
| R006 | 2026-03-17 | Added markdown bold+parentheses rendering rule to `note-writing.md`. Prohibited `**text(parentheses)**` pattern |
| R005 | 2026-03-17 | Created `README.md`: multi-vault system introduction, AI rules framework, quick start guide (git distribution entry point) |
| R004 | 2026-03-17 | Created `.claude/rules/token-optimization.md`: mandatory token conservation and execution delegation rules |
| R003 | 2026-03-17 | Added mandatory `_ROOT_VERSION.md` recording rule for root-level edits to `edit-mode-separation.md` |
| R002 | 2026-03-17 | Created 3 new `.claude/rules/`: temp-file-management, distribution-sync, script-creation-approval |
| R001 | 2026-03-17 | Created 2 new `.antigravity/workflows/`: create-video-note, sync-distribution |
