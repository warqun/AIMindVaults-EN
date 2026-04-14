# AIMindVaults System Architecture

> Last updated: 2026-04-13
> Audience: Collaborators and users

---

## 1. System Overview

AIMindVaults is an Obsidian-based multi-vault knowledge management system. Rather than a single knowledge store, it manages domain-specific vaults under a single root directory, designed for collaboration with AI agents (Claude Code, Codex, Cursor, etc.).

Three core principles guide the design:

- **Single Source of Truth (Hub)**: AIHubVault is the sole workspace origin. All shared settings and tools propagate from the Hub.
- **Domain Separation**: Knowledge is distributed across topic-specific vaults. Clear boundaries are maintained between vaults.
- **Agent Collaboration**: Rule files (`CLAUDE.md`, `.claude/rules/`) govern agent behavior.

---

## 2. Vault Hierarchy

### Directory Structure

```
C:\AIMindVaults\
├── Vaults\
│   ├── BasicVaults\          ← System vaults
│   ├── Domains_Game\         ← Game domain
│   ├── Domains_Video\        ← Video domain
│   ├── Domains_Infra\        ← Infrastructure/tools domain
│   ├── Domains_3D\           ← 3D domain
│   ├── Domains_VCS\          ← Version control domain
│   ├── Domains_AI_Asset\     ← AI asset creation domain
│   ├── Domains_Dev\          ← Development language/style domain
│   ├── Domains_Business\     ← Business domain
│   ├── Domains_Life\         ← Lifestyle domain
│   ├── Domain_Art\           ← Art domain
│   ├── Lab_Infra\            ← Domain + project hybrid
│   ├── Lab_Game\             ← Game dev tools lab
│   ├── Lab_Content\          ← Content creation lab
│   ├── Projects_Game\        ← Game dev projects
│   ├── Projects_Infra\       ← Infrastructure projects
│   └── Personal\             ← Personal records
├── References\               ← Reference only (readonly)
├── Archives\                 ← Non-vault file storage
├── Backup\                   ← Backups
├── docs\                     ← System documentation (this file)
├── _STATUS.md                ← Root vault registry
└── CLAUDE.md                 ← Root agent entry point
```

### Category Classification Criteria

| Category | Role | Placement Criteria |
|----------|------|-------------------|
| `BasicVaults/` | System vaults (Hub, clone template) | Only AIHubVault and BasicContentsVault |
| `Domains_*/` | Domain knowledge accumulation on specific topics | Learning from external sources, experience-based knowledge |
| `Lab_*/` | Domain knowledge + hands-on development hybrid | Plugin development, experimental research |
| `Projects_*/` | Project deliverables with specific goals | Game development, infrastructure builds, etc. |
| `Personal/` | Personal records | Diary, retrospectives, growth logs |
| `References/` | External official documentation (read-only) | Cannot be modified; for reference purposes only |

### Default Vaults

The system ships with two vaults:

- **AIHubVault** (`Vaults/BasicVaults/AIHubVault/`): The workspace origin (Hub). The sole editing point for shared tools, settings, and rules.
- **BasicContentsVault** (`Vaults/BasicVaults/BasicContentsVault/`): Clone template for creating new vaults. Do not write content directly in this vault.

Users add vaults as needed by cloning BasicContentsVault with `aimv clone`.

---

## 3. Hub-Sync Architecture

### Core Principle

AIHubVault is the single source of truth. Shared workspace files (scripts, rules, plugin settings) are edited only in the Hub, and all other vaults (satellite vaults) receive updates through synchronization.

### Sync Identification Structure

- **Hub Identification**: The vault containing `.sync/.hub_marker` is the Hub. Satellite vaults do not have this file.
- **Sync Unit**: The entire `.sync/` folder is mirrored from Hub to satellites.
- **Version Tracking**: `_WORKSPACE_VERSION.md` records version numbers in the format `YYYYMMDDNNNN` (date + 4-digit sequence number).

### Sync Flow

```
Open Obsidian vault
    ↓
Shell Commands: on-layout-ready event
    ↓
node cli.js pre-sync (satellite vault's local copy)
    ↓
[Trampoline] Hash comparison with Hub's cli.js
    → Version mismatch: Re-execute with Hub version
    → Match: Continue
    ↓
_WORKSPACE_VERSION.md version comparison
    → Hub version > local version: Execute file mirroring
    → Same: Skip sync
    ↓
File mirroring + plugin setting merge
```

