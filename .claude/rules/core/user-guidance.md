# User Guidance — High-Risk Self-Correction (Mandatory · Always Injected)

> Only the high-risk sections — where the agent must **block immediately when it detects the user attempting an incorrect step or skipping a procedure during use of a core feature** — are kept inline.
> Low-risk triggers and the detailed guidance are read on demand via `_skill-router.md` from `.claude/rules-archive/user-guidance-detail.md`.

## Common Principles

- **Block on detection**: high-risk triggers stop the work the moment the violation is detected and provide guidance.
- **Guide, do not just block**: state the correct method and let the user choose.
- **Once only**: do not repeat the same guidance in a single session.
- **Self-correct**: applies equally to the agent's own incorrect attempts.

## High-Risk Triggers (inline immediate-block)

### §2 Vault Creation — Manual-Copy Attempt

**Detection**: an attempt to copy a vault folder via `Copy-Item`, `cp`, `xcopy`, `robocopy`.

**Immediate guidance**:
> Use the `/create-vault` skill or `node cli.js clone`. Manual copies pollute `.git`, caches, and per-device plug-in settings, and trigger make-md `systemName` collisions.

**Mandatory follow-ups (block on omission, too)**:
- Register the vault in the root `_STATUS.md` registry
- Individualize the CLAUDE.md (role, collection scope, tag rule)
- Register the vault directly in the Obsidian vault manager

Detail: `rules-archive/user-guidance-detail.md § 2` + `rules-archive/vault-individualization.md`

### §4 Edit-Mode Confusion

**Detection**: a single task that simultaneously edits `Contents/**` files and workspace files (`.sync/`, `.claude/`, `.obsidian/`, vault root).

**Immediate guidance**:
> A single task is `[Contents]` or `[workspace]`, not both. Workspace edits happen only in the AIHubVault. Declare any mode switch.

Detail: `_essentials.md § 4`

### §5 Workspace Sync — Missing Version Record (2026-03-21 incident)

**Detection**:
- Editing `.sync/` / `.obsidian/` directly in a vault other than the AIHubVault
- Proceeding to follow-up work right after a workspace edit without recording in `_WORKSPACE_VERSION.md`

**Immediate guidance**: workspace is AIHubVault-only · before recording `_WORKSPACE_VERSION.md` right after the edit, do not run any follow-up.

Detail: `_essentials.md § 4` + `rules-archive/sync-version-priority.md`

### §8 Post-Edit Verification — BAD/INDEX Unchecked (2026-04-13 incident)

**Detection**: reporting completion without running `node cli.js review` / without confirming `POST_EDIT_REVIEW_BAD=0` · `POST_EDIT_INDEX_UPDATED=1`.

**Immediate guidance**: a note edit is finished only when review passes and indexing completes. Procedure / commands: see `_essentials.md § 5`.

### §10 Infinite-Recursion Path Deletion

**Detection**: attempting deep recursive-folder deletion via `Remove-Item -Recurse`, `rd /s /q`, `7z d`, `[System.IO.Directory]::Delete()`.

**Immediate guidance**:
> All those tools fail at the Windows MAX_PATH (260-char) limit. Use PowerShell flatten-and-delete first, then a robocopy mirror loop as the second option.

Detail: `core/temp-file-management.md § Infinite-Recursion Path Deletion (Incident Rule)`

### §11 Script Creation — Missing Pre-Approval

**Detection**: the agent attempts to create or run a `.ps1` / `.py` / `.bat` / `.sh` without user approval.

**Immediate guidance**:
> Pre-creation report is required: 1) purpose, 2) path, 3) impact scope, 4) one-shot / persistent. Do not create without report + approval. Also check `Script_Registry.md` for duplicates.

Detail: `core/script-creation-approval.md` + `core/script-management.md`

## Low-Risk Triggers → Skill Router Delegation

The "User guidance" row in `_skill-router.md` handles the following → reads `rules-archive/user-guidance-detail.md`:

- §1 Opening a new vault in Obsidian (URI vs vault manager)
- §3 Note routing (which vault to put a note in)
- §6 Plug-in install / settings
- §7 Session-end routine
- §9 Content search (indexer first — summary in `_essentials.md § 2`)
- §12 Distribution sync (SellingVault, git push)

## References

- Full 12-section detail: `.claude/rules-archive/user-guidance-detail.md`
- Original Type A / B / C trigger taxonomy: at the top of the same archive file
