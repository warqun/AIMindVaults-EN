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

> Inventory tracking the purpose, owner, and status of every script in the vault.
> Agents must update this document when creating, deleting, or modifying scripts.

---

## Active scripts — Node.js CLI

On 2026-04-13 the full PS1 → Node.js migration completed. All CLI tooling lives under `.sync/_tools/cli-node/`.

| Command | File | Purpose | Owner |
|---------|------|---------|-------|
| `aimv index build` | `src/commands/index-build.js` | Vault content indexer — crawl Contents/ → produce JSON index | claude |
| `aimv index search` | `src/commands/index-search.js` | Vault content search — keyword/tag/type search over the JSON index | claude |
| `aimv index master-build` | `src/commands/master-index-build.js` | Build the cross-vault master index | claude |
| `aimv index master-search` | `src/commands/master-index-search.js` | Search the cross-vault master index | claude |
| `aimv review` | `src/commands/post-edit-review.js` | After-edit UTF-8 + frontmatter validation, with auto-indexing | claude |
| `aimv sync` | `src/commands/sync-workspace.js` | Workspace sync between vaults (Hub-Sync) | claude |
| `aimv pre-sync` | `src/commands/pre-sync.js` | Trampoline: auto-refresh cli-node, then run sync | claude |
| `aimv clone` | `src/commands/clone-vault.js` | Clone a vault (from BasicContentsVault) | claude |
| `aimv broadcast` | `src/commands/hub-broadcast.js` | Push Hub `.sync/` files to all satellite vaults | claude |
| `aimv trash-clean` | `src/commands/trash-clean.js` | Bulk-clean vault `.trash/` folders | claude |
| `aimv open` | `src/commands/open-vault.js` | pre-sync, then open the vault in Obsidian | claude |
| `aimv bridge` | `src/commands/obsidian-bridge.js` | Obsidian CLI wrapper (lookup/search/history/post-review) | claude |
| `aimv route` | `src/commands/task-router.js` | Suggest an agent route from a task description | claude |
| `aimv standards` | `src/commands/check-standards.js` | Verify the `_Standards/` directory structure | claude |

### Shared libraries

| File | Purpose |
|------|---------|
| `src/lib/vault-path.js` | Auto-detect the vault / AIMindVaults root |
| `src/lib/frontmatter.js` | YAML frontmatter parser |
| `src/lib/fs-mirror.js` | Directory mirroring (sync engine) |
| `src/lib/config.js` | Configuration constants |
| `src/lib/logger.js` | Log output |

---

## One-time / completed scripts

Scripts created for a specific migration or fix and not reused.

| Script | Location | Purpose | Owner | Notes |
|--------|----------|---------|-------|-------|
| `fix_false_positives.ps1` | `.forge/staging/` | Fix false positives from an earlier rename script | codex | Done |
| `rename_env_prefix.ps1` | `.forge/staging/` | Rename environment-prefix tokens | codex | Staging script |

---

## Deleted scripts

| Script | Deleted | Reason |
|--------|---------|--------|
| `post_note_edit_review.ps1` | 2026-04-13 | Replaced by the Node.js CLI `aimv review` |
| `obsidian_ai_bridge.ps1` | 2026-04-13 | Replaced by the Node.js CLI `aimv bridge` |
| `task_router.ps1` | 2026-04-13 | Replaced by the Node.js CLI `aimv route` |
| `sync_workspace.ps1` | 2026-04-13 | Replaced by the Node.js CLI `aimv sync` |
| `pre_sync.ps1` | 2026-04-13 | Replaced by the Node.js CLI `aimv pre-sync` |
| `vault_index_build.ps1` | 2026-04-13 | Replaced by the Node.js CLI `aimv index build` |
| `vault_index_search.ps1` | 2026-04-13 | Replaced by the Node.js CLI `aimv index search` |
| `vault_trash_clean.ps1` | 2026-04-13 | Replaced by the Node.js CLI `aimv trash-clean` |
| `clone_vault.ps1` | 2026-04-13 | Replaced by the Node.js CLI `aimv clone` |
| `check_standards.ps1` | 2026-04-13 | Replaced by the Node.js CLI `aimv standards` |
| `verify_structure.ps1` | 2026-04-13 | Replaced by the Node.js CLI `aimv standards -d` |
| `init_vault.ps1` | 2026-03-10 | Hardcoded content folders, insufficient flexibility. Replaced by manual setup |
| `preflight_docs_encoding.ps1` | 2026-03-09 | Duplicated `post_note_edit_review.ps1` |
| `delegate-run.md` (skill) | 2026-03-09 | Delegation workflow abolished |
| `delegate-analyze.md` (skill) | 2026-03-09 | Delegation workflow abolished |
| `open_agents.ps1` | 2026-03-11 | Unnecessary — IDE only needs to open once from the multi-vault root |
| `create_domain.ps1` | 2026-03-17 | One-time; initial `_Standards/Domain/` creation complete |
| `migrate_standards.ps1` | 2026-03-17 | One-time; `_Standards/` restructure complete |
| `migrate_standards2.ps1` | 2026-03-17 | One-time; `_Standards/` sub-folder moves complete |
| `create_MakeCloneVault.bat` | 2026-03-17 | One-time; replaced by `clone_vault.ps1` |
| `GitMirrorSync_DecisionPoints.md` | 2026-03-17 | Git-mirror sync decision doc; no longer referenced |
| `RUN_OBSIDIAN_VAMSURLIKE.bat` | 2026-03-17 | Hardcoded absolute path, unfit for Hub distribution |

---

## Update rules

- Update this document whenever a script is created, deleted, or changes state.
- Detailed creation rules → [[Script_Creation_Rule]]
