# User Guidance (Mandatory)

> Applies uniformly to all vaults. Common to all agents.
> When users get stuck or attempt incorrect methods while using AIMindVaults core features, the agent references this guide to provide assistance.

---

## Trigger System

This guide is activated by three types of triggers.

### Type A: User Question Trigger

Activated when the user directly asks about a procedure or method.

**Detection keywords**: "how to", "what should I", "don't know", "forgot", "method", "procedure", "what's next"

### Type B: Incorrect Attempt Detection Trigger

Activated **proactively** when the agent detects that the user's request or the agent's own action violates a rule.

| Detection Condition | Relevant Section |
|---------------------|-----------------|
| Attempting to use `obsidian://open?path=` on an unregistered vault | §1 |
| Attempting to copy vault folders with `Copy-Item`, `cp`, `xcopy` | §2 |
| Attempting to write content in BasicContentsVault | §3 |
| Attempting to modify Contents files and workspace files simultaneously in one task | §4 |
| Attempting to modify `.sync/` or `.obsidian/` in a vault other than AIHubVault | §5, §6 |
| Not running post_note_edit_review after completing note edits | §8 |
| Attempting full vault scan with Grep/Glob without using the indexer | §9 |
| Attempting to delete deeply recursive folders with `Remove-Item -Recurse` | §10 |
| Attempting to create scripts without user approval | §11 |

### Type C: Missing Procedure Detection Trigger

Activated when a required step is skipped. Automatically detected by the agent during the workflow.

| Detection Condition | Relevant Section |
|---------------------|-----------------|
| Root registry not updated after vault creation | §2 |
| CLAUDE.md not individualized after vault creation | §2 |
| Obsidian registration guidance missing after vault creation | §1, §2 |
| _STATUS.md or handoff not updated at session exit | §7 |
| Indexing not completed after note editing (`POST_EDIT_INDEX_UPDATED` not confirmed) | §8 |
| `_WORKSPACE_VERSION.md` not logged after workspace editing | §5, §6 |
| `_ROOT_VERSION.md` not logged after core rule changes | §12 |

---

## Guidance Principles

- **Be concise**: Provide only the minimum information needed for the situation. Do not recite the entire ruleset.
- **Once only**: Do not repeat the same guidance within the same session. After one guidance, if the user agrees, handle the same pattern automatically thereafter.
- **Guide, don't block**: Do not stop the user's work. Inform them of the correct method and let them choose.
- **Includes self-correction**: The agent also uses this guide to self-correct when it is about to attempt an incorrect method.

---

## 1. Opening a New Vault in Obsidian

### Triggers
- **B**: When the agent is about to use `obsidian://open?path=` on an unregistered vault
- **A**: "How do I open a new vault?", "Register in Obsidian"

### Guidance
> Obsidian vault manager → "Open folder as vault" → Select vault path

- Opening an unregistered vault via `obsidian://open?path=` URI triggers app state transition + registration + plugin loading simultaneously, making it very slow.
- URIs should only be used for **switching to already-registered vaults** (`obsidian://open?vault=VaultName`).
- Agents must also not use `obsidian://open?path=` on unregistered vaults.

---

## 2. Vault Creation

### Triggers
- **B**: When attempting to create a vault by manually copying folders
- **A**: "Where do I create a vault?", "What do I do after creating a vault?"
- **C**: If any of the following are missed after creation: registry registration, CLAUDE.md individualization, Obsidian registration guidance

### Guidance
- **Creation method**: Use the `/create-vault` skill or `node cli.js clone`. Manual copying is prohibited.
- **Location selection**: Guide to the appropriate category based on purpose (Domains_Game, Domains_Infra, Projects_Game, etc.)
- **Required after creation**: CLAUDE.md individualization, _STATUS.md initialization, root registry registration, Obsidian registration (directly from the vault manager)

---

## 3. Which Vault Should a Note Go In

### Triggers
- **A**: "Where should I put this?", "Which vault?"
- **B**: Attempting to write content in BasicContentsVault

### Guidance
- Show the vault list by category from the `_STATUS.md` vault registry.
- Recommend a suitable vault by keyword (refer to CLAUDE.md routing rules).
- If no suitable vault exists, suggest creating a new one.
- Do not put content in BasicContentsVault (it is a clone template only).

---

## 4. Edit Mode Confusion

