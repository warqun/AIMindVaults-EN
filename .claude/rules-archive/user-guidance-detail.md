# User Guidance (Mandatory)

> Applies to all vaults. All agents.
> When a user gets stuck on a core AIMindVaults feature or attempts the wrong approach, the agent consults this guide to steer them.

---

## Trigger System

This guide fires on three trigger types.

### Type A: User-Question Trigger

Fires when the user directly asks about procedure or method.

**Detection keywords**: "how to", "what should I", "how do I", "I don't know", "I forgot", "procedure", "what's next", "steps".

### Type B: Wrong-Attempt Trigger

Fires **preemptively** when the agent notices that the user's request — or the agent's own planned action — violates a rule.

| Condition | Section |
|-----------|---------|
| Using `obsidian://open?path=` on an unregistered vault | §1 |
| Copying a vault folder with `Copy-Item`, `cp`, `xcopy` | §2 |
| Writing content into BasicContentsVault | §3 |
| Editing Contents files and workspace files in one task | §4 |
| Editing `.sync/` or `.obsidian/` from a non-Hub vault | §5, §6 |
| Skipping `post_note_edit_review` after editing a note | §8 |
| Scanning the whole vault with Grep/Glob without the indexer | §9 |
| Deleting a deep recursive folder with `Remove-Item -Recurse` | §10 |
| Creating a script without user approval | §11 |

### Type C: Missing-Step Trigger

Fires when a mandatory step was skipped. The agent detects this automatically during task flow.

| Condition | Section |
|-----------|---------|
| Vault created but not added to the root registry | §2 |
| Vault created but CLAUDE.md not individualized | §2 |
| Vault created but Obsidian registration not mentioned | §1, §2 |
| Session ending without updating `_STATUS.md` or handoff | §7 |
| Note edited but indexing incomplete (`POST_EDIT_INDEX_UPDATED` not checked) | §8 |
| Workspace edited but no entry in `_WORKSPACE_VERSION.md` | §5, §6 |
| Core rule changed but no entry in `_ROOT_VERSION.md` | §12 |

---

## Guidance Principles

- **Concise**: deliver only the minimum information needed for the situation. Do not recite the full rule.
- **Once only**: do not repeat the same guidance inside one session. Once the user agrees, handle subsequent occurrences silently.
- **Guide, don't block**: never halt the user's work. Show the correct way and let them choose.
- **Self-correction included**: when the agent itself is about to take the wrong action, use this guide to correct itself.

---

## 1. Opening a New Vault in Obsidian

### Triggers
- **B**: agent about to call `obsidian://open?path=` on an unregistered vault.
- **A**: "how do I open a new vault?", "register in Obsidian".

### Guidance
> Obsidian Vault Manager → "Open folder as vault" → select the vault path.

- `obsidian://open?path=` on an unregistered vault triggers app-state switch + registration + plugin load simultaneously — very slow.
- The URI is only for **switching between already-registered vaults** (`obsidian://open?vault=name`).
- Agents must not use `obsidian://open?path=` on unregistered vaults either.

---

## 2. Creating a Vault

### Triggers
- **B**: trying to create a vault by manually copying folders.
- **A**: "where do I create the vault?", "what do I do after creating a vault?"
- **C**: after creation, any of registry/CLAUDE.md/Obsidian steps missing.

### Guidance
- **Method**: use the `/create-vault` skill or `node cli.js clone`. No manual copy.
- **Location**: pick the right category (`Domains_<area>`, `Projects_<area>`, `Lab_<area>`, `Personal`) for the purpose.
- **Mandatory after creation**: individualize CLAUDE.md, initialize _STATUS.md, add to root registry, register in Obsidian (via the Vault Manager directly).

---

## 3. Which Vault Does This Note Belong To

### Triggers
- **A**: "where does this go?", "which vault?"
- **B**: attempting to write content into BasicContentsVault.

### Guidance
- Show the categorized vault list from `_STATUS.md`'s vault registry.
- Recommend a fit based on keywords (see root CLAUDE.md routing rules).
- If nothing fits, propose creating a new vault.
- Do not drop content into BasicContentsVault (clone template only).

---

## 4. Edit-Mode Confusion

