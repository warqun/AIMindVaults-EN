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
> Sync is determined by comparing the top version in this file with the top version in AIHubVault.
> Development history: See AIHubVault `_WORKSPACE_CHANGELOG.md` (Hub only, not distributed).

| Version      | Change Description |
| ------------ | ----- |
| 202604130013 | Full PS1 removal + rules migrated to Node.js CLI. standards command added. Script_Registry fully reorganized for Node.js |
| 202604130012 | Shell Commands: pre_sync.ps1 -> node cli.js pre-sync transition. Full cross-platform CLI migration complete |
| 202604130011 | cli-node Phase 6: 4 auxiliary tools ported (trash-clean, open-vault, obsidian-bridge, task-router). Full migration complete |
| 202604130010 | cli-node Phase 5: clone-vault, hub-broadcast ported. aimv clone/broadcast commands registered |
| 202604130009 | cli-node Phase 4: sync engine ported (sync-workspace, pre-sync). noPrune option added to fs-mirror. aimv sync/pre-sync commands registered |
| 202604130008 | cli-node Phase 3: post-edit-review ported (UTF-8 verification + auto indexer invocation). aimv review command registered |
| 202604130007 | cli-node Phase 2: 4 indexer commands ported (index-build, index-search, master-index-build, master-index-search). index subcommand registered in bin/cli.js |
| 202604130006 | cli-node Phase 0+1: Node.js CLI scaffolding + lib utilities (vault-path, config, fs-mirror, frontmatter, logger). commander + gray-matter dependencies |
| 202604130005 | nul junk files deleted from Hub + all satellite vaults |
| 202604130004 | master_index_build.ps1 Resolve-Path trailing backslash bug fix (TrimEnd added). vault_index_build.ps1 excludeFiles: README.md added (previously unrecorded) |
| 202604130003 | master_index_build.ps1, master_index_search.ps1 new. Cross-vault search across 22 vaults and 974 notes. Partial update auto-invocation added to vault_index_build.ps1 |
| 202604130002 | Indexer output path moved from .sync\_tools\data\ to .vault_data\. Per-vault artifacts separated outside sync folder to fundamentally prevent Hub contamination. Path changes in vault_index_build/search/post_note_edit_review. sync_workspace.ps1 ExcludeDirs workaround removed |
| 202604130001 | ExcludeDirs parameter added to sync_workspace.ps1. _tools\data\ folder excluded from Hub sync targets to prevent satellite vault vault_index.json contamination (-> replaced by fundamental fix in 202604130002) |
| 202604090003 | pre_sync.ps1 Hub detection marker changed from _forge to .sync/.hub_marker. Fixed bug where self-reference exception didn't work when opening Obsidian in Hub |
| 202604090002 | vault_trash_clean.ps1 new — vault .trash/ batch cleanup CLI (single/multiple/all, DryRun). Registered in Script_Registry |
| 202604090001 | obsidian_ai_bridge.ps1, open_vault.ps1 hardcoded paths (..\..\) replaced with candidate auto-detection system. open_vault's pre_sync.ps1 reference also updated to .sync/-based candidates. Candidate logic explanation comments added to 3 previously fixed scripts |
| 202604080003 | sync_workspace.ps1 auto-execution registered in Shell Commands plugin (Obsidian startup event). obsidian-shellcommands added to coreForceDataJson for forced settings propagation |
| 202604080002 | Content indexing completion check reinforced — `.sync/_tools/cli/post_note_edit_review.ps1` runs `vault_index_build.ps1` in separate PowerShell process for reliable exit code evaluation. `POST_EDIT_INDEX_UPDATED=1` confirmation added as completion condition to 3 Codex note skills |
| 202604080001 | Content indexer path auto-detection fix — Connected post_note_edit_review, vault_index_build/search based on `.sync/_tools/cli/`. Post-edit indexing mandatory rule applied |
| 202604060003 | _WORKSPACE_VERSION.md restored from .sync/ to vault root (Obsidian visibility needed), sync path references updated |
| 202604060002 | Hub identification marker changed from _forge to .sync/.hub_marker, _forge renamed to .forge (all vaults), reference paths updated |
| 202604060001 | .sync/ folder structure reorganization — sync_workspace.ps1 folder mirroring refactored, pre_sync.ps1 paths updated, batch arrays removed, dot-prefix auto-hiding |
| 202604050001 | Auto indexer incremental build invocation added to post_note_edit_review.ps1 (Feature A) |
| 202604010001 | TileMapToolKit vault initial individualization — entry point/status/index/tag rules aligned, `Contents/` structure initialized |
| 202603230004 | Core plugin data.json selective forcing — Linter only forced, local-rest-api preserved due to sensitive data (API keys/certificates) |
| 202603230003 | sync_workspace.ps1 plugin Core/Custom separation — 4 Core plugins (local-rest-api, dataview, templater, linter) forced sync, rest as Custom |
| 202603230002 | sync_workspace.ps1 batch Core/Custom separation — Juggl_StyleGuide moved to Custom, _VAULT-INDEX.md sync removed |
| 202603230001 | Linter plugin activated — frontmatter key sorting, updated auto-refresh, auto-lint on save |
| 202603210015 | sync_workspace.ps1 Invoke-ObsidianReload cooldown added — prevent infinite reload loop (60 seconds) |
| 202603210014 | vault_index_build.ps1, vault_index_search.ps1 new — vault content indexer + search engine |
| 202603210013 | pre_sync trampoline pattern, Obsidian auto-reload, community-plugins.json merge |