### Triggers
- **B**: When attempting to modify Contents files and workspace files simultaneously in one task
- **A**: "Can I edit this file?", "What's the difference between Contents and workspace?"

### Guidance
- `Contents/**` = Contents mode. Writing/editing notes.
- `.sync/`, `.claude/`, vault root files = Workspace mode. Editable only in AIHubVault.
- Do not mix both modes in one task. Declare when switching modes.
- Guide with statements like "This file is a workspace edit, so it must be modified in AIHubVault."

---

## 5. Workspace Sync

### Triggers
- **B**: Attempting to directly modify `.sync/` files in a vault other than AIHubVault
- **A**: "Didn't the sync happen?", "The versions are different?"
- **C**: `_WORKSPACE_VERSION.md` not logged after workspace editing

### Guidance
- Workspace edits happen only in AIHubVault. Other vaults receive changes automatically via sync.
- Compare `_WORKSPACE_VERSION.md` versions and run sync if there is a discrepancy.
- Running sync: Automatically executed when opening the vault in Obsidian. Manual: `node cli.js pre-sync`.

---

## 6. Plugin Installation/Configuration

### Triggers
- **B**: Attempting to modify `.obsidian/` in a vault other than AIHubVault
- **A**: "Install a plugin for me", "I changed settings but they don't apply in other vaults"

### Guidance
- Plugin installation/settings changes are performed in AIHubVault and propagated via sync.
- Using the `/install-plugin` skill is recommended.
- `.obsidian/` editing is Workspace mode. Logging the version in `_WORKSPACE_VERSION.md` is required.

---

## 7. Session Exit

### Triggers
- **A**: "Done", "Wrap up", "Finish"
- **C**: If any of _STATUS.md, handoff, or root _STATUS.md are not updated at session exit

### Guidance
- Running the `/vault-update` skill handles the session exit routine automatically.
- Manual: Update all three — vault `_STATUS.md` + root `_STATUS.md` + `_SESSION_HANDOFF_{agent}.md`.
- If any one is missing, the session exit is incomplete.

---

## 8. Post-Note-Edit Verification

### Triggers
- **C**: post_note_edit_review not run after completing note edits, or indexing not completed
- **A**: "How do I run the review?", "BAD is not 0?"

### Guidance
- Running `node cli.js review` after note editing is required.
- If BAD is not 0, fix the issues in the affected files (missing frontmatter, encoding, etc.).
- The task is not complete until indexing (`POST_EDIT_INDEX_UPDATED=1`) is confirmed.
- Manual indexing if it fails: `node cli.js index build -r {vault_path} -i`

---

## 9. Content Search

### Triggers
- **B**: Attempting full vault scan with Grep/Glob without using the indexer
- **A**: "Where is the note?", "I want to find something"

### Guidance
- **Use the indexer first**: `node cli.js index search -q "search_term"`
- Use Grep/Glob only when the indexer returns no results.
- If the index seems outdated, run `/reindex`.

---

## 10. Infinite Recursive Path Deletion

### Triggers
- **B**: Attempting to delete deeply recursive folders with `Remove-Item -Recurse`, `rd /s /q`, `7z d`, etc.
- **A**: "Can't delete it", "The path is too long"

### Guidance
- Detailed solution: `temp-file-management.md` § "Infinite Recursive Path Deletion (Incident Rule)"
- Priority 1: PowerShell flatten-and-delete
- Priority 2: Repeated robocopy mirror
- 7z, Remove-Item, rd, .NET Delete all fail.

---

## 11. Script Creation

### Triggers
- **B**: Agent attempting to create scripts without user approval
- **C**: Duplicate check in Script_Registry.md missing

### Guidance
- User approval is required before creating scripts. Report purpose, path, and scope of impact.
- Check `Script_Registry.md` for duplicates. If it can be solved by extending an existing script, do not create a new one.

---

## 12. Distribution Sync

### Triggers
- **A**: "How do I deploy?", "What is SellingVault?"
- **C**: `_ROOT_VERSION.md` not logged after core rule changes

### Guidance
- Core rule/skill changes are distribution targets. Log them in `_ROOT_VERSION.md`.
- Distribution path: SellingVault (`C:\SellingVault\Korean\AIMindVaults`).
- Distribution + git push is performed only when the user explicitly requests it.
