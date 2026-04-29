# AIMindVaults System Architecture

> Reference date: 2026-04-13
> Audience: collaborators and licensed users

---

## 1. System Overview

AIMindVaults is an Obsidian-based multi-vault knowledge management system. Rather than a single monolithic store, it manages domain-separated vaults under one root directory and is designed around collaboration with AI agents (Claude Code, Codex, Cursor, etc.).

There are three core principles:

- **Single source of truth (Hub)**: AIHubVault is the only workspace canon. Common settings and tooling are propagated outward from the Hub.
- **Domain separation**: Knowledge is split across topic-based vaults. Boundaries between vaults are kept explicit.
- **Agent collaboration**: Rule files (`CLAUDE.md`, `.claude/rules/`) drive agent behaviour.

---

## 2. Vault System

### Directory layout

```
C:\AIMindVaults\
├── Vaults\
│   ├── BasicVaults\          ← System vaults
│   ├── Domains_*\            ← Domain knowledge vaults
│   ├── Lab_*\                ← Domain + project hybrids
│   ├── Projects_*\           ← Project deliverables
│   └── Personal\             ← Personal records
├── References\               ← Reference-only (read-only)
├── Archives\                 ← Non-vault material storage
├── Backup\                   ← Backups
├── docs\                     ← System documentation (this file)
├── _STATUS.md                ← Root vault registry
└── CLAUDE.md                 ← Root agent entry point
```

### Category classification

| Category | Role | Placement criteria |
|----------|------|--------------------|
| `BasicVaults/` | System vaults (Hub, clone templates) | Only AIHubVault and BasicContentsVault |
| `Domains_*/` | Domain knowledge for a specific topic | External-material study, experience-based knowledge |
| `Lab_*/` | Domain knowledge + active development | Plug-in development, research experiments |
| `Projects_*/` | Project deliverables with a target outcome | Game dev, infrastructure builds, etc. |
| `Personal/` | Personal records | Diary, retrospectives, growth log |
| `References/` | External official docs (read-only) | Reference only, no edits |

### Default vaults

The system ships with two vaults out of the box.

- **AIHubVault** (`Vaults/BasicVaults/AIHubVault/`): the workspace canon (Hub). The single editable point for shared tooling, settings, and rules.
- **BasicContentsVault** (`Vaults/BasicVaults/BasicContentsVault/`): the clone template for new vaults. Not used directly for content authoring.

Users add new vaults by cloning BasicContentsVault via `aimv clone`.

---

## 3. Hub-Sync Architecture

### Core principle

AIHubVault is the only canon. Common workspace files (scripts, rules, plug-in settings) are edited only on the Hub; satellite vaults receive them via synchronization.

### Sync identification

- **Hub identification**: a vault is the Hub if `.sync/.hub_marker` exists. Satellite vaults do not have this marker.
- **Sync unit**: the entire `.sync/` folder is mirrored from Hub → satellite.
- **Version tracking**: `_WORKSPACE_VERSION.md` records the version number. Format: `YYYYMMDDNNNN` (date + 4-digit serial).

### Sync flow

```
Open Obsidian vault
    ↓
Shell Commands: on-layout-ready event
    ↓
node cli.js pre-sync (local copy on the satellite vault)
    ↓
[Trampoline] hash compare against the Hub's cli.js
    → Mismatch: re-execute with the Hub version
    → Match: continue
    ↓
_WORKSPACE_VERSION.md version compare
    → Hub > local: run file mirroring
    → Equal: skip sync
    ↓
File mirroring + plug-in settings merge
```

### Trampoline pattern

The pre-sync script is itself swapped for the Hub's latest version. If the satellite's `cli.js` hashes differently from the Hub's `cli.js`, the Hub copy is staged and re-executed. Versioning of the sync script itself is therefore automatic.

### Sync inclusion vs. exclusion

| Path | Synced |
|------|--------|
| `.sync/_tools/cli-node/` | Yes (shared CLI tooling) |
| `.sync/_Standards/Core/` | Yes (shared operating standards) |
| `.claude/rules/core/` | Yes (shared AI rules) |
| `.claude/commands/core/` | Yes (shared skills) |
| `CLAUDE.md` | No (per-vault file) |
| `_STATUS.md` | No (per-vault state) |
| `Contents/**` | No (per-vault content) |
| `vault_index.json` | No (per-vault index) |
| `.claude/rules/custom/` | No (user-personal rules) |

