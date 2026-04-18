# User Guidance — High-Risk Self-Correction (Mandatory · Always Loaded)

> Inline only the high-risk sections where agents **must stop and warn the moment a wrong attempt or missing step is detected** while the user exercises core features.
> Low-risk triggers and detailed guidance are loaded on-demand via `_skill-router.md` pointing to `.claude/rules-archive/user-guidance-detail.md`.

## Common Principles

- **Stop on detection**: For high-risk triggers, halt the task the instant a violation is seen and deliver the guidance.
- **Guidance, not blocking**: Present the correct method and let the user choose.
- **Once per session**: Do not repeat the same guidance in one session.
- **Self-correction**: The same rule applies to the agent's own faulty attempts.

## High-Risk Triggers (Inline Immediate Halt)

### §2 Vault Creation — Manual Copy Attempt

**Detect**: Attempts to copy a vault folder with `Copy-Item`, `cp`, `xcopy`, `robocopy`.

**Immediate guidance**:
> Use the `/create-vault` skill or `node cli.js clone`. Manual copy corrupts `.git`/caches/device-specific plugin state and causes make-md systemName collisions.

**Required follow-up (also halt if missing)**:
- Register in root `_STATUS.md` registry
- Individualize CLAUDE.md (role, scope, tag rules)
- Register directly in Obsidian's vault manager

Detail: `rules-archive/user-guidance-detail.md § 2` + `rules-archive/vault-individualization.md`

### §4 Edit Mode Confusion

**Detect**: A single task touching both `Contents/**` files and workspace files (`.sync/`, `.claude/`, `.obsidian/`, vault root) simultaneously.

**Immediate guidance**:
> One task = one of `[Contents]` or `[workspace]`. Workspace edits run only in AIHubVault. Declare the mode switch when changing.

Detail: `_essentials.md § 4`

### §5 Workspace Sync — Missing Version Log (incident 2026-03-21)

**Detect**:
- Direct edits to `.sync/` / `.obsidian/` in a vault other than AIHubVault
- Continuing further work right after a workspace edit without writing to `_WORKSPACE_VERSION.md`

**Immediate guidance**: Workspace is AIHubVault-only · no follow-up work before `_WORKSPACE_VERSION.md` is updated.

Detail: `_essentials.md § 4` + `rules-archive/sync-version-priority.md`

### §8 Post-Edit Review — BAD/INDEX Not Confirmed (incident 2026-04-13)

**Detect**: Reporting completion without running `node cli.js review`, or without confirming `POST_EDIT_REVIEW_BAD=0` and `POST_EDIT_INDEX_UPDATED=1`.

**Immediate guidance**: A note edit is done only after review passes and indexing completes. Commands and procedure: `_essentials.md § 5`.

### §10 Infinite Recursion Path Deletion

**Detect**: Attempting deep recursive folder deletion with `Remove-Item -Recurse`, `rd /s /q`, `7z d`, `[System.IO.Directory]::Delete()`.

**Immediate guidance**:
> All of the above fail against the Windows MAX_PATH (260) limit. Use primary PowerShell flatten-and-delete, then fall back to repeated robocopy mirror.

Detail: `core/temp-file-management.md § Infinite Recursion Path Deletion (Incident Rule)`

### §11 Script Creation — Missing Prior Approval

**Detect**: Agent creates or runs `.ps1` / `.py` / `.bat` / `.sh` without user approval.

**Immediate guidance**:
> Required report before creation: 1) purpose, 2) path, 3) scope of impact, 4) one-off vs permanent. No creation without approval + report. Cross-check `Script_Registry.md` for duplicates.

Detail: `core/script-creation-approval.md` + `core/script-management.md`

## Low-Risk Triggers → Delegated to Skill Router

The "user guidance" row in `_skill-router.md` handles the following via `rules-archive/user-guidance-detail.md`:

- §1 Opening a new vault in Obsidian (URI vs vault manager)
- §3 Note routing (which vault to place a note in)
- §6 Plugin install / configuration
- §7 Session exit routine
- §9 Content search (indexer-first — summary in `_essentials.md § 2`)
- §12 Distribution sync (SellingVault, git push)

## References

- Full 12-section detail: `.claude/rules-archive/user-guidance-detail.md`
- Trigger taxonomy (Type A/B/C): same archive file header
