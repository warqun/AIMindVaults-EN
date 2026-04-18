---
type: version-log
tags:
  - AIMindVault
  - root
updated: 2026-04-15
---

# Root Version Log

Change history for multi-vault root-level files: `.claude/`, `.antigravity/`, root config files, distribution-targeted rules and skills.

## Schema

| Column | Meaning |
|--------|---------|
| Version | `R` + 3 digits, sequential |
| Date | YYYY-MM-DD |
| Change | What changed |
| KO | Korean distribution reflection (`✅` applied / `🕓` pending / `–` N/A) |
| EN | English distribution reflection (`✅` applied / `🕓` pending / `–` N/A) |

## New schema (from 2026-04-15)

| Version | Date | Change | KO | EN |
|---------|------|--------|----|----|
| R063 | 2026-04-18 | **`.forge/` directory removed across all vaults** — external-agent staging hub concept retired. Purged `_forge`/`.forge` references in root `CLAUDE.md`, `.cursorrules`, `.codex/`, AIHubVault entry points, workflow docs, and PS1 scripts. Hub identification marker changed from `_forge/` to `.sync/.hub_marker` (Node.js CLI already used this, PS1 aligned). Distribution-level cleanup (content-standard alignment, removal of creator-specific examples) applied to English distribution. | ✅ | ✅ |
| R058-R062 | 2026-04-18 | **Rules injection restructure Phase 1~3** — Added `_essentials.md` + `_skill-router.md` as always-loaded core. Moved 7 legacy rules (token-optimization, session-exit, note-writing, vault-routing, post-edit-review, edit-mode-separation, vault-individualization) to `rules-archive/` for on-demand loading. Slimmed `user-guidance.md` (high-risk inline only; full detail in `rules-archive/user-guidance-detail.md`). Updated `MANIFEST.md` and `create-vault.md` skill with archive references. Distribution-specific `_skill-router.md` omits creator-only Skill rows (Unity/Blender/Meshy/Discord/Notion/Distribute). | ✅ | ✅ |
| R054 | 2026-04-15 | Bilingual distribution structure (Korean/English split repos). `distribution-deploy.md` updated with dual-path table and GitHub Issues triage rules. `_ROOT_VERSION.md` schema migrated to per-distribution columns. README rewritten around the "AI volatility + Obsidian scaling + multi-vault seams" narrative for both distributions. | ✅ | ✅ |

## Legacy schema (before 2026-04-15)

Below entries predate the bilingual split. All were applied to the (then single) Korean distribution.

