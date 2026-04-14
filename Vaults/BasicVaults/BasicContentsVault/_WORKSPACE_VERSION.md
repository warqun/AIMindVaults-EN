---
type: workspace-version
tags:
  - AIMindVault
  - TileMapToolKit
  - Meta
updated: 2026-04-13
---

# Workspace Version

> Version number for sync determination. Format: `YYYYMMDDNNNN` (date + daily sequence number).
> Compare the top version in this file with the top version in AIHubVault to determine sync status.
> Development history: See AIHubVault `_WORKSPACE_CHANGELOG.md` (Hub-only, not included in distribution).

| Version      | Changes |
| ------------ | ------- |
| 202604130013 | Full PS1 removal + rules migrated to Node.js CLI. Added standards command. Script_Registry fully revised to Node.js basis |
| 202604130012 | Shell Commands: pre_sync.ps1 -> node cli.js pre-sync migration. Full cross-platform CLI transition |
| 202604130011 | cli-node Phase 6: Ported 4 auxiliary tools (trash-clean, open-vault, obsidian-bridge, task-router). Full migration complete |
| 202604130010 | cli-node Phase 5: Ported clone-vault, hub-broadcast. Registered aimv clone/broadcast commands |
| 202604130009 | cli-node Phase 4: Ported sync engine (sync-workspace, pre-sync). Added noPrune option to fs-mirror. Registered aimv sync/pre-sync commands |
| 202604130008 | cli-node Phase 3: Ported post-edit-review (UTF-8 validation + auto indexer call). Registered aimv review command |
| 202604130007 | cli-node Phase 2: Ported 4 indexer commands (index-build, index-search, master-index-build, master-index-search). Registered index subcommand in bin/cli.js |
| 202604130006 | cli-node Phase 0+1: Node.js CLI scaffolding + lib utilities (vault-path, config, fs-mirror, frontmatter, logger). commander + gray-matter dependencies |
| 202604130005 | Removed nul junk files from Hub + all satellite vaults |
| 202604130004 | Fixed master_index_build.ps1 Resolve-Path trailing backslash bug (added TrimEnd). Added README.md to vault_index_build.ps1 excludeFiles (previously unrecorded) |
| 202604130003 | New master_index_build.ps1, master_index_search.ps1. Cross-vault search support for 22 vaults, 974 notes. Added incremental rebuild auto-call to vault_index_build.ps1 |
| 202604130002 | Moved indexer output path from .sync\_tools\data\ to .vault_data\. Separated per-vault artifacts outside sync folder to fundamentally prevent Hub contamination. Updated paths in vault_index_build/search/post_note_edit_review scripts |
| 202604130001 | Added ExcludeDirs parameter to sync_workspace.ps1. Set _tools\data\ folder as Hub sync exclusion to prevent vault_index.json contamination (superseded by 202604130002 root fix) |
| 202604090003 | Fixed pre_sync.ps1 Hub detection marker from _forge to .sync/.hub_marker. Fixed self-reference exception not working when opening Obsidian on Hub |
| 202604090002 | New vault_trash_clean.ps1 — Vault .trash/ batch cleanup CLI (single/multiple/all, DryRun). Registered in Script_Registry |
| 202604090001 | Applied candidate auto-detection system to obsidian_ai_bridge.ps1, open_vault.ps1 (replacing hardcoded ..\..\). Updated open_vault pre_sync.ps1 reference to .sync/-based candidate. Added candidate logic explanation comments to 3 previously updated scripts |
| 202604080003 | Registered sync_workspace.ps1 auto-execution in Shell Commands plugin (Obsidian startup event). Added obsidian-shellcommands to coreForceDataJson for forced settings propagation |
| 202604080002 | Enhanced content indexing completion check — `.sync/_tools/cli/post_note_edit_review.ps1` runs `vault_index_build.ps1` in separate PowerShell process for reliable exit code detection, added `POST_EDIT_INDEX_UPDATED=1` as completion condition to 3 Codex note skills |
| 202604080001 | Fixed content indexer path auto-detection — Restored post_note_edit_review, vault_index_build/search connections based on `.sync/_tools/cli/`. Applied mandatory indexing after note add/edit rule |
| 202604060003 | Restored _WORKSPACE_VERSION.md from .sync/ to vault root (Obsidian visibility needed), updated sync path references |
| 202604060002 | Changed Hub identification marker from _forge to .sync/.hub_marker, renamed _forge to .forge (all vaults), updated reference paths |
| 202604060001 | Restructured .sync/ folder — Refactored sync_workspace.ps1 folder mirroring, updated pre_sync.ps1 paths, removed batch arrays, dot-prefix auto-hide |
| 202604050001 | Added indexer incremental build auto-call to post_note_edit_review.ps1 (Feature A) |
| 202604010001 | TileMapToolKit vault initial individualization — Aligned entry points/status/index/tag rules, initialized `Contents/` structure |
| 202603230004 | Selective force for Core plugin data.json — Only Linter forced, local-rest-api preserved due to sensitive data (API keys/certs) |
| 202603230003 | sync_workspace.ps1 plugin Core/Custom separation — Core 4 (local-rest-api, dataview, templater, linter) forced sync, rest Custom |
| 202603230002 | sync_workspace.ps1 batch Core/Custom separation — Moved Juggl_StyleGuide to Custom, removed _VAULT-INDEX.md sync |
| 202603230001 | Enabled Linter plugin — Frontmatter key sorting, auto updated field refresh, auto-lint on save |
| 202603210015 | Added Invoke-ObsidianReload cooldown to sync_workspace.ps1 — Prevents reload infinite loop (60 seconds) |
| 202603210014 | New vault_index_build.ps1, vault_index_search.ps1 — Vault content indexer + search engine |
| 202603210013 | pre_sync trampoline pattern, Obsidian auto-reload, community-plugins.json merge |