---

## 4. Edit-Mode Separation

Every edit is performed in exactly one of two modes. The two modes are not mixed in a single task.

### Contents mode

Edit scope: `{vault}/Contents/**`

Covers note authoring and modification. Internally, it splits into two:

- `[Contents/Domain]`: domain knowledge accumulation. Study notes, experience-based knowledge, references.
- `[Contents/Project]`: project work tracking. Plans, designs, issue tracking.

`_Standards/`, `_tools/`, `.claude/`, and root vault files cannot be edited from Contents mode.

### Workspace mode

Edit scope: `_Standards/`, `_tools/`, `.claude/`, root vault files (`_STATUS.md`, `_WORKSPACE_VERSION.md`, `CLAUDE.md`, etc.)

**Performed only on AIHubVault.** Editing workspace files on a satellite directly causes sync conflicts.

Mandatory steps when editing in workspace mode:
1. Modify the file.
2. Record a version number in `_WORKSPACE_VERSION.md` (max same-day serial + 1).
3. Run downstream tests and synchronization.

Do not move on without recording the version.

### Root-level edits

When changes apply to the multi-vault root (`.claude/`, `.antigravity/`, root config files, etc.), record the version in `_ROOT_VERSION.md`. Format: `R` + 3-digit serial (`R001`, `R002`).

---

## 5. Vault Internal Structure

### Standard layout

```
{vault}/
├── Contents/
│   ├── Domain/                    ← Domain knowledge notes
│   ├── Project/                   ← Project deliverable notes
│   │   ├── plan/
│   │   └── idea/
│   ├── CONTENTS_SPEC.md           ← Content scope of this vault
│   ├── CONTENTS_AI_RULES.md       ← Per-vault AI behaviour rules
│   └── CONTENTS_GLOSSARY.md       ← Per-vault glossary
├── _Standards/
│   └── Core/
│       ├── CONTENTS_SPEC.md       ← Shared content spec
│       └── Script_Registry.md     ← Script registry
├── _STATUS.md                     ← Now/Next/Blocked/Decisions
├── _VAULT-INDEX.md                ← Folder-structure map
├── _WORKSPACE_VERSION.md          ← Sync version
├── CLAUDE.md                      ← Agent entry point (per-vault rules)
└── .sync/
    ├── .hub_marker                ← Hub-only
    ├── _Standards/Core/           ← Shared standards propagated from Hub
    └── _tools/cli-node/           ← Node.js CLI tools
        ├── bin/cli.js             ← Entry point (aimv)
        ├── src/commands/          ← 14 command modules
        ├── src/lib/               ← Shared libraries
        └── package.json
```

### Per-vault files vs. synced files

| File | Nature | Description |
|------|--------|-------------|
| `CLAUDE.md` | Per-vault | Different content per vault |
| `_STATUS.md` | Per-vault | Per-vault current state |
| `_VAULT-INDEX.md` | Per-vault | Per-vault folder layout |
| `_WORKSPACE_VERSION.md` | Sync tracking | Used for Hub-to-satellite version comparison |
| `.sync/_tools/` | Synced | Propagated from Hub; do not edit directly |

---

## 6. AI Rule System

### Three-tier rule hierarchy

```
Root .claude/rules/     ← Applied to every vault
    ↓
{vault}/CLAUDE.md       ← Per-vault rules (may override shared rules)
    ↓
{vault}/_WORKFLOW.md    ← Step-by-step task procedures
```

### Namespace structure

```
.claude/rules/core/      ← Deployment target, auto-applied to every vault
.claude/rules/custom/    ← User-personal rules, not deployed
.claude/commands/core/   ← Deployment-target skills
.claude/commands/custom/ ← User-personal skills, not deployed
```

### core rule list (15 entries)