| Version | Date | Change |
|---------|------|--------|
| R053 | 2026-04-13 | Removed remaining PS1 references across Codex skills, `CODEX.md`, `.codex/rules/`, `.codex/skills/session-end`, `.github/copilot-instructions`, `.antigravity/SESSION_RULES`, onboarding docs, edit-scope, agent-ownership, Hub `_WORKFLOW`, `Hub_Sync_Targets`, `TOOLS_INDEX`. ~200 files migrated to Node.js CLI references. |
| R052 | 2026-04-13 | Added `docs/` (architecture, cli-reference, customization). Converted 6 core commands from PS1 to Node.js CLI. Updated `AGENT_ONBOARDING.md` and `README.md` accordingly. |
| R051 | 2026-04-13 | Converted 8 core/custom rules from PS1 to Node.js CLI references. Removed remaining PS1. Added standards command. Reorganized `Script_Registry`. |
| R050 | 2026-04-13 | Registered several new vaults in the root registry and routing keywords. Added new category folders for them. |
| R049 | 2026-04-13 | Standardized frontmatter `tags`. Flattened hierarchical tags, converted PascalCase → kebab-case, removed vault-id tags (~696 files across 2 passes). Added tag rules to `note-writing.md` (default format + user override). Added type/tag system section to `AGENT_ONBOARDING.md` §8. |
| R048 | 2026-04-13 | Handled 86 empty-type notes. Added `folder-index` core type (note-writing.md). Assigned folder-index to 51 Domain.md/Project.md, design to legacy notes, reference to 5 Grok logs, individual types to 3 others. |
| R047 | 2026-04-13 | Fixed `master_index_build.ps1` Resolve-Path trailing backslash bug (added TrimEnd). Added `/sync-all` core skill — batch workspace sync for all satellite vaults. Registered in MANIFEST. |
| R046 | 2026-04-13 | Standardized frontmatter `type`. Added 21-item core type list + vault-specific type extension rule to `note-writing.md`. Merged 72 synonyms (standards→standard, knowledge-note/domain→knowledge, planning-note→plan, research-note→research), absorbed 12 one-off types, removed 156 EXAMPLE_JUGGL notes from satellite vaults. Added dedicated type declarations to specific vault CLAUDE.md files where needed. |
| R045 | 2026-04-13 | Created new vault `Vaults/Domains_Dev/JavaScript/`. Added JavaScript registry entry and routing keywords to root `CLAUDE.md` and `_STATUS.md`. |
| R044 | 2026-04-13 | Added scope/boundary requirement to CLAUDE.md in `vault-individualization.md`. Added rule to reference candidate vault CLAUDE.md scope during routing decisions in `vault-routing.md`. |
| R043 | 2026-04-08 | Added `user-guidance.md` core rule. Agent guidance for 12 core feature confusion scenarios. Registered in MANIFEST. Added unregistered-vault URI ban to `create-vault.md`, `open-vault.md`. Added vault registration guidance to `AGENT_ONBOARDING.md` §16. |
| R042 | 2026-04-08 | Added "Infinite Recursion Path Deletion (Incident Rule)" section to `temp-file-management.md`. PowerShell flatten-and-delete as primary, robocopy mirror as secondary. Documented failing approaches (7z, Remove-Item, rd, .NET Delete). |
| R041 | 2026-04-08 | Created a new domain vault. Added it to root `AGENTS.md`, `CLAUDE.md`, `_STATUS.md` with routing keywords. Created individual entry/status/content docs. Added first note. |
| R040 | 2026-04-08 | Added content-indexer-first search rule. Created `token-optimization.md` §0 (indexer → fallback order). Added mandatory index build on first vault access to `vault-routing.md`. Added initial build step to `vault-individualization.md`. |
| R039 | 2026-04-08 | Renamed vault CodeStyle → AI_Coding. Updated root CLAUDE.md registry/routing, root _STATUS.md registry. Replaced all internal tags to AI_Coding. |
| R038 | 2026-04-08 | Strengthened content indexing completion rule. Hub `.sync/_tools/cli/post_note_edit_review.ps1` now runs indexer in separate PowerShell process for stable success detection. Root `.codex/skills/create-video-note`, `create-article-note`, `create-pdf-note` now require `POST_EDIT_INDEX_UPDATED=1` check and document manual fallback. |
| R037 | 2026-04-08 | Strengthened content indexing rules. Added post-edit indexing requirement (`POST_EDIT_INDEX_UPDATED=1`) to `post-edit-review.md`. Updated `/reindex` skill path to match `.sync/_tools/cli/` structure. |
| R036 | 2026-04-08 | Added Codex-specific source note pipeline. Created root `.codex/skills/create-article-note/`, `.codex/skills/create-pdf-note/`. Extended `.codex/skills/create-video-note/` to the same standard. |
| R035 | 2026-04-06 | Promoted `/open-notes` skill from custom/ to core/. Added 3-stage safety (active vault detection, path conversion, file existence check). Registered in MANIFEST. |
| R034 | 2026-04-06 | New `AGENT_ONBOARDING.md` — universal agent onboarding doc. Environment overview, condensed 14 core rules, rule-file path references. |
| R033 | 2026-04-06 | Removed Juggl_StyleGuide from `distribution-sync.md`, switched `juggl-style-sync.md` to per-vault management. Renamed all vault `docs/` → `.docs/`, removed `recent_files.txt`, moved `Juggl_StyleGuide/` into per-vault `Contents/`. |
| R032 | 2026-04-05 | New `/reindex` skill (`.claude/commands/core/reindex.md`) — rebuild content index for single/all vaults. Registered in MANIFEST. |
| R031 | 2026-04-05 | New `/open-notes` skill (`.claude/commands/custom/open-notes.md`) — open multiple notes in new tabs via local-rest-api. Registered in global CLAUDE.md skill list. |
| R030 | 2026-04-02 | `session-exit.md` — added rule to leave reference in root handoff when writing per-vault handoff. |
| R029 | 2026-04-01 | Split session handoff per agent. `_SESSION_HANDOFF.md` → `_SESSION_HANDOFF_CLAUDE.md` + `_SESSION_HANDOFF_CODEX.md`. Updated `session-exit.md`, root `CLAUDE.md` entry protocol. |
| R028 | 2026-04-01 | Created a new game project vault. Added `Projects_Game` category. Updated root `AGENTS.md`, `CLAUDE.md`, `_STATUS.md`, `vault-individualization.md`. |
| R027 | 2026-04-01 | Created a new toolkit vault. Added registry/routing to root `AGENTS.md`, `CLAUDE.md`, `_STATUS.md`. |
| R026 | 2026-04-01 | `note-writing.md` — clarified frontmatter `agent` field: cumulative record of all agents who worked on the note, not just the latest. |
| R025 | 2026-03-23 | New vault-individualization rule (`.claude/rules/core/vault-individualization.md`) — standardizes name/category/CLAUDE.md/tags at vault creation. |
| R024 | 2026-03-23 | New multi-vault personalization rule (`.claude/rules/custom/multivault-personalization.md`) — custom agent/plugin/skill settings. |
| R023 | 2026-03-21 | Added Personal category with a diary vault. Added to root CLAUDE.md, _STATUS.md. Added routing keywords. |
| R022 | 2026-03-21 | Introduced session handoff system. New root `_SESSION_HANDOFF.md`, added handoff writing rules to `session-exit.md`, added handoff reading to root `CLAUDE.md` entry protocol. |
| R021 | 2026-03-21 | Created 2 new vaults: `Vaults/Domains_Infra/AI`, `Vaults/Projects_Infra/<YourInfraProject>` — preparation for AIHubVault content separation. |
| R020 | 2026-03-21 | Added mandatory wiki-link rule to `note-writing.md` — new notes must contain at least one `[[WikiLink]]` to related notes in the same vault. |
| R019 | 2026-03-21 | Added H1 title rule to `note-writing.md` — URI-reserved characters and emoji forbidden (mandatory). Added emoji ban to filenames. |
| R018 | 2026-03-21 | Created `Vaults/Domains_Infra/Search/`. Search engine / indexing / text-matching domain knowledge hub. |
| R017 | 2026-03-21 | Created `Vaults/Domains_Infra/CICD/`. CI/CD and distribution sync domain knowledge hub. |
| R016 | 2026-03-21 | Migrated to Codex desktop app. Created root + 11-vault `AGENTS.md` (2-stage routing + execution structure). Converted playbooks → `.codex/skills/` SKILL.md format. Moved `.antigravity/workflows/` → `.codex/skills/`. New `agent-ownership.md` conflict prevention rule. Marked legacy CODEX.md, .antigravity as deprecated. |
| R015 | 2026-03-19 | New `.claude/rules/vault-routing.md`: mandatory vault routing rule. Bans direct work in BasicContentsVault, mandates vault registry check before content placement. |
| R014 | 2026-03-19 | Switched agent rules to single-source references. Deleted 8 duplicated rules from Cursor/Codex/Antigravity → reference `.claude/rules/` with agent-specific `agent-rules` files. Added single-source references to Codex/Antigravity entry points inside AIHubVault. |
| R013 | 2026-03-19 | Redesigned root `_STATUS.md` as lightweight registry (removed Now/Next/Blocked → vault type + content + working agent date). Updated `session-exit.md` root-update rule. Registered all 11 vaults. |
| R012 | 2026-03-18 | Created a new Lab vault. Added Lab category (Domain+Project hybrid). Added Labs section to root CLAUDE.md. |
| R011 | 2026-03-18 | New `.claude/commands/auto-organize.md`: auto folder-classification skill on note/vault creation. AI proposal → user approval. |
| R010 | 2026-03-18 | Created a new infra-domain vault. Added registry entry to root CLAUDE.md + _STATUS.md. |
| R009 | 2026-03-18 | New `.claude/commands/create-vault.md`: vault creation skill. BasicContentsVault-based clone + follow-up process definition. |
| R008 | 2026-03-18 | `note-writing.md` — banned metaphorical/figurative expressions. Task names and titles describe content directly. |
| R007 | 2026-03-17 | `juggl-style-sync.md` — clarified Juggl `local:` value uses filename (not H1 title). |
| R006 | 2026-03-17 | `note-writing.md` — added markdown bold + parentheses rendering rule. `**text(paren)**` pattern banned. |
| R005 | 2026-03-17 | New `README.md`: multi-vault system overview, AI rule system, quick start guide (git distribution entry point). |
| R004 | 2026-03-17 | New `.claude/rules/token-optimization.md`: mandatory token-saving and execution-delegation rule. |
| R003 | 2026-03-17 | Added mandatory `_ROOT_VERSION.md` recording rule for root-level edits to `edit-mode-separation.md`. |
| R002 | 2026-03-17 | 3 new `.claude/rules/`: temp-file-management, distribution-sync, script-creation-approval. |
| R001 | 2026-03-17 | 2 new `.antigravity/workflows/`: create-video-note, sync-distribution. |
