---
type: standards
tags:
  - TileMapToolKit
  - Standards
  - AIMindVault
  - script-management
updated: 2026-04-13
agent: claude
---

# Script Registry

> Inventory managing the purpose, owner, and status of all scripts in the vault.
> Agents must update this document when creating, deleting, or modifying scripts.

---

## Active Scripts — Node.js CLI

2026-04-13: Full migration from PS1 to Node.js complete. All CLI tools are located under `.sync/_tools/cli-node/`.

| Command | File | Purpose | Creator |
|---------|------|---------|---------|
| `aimv index build` | `src/commands/index-build.js` | Vault content indexer — crawls Contents/ and generates JSON index | claude |
| `aimv index search` | `src/commands/index-search.js` | Vault content search — keyword/tag/type search based on JSON index | claude |
| `aimv index master-build` | `src/commands/master-index-build.js` | Cross-vault master index build | claude |
| `aimv index master-search` | `src/commands/master-index-search.js` | Cross-vault master index search | claude |
| `aimv review` | `src/commands/post-edit-review.js` | Post-edit UTF-8 and frontmatter verification + auto-indexing | claude |
| `aimv sync` | `src/commands/sync-workspace.js` | Workspace synchronization between vaults (Hub-Sync) | claude |
| `aimv pre-sync` | `src/commands/pre-sync.js` | Trampoline: auto-update cli-node + run sync | claude |
| `aimv clone` | `src/commands/clone-vault.js` | Vault clone (based on BasicContentsVault) | claude |
| `aimv broadcast` | `src/commands/hub-broadcast.js` | Broadcast Hub .sync/ files to all satellite vaults | claude |
| `aimv trash-clean` | `src/commands/trash-clean.js` | Batch clean vault .trash/ | claude |
| `aimv open` | `src/commands/open-vault.js` | Open Obsidian vault after pre-sync | claude |
| `aimv bridge` | `src/commands/obsidian-bridge.js` | Obsidian CLI wrapper (query/search/history/post-review) | claude |
| `aimv route` | `src/commands/task-router.js` | Task description to agent routing recommendation | claude |
| `aimv standards` | `src/commands/check-standards.js` | Verify `_Standards/` directory structure | claude |

### Shared Libraries

| File | Purpose |
|------|---------|
| `src/lib/vault-path.js` | Auto-detect vault/AIMindVaults root |
| `src/lib/frontmatter.js` | YAML frontmatter parser |
| `src/lib/fs-mirror.js` | Directory mirroring (sync engine) |
| `src/lib/config.js` | Configuration constants |
| `src/lib/logger.js` | Log output |

---

## One-time Scripts

Scripts created for specific migrations or fixes, not intended for reuse.

| Script | Location | Purpose | Creator | Notes |
|--------|----------|---------|---------|-------|
| `fix_false_positives.ps1` | `.forge/staging/` | Fix false positives from previous rename script | codex | Fix complete |
| `rename_env_prefix.ps1` | `.forge/staging/` | Environment prefix renaming | codex | Staging script |

---

## Deleted Scripts

| Script | Deleted | Reason |
|--------|---------|--------|
| `post_note_edit_review.ps1` | 2026-04-13 | Replaced by Node.js CLI `aimv review` |
| `obsidian_ai_bridge.ps1` | 2026-04-13 | Replaced by Node.js CLI `aimv bridge` |
| `task_router.ps1` | 2026-04-13 | Replaced by Node.js CLI `aimv route` |
| `sync_workspace.ps1` | 2026-04-13 | Replaced by Node.js CLI `aimv sync` |
| `pre_sync.ps1` | 2026-04-13 | Replaced by Node.js CLI `aimv pre-sync` |
| `vault_index_build.ps1` | 2026-04-13 | Replaced by Node.js CLI `aimv index build` |
| `vault_index_search.ps1` | 2026-04-13 | Replaced by Node.js CLI `aimv index search` |
| `vault_trash_clean.ps1` | 2026-04-13 | Replaced by Node.js CLI `aimv trash-clean` |
| `clone_vault.ps1` | 2026-04-13 | Replaced by Node.js CLI `aimv clone` |
| `check_standards.ps1` | 2026-04-13 | Replaced by Node.js CLI `aimv standards` |
| `verify_structure.ps1` | 2026-04-13 | Replaced by Node.js CLI `aimv standards -d` |
| `init_vault.ps1` | 2026-03-10 | Hardcoded content folders lacked flexibility. Replaced by manual user setup |
| `preflight_docs_encoding.ps1` | 2026-03-09 | Duplicate functionality with `post_note_edit_review.ps1` |
| `delegate-run.md` (skill) | 2026-03-09 | Delegation workflow deprecated |
| `delegate-analyze.md` (skill) | 2026-03-09 | Delegation workflow deprecated |
| `open_agents.ps1` | 2026-03-11 | Unnecessary since IDE only needs to be opened once from multi-vault root |
| `create_domain.ps1` | 2026-03-17 | One-time script, `_Standards/Domain/` initial creation complete |
| `migrate_standards.ps1` | 2026-03-17 | One-time, `_Standards/` restructuring complete |
| `migrate_standards2.ps1` | 2026-03-17 | One-time, `_Standards/` subfolder migration complete |
| `create_MakeCloneVault.bat` | 2026-03-17 | One-time, replaced by clone_vault.ps1 |
| `GitMirrorSync_DecisionPoints.md` | 2026-03-17 | Git mirror sync decision document, reference complete |
| `RUN_OBSIDIAN_VAMSURLIKE.bat` | 2026-03-17 | Hardcoded absolute paths, unsuitable for Hub distribution |

---

## Update Rules

- Update this document whenever scripts are created, deleted, or their status changes.
- Detailed creation rules: see [[Script_Creation_Rule]]