| Rule file | Role |
|-----------|------|
| `encoding-safety.md` | Encoding safety (Korean mojibake prevention) |
| `edit-mode-separation.md` | Contents/Workspace edit-mode separation |
| `post-edit-review.md` | Post-edit review and indexing |
| `script-management.md` | Script duplication prevention and registration |
| `script-creation-approval.md` | Pre-approval for script creation |
| `juggl-style-sync.md` | Juggl graph style sync |
| `note-writing.md` | Note-writing patterns (frontmatter, type, tags) |
| `vault-routing.md` | Vault-routing and content placement rules |
| `session-exit.md` | State updates at session end |
| `token-optimization.md` | Token saving and indexer-first search |
| `temp-file-management.md` | Temporary-file management |
| `distribution-sync.md` | Deployment sync rules |
| `obsidian-config-safety.md` | Safe editing of Obsidian config files |
| `vault-individualization.md` | Individualization rules during vault creation |
| `user-guidance.md` | Agent guidance rulebook for user interaction |

### Adding new rules

New rules are first created under `custom/`, validated, and promoted to `core/` if needed. Once promoted, register them in `MANIFEST.md` and record in the deployment changelog.

---

## 7. Content Indexer

### Role

Crawls each vault's `Contents/**/*.md` and produces `vault_index.json`. AI agents must consult the indexer before scanning files directly.

### Extracted fields

| Field | Description |
|-------|-------------|
| `path` | Vault-relative path |
| `title` | H1 heading |
| `type` | Frontmatter type |
| `tags` | Frontmatter tags |
| `headings` | List of H2/H3 headings |
| `summary` | Short body summary |
| `links_to` | Files this note links to |
| `links_from` | Files that link to this note |
| `mtime` | Last modification time |
| `hash` | Content hash (for incremental builds) |

### Build modes

- **Full build**: crawls every file
- **Incremental build**: updates only changed files, by `mtime`/`hash` comparison
- **Cross-vault master index**: also supports a unified index across multiple vaults

### Search precedence (mandatory)

```
Step 1: vault_index_search.js — index-based keyword/tag/type search
Step 2: only when results are insufficient → fall back to Grep/Glob direct file scan
```

Do not jump straight into a full-vault file scan without consulting the indexer.

---

## 8. State Management

### File responsibilities

| File | Location | Role |
|------|----------|------|
| `_STATUS.md` | Per-vault root | Now/Next/Blocked/Decisions — per-vault current task state |
| `_STATUS.md` | Multi-vault root | Vault registry — vault names, types, working agents, recent activity |
| `_SESSION_HANDOFF_{agent}.md` | Per-vault root | Session-to-session context handoff (only the latest entry kept) |
| `_WORKSPACE_VERSION.md` | Per-vault root | Hub-Sync version tracking |

### Mandatory updates at session end

1. Vault `_STATUS.md` — update Now/Next/Blocked/Decisions
2. Root `_STATUS.md` — update the working-agent date for that vault
3. `_SESSION_HANDOFF_CLAUDE.md` (or the equivalent agent file) — overwrite

If any of the three is missing, the session is treated as incompletely closed.

### Agent ownership

When multiple agents work in the same vault, ownership is divided to prevent file conflicts.

| Agent | Primary work area |
|-------|-------------------|
| Claude Code | Multi-vault structure changes, script development, rule/skill authoring, `.obsidian/` settings |
| Codex | Single-vault note edits, repetitive work, deployment-sync execution |

Concurrently-edit-forbidden files: `_STATUS.md`, `_WORKSPACE_VERSION.md`, `.obsidian/**`, `_VAULT-INDEX.md`

---

## 9. Note System

### Required frontmatter

Every note begins with YAML frontmatter that includes the following.

```yaml
---
type: knowledge          # Type (chosen from the core type list)
tags: [Unity, game-system]  # Tags
agent: claude            # Working agent (cumulative record)
created: 2026-04-13      # Creation date (or updated)
---
```

### Type system

Types follow kebab-case, singular form, and the "no `-note` suffix" rule.

**Content types (11)**