### Triggers
- **B**: trying to edit Contents files and workspace files in the same task.
- **A**: "can I edit this file?", "what's the difference between Contents and workspace?"

### Guidance
- `Contents/**` = Contents mode. Note authoring/editing.
- `.sync/`, `.claude/`, vault root files = Workspace mode. Edit only in AIHubVault.
- Do not mix modes in one task. Declare the mode when switching.
- Phrase it as: "This file is a workspace edit, so it needs to happen in AIHubVault."

---

## 5. Workspace Sync

### Triggers
- **B**: editing `.sync/` files directly in a non-Hub vault.
- **A**: "did the sync not run?", "the versions don't match".
- **C**: workspace edited but `_WORKSPACE_VERSION.md` not updated.

### Guidance
- Workspace edits only in AIHubVault. Other vaults receive them automatically via sync.
- Compare `_WORKSPACE_VERSION.md` versions; if they differ, run sync.
- Sync execution: opening the vault in Obsidian runs it automatically. Manual: `node cli.js pre-sync`.

---

## 6. Plugin Install / Config

### Triggers
- **B**: editing `.obsidian/` in a non-Hub vault.
- **A**: "install this plugin", "I changed the setting but it didn't apply to the other vault".

### Guidance
- Plugin install / config changes happen in AIHubVault → propagated by sync.
- Prefer the `/install-plugin` skill.
- `.obsidian/` edits are Workspace mode. `_WORKSPACE_VERSION.md` entry required.

---

## 7. Session Exit

### Triggers
- **A**: "done", "wrap up", "close out".
- **C**: any of _STATUS.md / handoff / root _STATUS.md missing at session end.

### Guidance
- `/vault-update` skill runs the session-exit routine automatically.
- Manual: update all three — vault `_STATUS.md`, root `_STATUS.md`, `_SESSION_HANDOFF_{agent}.md`.
- Missing any one = session exit incomplete.

---

## 8. Post-Edit Validation

### Triggers
- **C**: after note edit, `post_note_edit_review` not run, or indexing incomplete.
- **A**: "how do I review?", "BAD is not 0".

### Guidance
- Run `node cli.js review` after editing notes.
- If BAD is not 0, fix the offending file (missing frontmatter, encoding, etc.).
- Work is complete only after indexing (`POST_EDIT_INDEX_UPDATED=1`) is confirmed.
- If indexing fails: `node cli.js index build -r {vault-path} -i` manually.

---

## 9. Content Search

### Triggers
- **B**: scanning the whole vault with Grep/Glob without the indexer.
- **A**: "where is the note?", "I want to find it".

### Guidance
- **Indexer first**: `node cli.js index search -q "query"`.
- Fall back to Grep/Glob only when the indexer returns nothing.
- If the index looks stale, run `/reindex`.

---

## 10. Infinite-Recursion Path Deletion

### Triggers
- **B**: trying `Remove-Item -Recurse`, `rd /s /q`, `7z d` on a deep recursive folder.
- **A**: "it won't delete", "the path is too long".

### Guidance
- Full procedure: `temp-file-management.md` § "Infinite-Recursion Path Deletion (Incident Rule)".
- 1st choice: PowerShell flatten-and-delete.
- 2nd choice: repeated robocopy mirror.
- 7z, Remove-Item, rd, .NET Delete all fail.

---

## 11. Script Creation

### Triggers
- **B**: agent about to create a script without user approval.
- **C**: `Script_Registry.md` duplicate check skipped.

### Guidance
- Always get user approval before creating a script. Report purpose, path, and impact scope.
- Check `Script_Registry.md` for duplicates. If an existing script can be extended, don't create a new one.

---

## 12. Distribution Sync

### Triggers
- **A**: "how do I deploy?", "what is SellingVault?"
- **C**: core rule changed but `_ROOT_VERSION.md` not updated.

### Guidance
- Core rule/skill changes are distribution targets. Log them in `_ROOT_VERSION.md`.
- Distribution path: SellingVault (`C:\SellingVault\English\AIMindVaults` for EN, `C:\SellingVault\Korean\AIMindVaults` for KO).
- Deploy + git push only when the user explicitly requests it.