### Trampoline Pattern

The pre-sync script itself is automatically replaced with the latest Hub version. If the satellite vault's `cli.js` hash differs from the Hub's `cli.js`, the Hub version is copied over and re-executed. This ensures automatic version management of the sync script itself.

### Sync Inclusion / Exclusion

| Target | Included in Sync |
|--------|-----------------|
| `.sync/_tools/cli-node/` | Included (shared CLI tools) |
| `.sync/_Standards/Core/` | Included (shared operational standards) |
| `.claude/rules/core/` | Included (shared AI rules) |
| `.claude/commands/core/` | Included (shared skills) |
| `CLAUDE.md` | Excluded (vault-specific file) |
| `_STATUS.md` | Excluded (vault-specific status file) |
| `Contents/**` | Excluded (vault-specific content) |
| `vault_index.json` | Excluded (vault-specific index) |
| `.claude/rules/custom/` | Excluded (user's personal rules) |

---

## 4. Edit Mode Separation

All edits are performed in one of two modes. The two modes must not be mixed within a single task.

### Contents Mode

Edit scope: `{vault}/Contents/**`

This covers writing and editing content (notes). It further branches into two sub-modes:

- `[Contents/Domain]`: Domain knowledge accumulation. Study notes, experience-based knowledge, references.
- `[Contents/Project]`: Project work management. Plans, designs, issue tracking.

`_Standards/`, `_tools/`, `.claude/`, and vault root files cannot be modified in Contents mode.

### Workspace Mode

Edit scope: `_Standards/`, `_tools/`, `.claude/`, vault root files (`_STATUS.md`, `_WORKSPACE_VERSION.md`, `CLAUDE.md`, etc.)

**Performed only in AIHubVault.** Directly modifying workspace files in other vaults causes sync conflicts.

Required steps for workspace edits:
1. Edit the file
2. Record the version number in `_WORKSPACE_VERSION.md` (current day's max number + 1)
3. Proceed with testing and synchronization

Do not proceed to the next step without recording the version.

### Root-Level Edits

When changing multi-vault root files (`.claude/`, `.antigravity/`, root config files, etc.), record the version in `_ROOT_VERSION.md`. Format: `R` + 3-digit sequence number (`R001`, `R002`).

---

## 5. Vault Internal Structure

### Standard Vault Structure

```
{vault}/
├── Contents/
│   ├── Domain/                    ← Domain knowledge notes
│   ├── Project/                   ← Project work notes
│   │   ├── plan/
│   │   └── idea/
│   ├── CONTENTS_SPEC.md           ← Content scope definition for this vault
│   ├── CONTENTS_AI_RULES.md       ← Vault-specific AI behavior rules
│   └── CONTENTS_GLOSSARY.md       ← Vault-specific glossary
├── _Standards/
│   └── Core/
│       ├── CONTENTS_SPEC.md       ← Shared content spec
│       └── Script_Registry.md     ← Script registry
├── _STATUS.md                     ← Now/Next/Blocked/Decisions
├── _VAULT-INDEX.md                ← Folder structure map
├── _WORKSPACE_VERSION.md          ← Sync version
├── CLAUDE.md                      ← Agent entry point (vault-specific rules)
└── .sync/
    ├── .hub_marker                ← Exists only in Hub
    ├── _Standards/Core/           ← Shared standards propagated from Hub
    └── _tools/cli-node/           ← Node.js CLI tools
        ├── bin/cli.js             ← Entry point (aimv)
        ├── src/commands/          ← 14 command modules
        ├── src/lib/               ← Shared libraries
        └── package.json
```

### Vault-Specific Files vs. Synced Files

| File | Type | Description |
|------|------|-------------|
| `CLAUDE.md` | Vault-specific | Content differs per vault |
| `_STATUS.md` | Vault-specific | Current status per vault |
| `_VAULT-INDEX.md` | Vault-specific | Folder structure per vault |
| `_WORKSPACE_VERSION.md` | Sync tracking | Used for version comparison between Hub and satellites |
| `.sync/_tools/` | Synced file | Propagated from Hub; do not edit directly |

---

## 6. AI Rule System

### 3-Tier Rule Hierarchy

```
Root .claude/rules/     ← Applied globally across all vaults
    ↓
{vault}/CLAUDE.md       ← Vault-specific rules (can override global rules)
    ↓
{vault}/_WORKFLOW.md    ← Detailed step-by-step procedures per task
```

### Namespace Structure

```
.claude/rules/core/      ← Distributed rules, auto-applied to all vaults
.claude/rules/custom/    ← User's personal rules, not distributed
.claude/commands/core/   ← Distributed skills
.claude/commands/custom/ ← User's personal skills, not distributed
```

### Core Rules (15 total)

| Rule File | Purpose |
|-----------|---------|
| `encoding-safety.md` | Encoding safety (prevents Mojibake in non-ASCII text) |
| `edit-mode-separation.md` | Contents/Workspace edit mode separation |
| `post-edit-review.md` | Post-edit validation and indexing |
| `script-management.md` | Script deduplication and registration |
| `script-creation-approval.md` | Pre-approval for script creation |
| `juggl-style-sync.md` | Juggl graph style synchronization |
| `note-writing.md` | Note writing patterns (frontmatter, types, tags) |
| `vault-routing.md` | Vault routing and content placement rules |
| `session-exit.md` | Status update on session exit |
| `token-optimization.md` | Token conservation and indexer-first search |
| `temp-file-management.md` | Temporary file management |
| `distribution-sync.md` | Distribution sync rules |
| `obsidian-config-safety.md` | Safe editing of Obsidian config files |
| `vault-individualization.md` | Vault individualization on creation |
| `user-guidance.md` | Agent user guidance rulebook |

### Adding New Rules

New rules should be created in `custom/` first. After validation, promote to `core/` if needed, then register in `MANIFEST.md` and log in the distribution changelog.

---

## 7. Content Indexer

### Purpose

Crawls `Contents/**/*.md` in each vault to generate `vault_index.json`. AI agents use the indexer before resorting to direct file exploration.

### Extracted Fields

| Field | Description |
|-------|-------------|
| `path` | Relative path within the vault |
| `title` | H1 heading |
| `type` | Frontmatter type |
| `tags` | Frontmatter tags |
| `headings` | List of H2/H3 headings |
| `summary` | Summary from the beginning of the body |
| `links_to` | Files linked from this note |
| `links_from` | Files that link to this note |
| `mtime` | Last modification time |
| `hash` | Content hash (for incremental builds) |

### Build Modes

- **Full build**: Crawls all files
- **Incremental build**: Updates only changed files by comparing `mtime`/`hash`
- **Cross-vault master index**: Also supports a unified index across multiple vaults

### Search Priority (Mandatory)

```
Step 1: vault_index_search.js — Index-based keyword/tag/type search
Step 2: Only if results are insufficient → Direct file search with Grep, Glob, etc.
```

Do not jump directly to full vault file scanning without going through the indexer first.

---

## 8. Status Management System

### File Roles

| File | Location | Role |
|------|----------|------|
| `_STATUS.md` | Each vault root | Now/Next/Blocked/Decisions — Current work status per vault |
| `_STATUS.md` | Multi-vault root | Vault registry — Vault name, type, working agent, last activity date |
| `_SESSION_HANDOFF_{agent}.md` | Each vault root | Context handoff between sessions (only latest entry retained) |
| `_WORKSPACE_VERSION.md` | Each vault root | Hub-Sync version tracking |

### Required Updates on Session Exit

1. Vault `_STATUS.md` — Update Now/Next/Blocked/Decisions
2. Root `_STATUS.md` — Update the working agent date for the relevant vault
3. `_SESSION_HANDOFF_CLAUDE.md` (or the respective agent file) — Overwrite

The session is considered incomplete if any of these three items is missing.

### Agent Ownership

When multiple agents work on the same vault, ownership is separated to prevent file conflicts.

| Agent | Primary Work Area |
|-------|------------------|
| Claude Code | Multi-vault structure changes, script development, rule/skill authoring, `.obsidian/` settings |
| Codex | Note editing within a single vault, repetitive tasks, distribution sync execution |

Files with concurrent edit restrictions: `_STATUS.md`, `_WORKSPACE_VERSION.md`, `.obsidian/**`, `_VAULT-INDEX.md`

---

## 9. Note System

### Required Frontmatter Fields

Every note starts with YAML frontmatter containing the following fields:

```yaml
---
type: knowledge          # Type (selected from the core type list)
tags: [Unity, game-system]  # Tags
agent: claude            # Working agent (cumulative record)
created: 2026-04-13      # Creation date (or updated)
---
```

### Type System

Types follow kebab-case, singular form, and no `-note` suffix conventions.

**Content Types (11)**

| Type | Purpose |
|------|---------|
| `study-note` | Summary of external learning materials |
| `knowledge` | Domain knowledge — experience-based |
| `design` | System/architecture design document |
| `plan` | Plans, roadmaps |
| `research` | Investigation, analysis, comparison |
| `reference` | External reference summary |
| `report` | Work result report |
| `spec` | Feature/system detailed specification |
| `guide` | Installation/operation/usage instructions |
| `concept` | Early ideas, direction exploration |
| `memo` | Short memo |

**Issue Management Types (6)**: `issue`, `issue-index`, `issue-spec`, `issue-design`, `issue-report`, `debug-design`

**Temporary Types (2)**: `temp-draft`, `temp-review`

**Vault Structure Types (2)**: `standard`, `folder-index`

If a vault-specific type is needed, declare it in that vault's `CLAUDE.md`. Do not use unregistered types.

### Tag Rules

- Default: kebab-case lowercase (`skill-system`, `game-design`)
- Proper nouns: Preserve original spelling (`Unity`, `AI`, `Obsidian`, `Blender`)
- Flat structure only: No hierarchical separators (`/`)
- Singular form

If a different format is declared in the vault's `CLAUDE.md` under `## Tag Rules`, it takes precedence within that vault.

### Note Writing Rules

- **WikiLink required**: When creating a new note, include at least one `[[WikiLink]]` to a related note within the same vault.
- **Juggl embed**: Insert directly below the title. The `local:` value is the filename without extension.
  ```juggl
  local: 20260413_filename
  ```
- **H1 title restrictions**: No URI reserved characters (`#`, `%`, `&`, `?`, `+`) or emojis.
- **Filename restrictions**: No URI reserved characters or emojis. Use `aliases` for readability.

---

## 10. Vault Creation Procedure

New vaults are created by cloning BasicContentsVault. Do not use manual folder copying (`Copy-Item`, `cp`, etc.).

### Creation Steps

1. **Run clone**

   ```bash
   node {BasicContentsVault_path}/.sync/_tools/cli-node/bin/cli.js clone \
     -t {target_path} \
     -n {vault_name}
   ```

   The clone script handles:
   - Copying while excluding `.git`, caches, and sync folders
   - Automatic removal of device-specific plugin settings
   - Automatic update of make-md systemName

2. **Individualize CLAUDE.md**: Define the vault role, collection scope, exclusions, directory structure, and tag rules

3. **Register in root `_STATUS.md` registry**: Add vault name, category, role, and status

4. **Add routing keywords to root `CLAUDE.md` vault entry protocol**

5. **Initial content index build**:

   ```bash
   node {vault_path}/.sync/_tools/cli-node/bin/cli.js index build -r {vault_path}
   ```

6. **Register in Obsidian**: Obsidian vault manager > "Open folder as vault" > Select vault path

---

## 11. Post-Edit Review

Run the following validation after completing note edits:

```bash
node {vault_path}/.sync/_tools/cli-node/bin/cli.js review -r {vault_path}
```

Completion criteria:
- `POST_EDIT_REVIEW_BAD=0`: No frontmatter errors or encoding issues
- `POST_EDIT_INDEX_UPDATED=1`: Content index update complete

If `POST_EDIT_INDEX_UPDATED=0` or `POST_EDIT_INDEX_SKIPPED=1`, run manual indexing before marking as complete:

```bash
node {vault_path}/.sync/_tools/cli-node/bin/cli.js index build -r {vault_path} -i
```

---

## 12. Distribution Sync

### Distribution Targets

Changes to `.claude/rules/core/`, `.claude/commands/core/`, `.sync/_tools/`, and `.sync/_Standards/Core/` are distribution targets.

### Distribution Flow

```
AIHubVault (source edits)
    ↓
sync-distribution workflow
    ↓
BasicContentsVault (distribution clone template)
    ↓
SellingVault (C:\SellingVault\Korean\AIMindVaults)
    ↓
git commit + push (github.com/warqun/AIMindVaults)
```

Agents do not directly access the distribution path. Distribution + git push is performed only when explicitly requested by the user.

### Distribution Standards

The distribution copy (SellingVault) is written for buyers/new users. The creator's personal vaults, custom rules, and environment-specific MCP settings are not included in the distribution.

---

> This document is updated alongside system structure changes.