| Type | Use |
|------|-----|
| `study-note` | External-material study notes |
| `knowledge` | Domain knowledge — experience-based |
| `design` | System/structure design documents |
| `plan` | Plans, roadmaps |
| `research` | Investigation, analysis, comparison |
| `reference` | Curated external references |
| `report` | Work-result reports |
| `spec` | Detailed feature/system specifications |
| `guide` | Installation/operating/usage guides |
| `concept` | Early-stage ideas, direction exploration |
| `memo` | Short memos |

**Issue management types (6)**: `issue`, `issue-index`, `issue-spec`, `issue-design`, `issue-report`, `debug-design`

**Temporary types (2)**: `temp-draft`, `temp-review`

**Vault structure types (2)**: `standard`, `folder-index`

If a vault-specific type is needed, declare it in that vault's `CLAUDE.md`. Do not invent unregistered types.

### Tag rules

- Default: lowercase kebab-case (`skill-system`, `game-design`)
- Proper nouns: keep original spelling (`Unity`, `AI`, `Obsidian`, `Blender`)
- Flat structure: do not use the hierarchy separator (`/`)
- Singular-form principle

A vault's `CLAUDE.md` `## Tag rules` section can declare a different format, which then takes precedence in that vault.

### Note-writing rules

- **WikiLink required**: when creating a new note, include at least one `[[WikiLink]]` to a related note in the same vault.
- **Juggl embed**: insert immediately below the title. The `local:` value is the filename (without extension).
  ```juggl
  local: 20260413_filename
  ```
- **H1 title constraints**: URI-reserved characters (`#`, `%`, `&`, `?`, `+`) and emoji are forbidden.
- **Filename constraints**: same constraints as H1 — URI-reserved characters and emoji are forbidden. Use `aliases` for readability.

---

## 10. Vault Creation Procedure

New vaults are created by cloning BasicContentsVault. Manual folder copying (`Copy-Item`, `cp`, etc.) is not used.

### Steps

1. **Run the clone**

   ```bash
   node {BasicContentsVault path}/.sync/_tools/cli-node/bin/cli.js clone \
     -t {target path} \
     -n {vault name}
   ```

   The clone script handles:
   - Excludes `.git`, caches, and sync folders during copy
   - Auto-removes per-device plug-in settings
   - Auto-rewrites the make-md systemName

2. **Individualize CLAUDE.md**: vault role, collection scope, exclusion criteria, directory structure, tag rules

3. **Register in root `_STATUS.md`**: vault name, category, role, status

4. **Add keywords to the root `CLAUDE.md` vault-entry protocol**

5. **Initial content-index build**:

   ```bash
   node {vault path}/.sync/_tools/cli-node/bin/cli.js index build -r {vault path}
   ```

6. **Register in Obsidian**: Obsidian Vault Manager → "Open folder as vault" → choose the vault path

---

## 11. Post-Edit Review

After finishing a note edit, run the following review.

```bash
node {vault path}/.sync/_tools/cli-node/bin/cli.js review -r {vault path}
```

Completion criteria:
- `POST_EDIT_REVIEW_BAD=0`: no frontmatter errors or encoding issues
- `POST_EDIT_INDEX_UPDATED=1`: content index has been updated

If `POST_EDIT_INDEX_UPDATED=0` or `POST_EDIT_INDEX_SKIPPED=1`, run a manual index build before declaring completion:

```bash
node {vault path}/.sync/_tools/cli-node/bin/cli.js index build -r {vault path} -i
```

---

## 12. Deployment Sync

### Deployment targets

Changes under `.claude/rules/core/`, `.claude/commands/core/`, `.sync/_tools/`, and `.sync/_Standards/Core/` are deployment targets.

### Deployment flow

```
AIHubVault (canon edit)
    ↓
sync-distribution workflow
    ↓
BasicContentsVault (deployment clone template)
    ↓
SellingVault (C:\SellingVault\Korean\AIMindVaults or English\AIMindVaults)
    ↓
git commit + push (github.com/warqun/AIMindVaults)
```

Agents do not access the deployment paths directly. Deployment + git push is performed only when the user explicitly requests it.

### Deployment baseline

The deployment build (SellingVault) is written for buyers / new users. Author-personal vaults, custom rules, and per-environment MCP settings are not included in the deployment.

---

> Update this document together with system-structure changes.
