# AIMindVaults System Architecture

> As of 2026-04-13
> Audience: collaborators and end users

---

## 1. System Overview

AIMindVaults is an Obsidian-based multi-vault knowledge-management system. Rather than a single knowledge store, it organizes per-domain vaults under one root directory and is built for collaboration with AI agents (Claude Code, Codex, Cursor, etc.).

Three core principles:

- **Single source (Hub)**: AIHubVault is the one workspace origin. Shared config and tools propagate from the Hub.
- **Domain separation**: Knowledge is split across topic-specific vaults. Vault boundaries stay clear.
- **Agent collaboration**: Rule files (`CLAUDE.md`, `.claude/rules/`) control agent behavior.

---

## 2. Vault System

### Directory layout

```
C:\AIMindVaults\
├── Vaults\
│   ├── BasicVaults\          ← system vaults
│   ├── Domains_Game\         ← game domain
│   ├── Domains_Video\        ← video domain
│   ├── Domains_Infra\        ← infra / tooling domain
│   ├── Domains_3D\           ← 3D domain
│   ├── Domains_VCS\          ← version control domain
│   ├── Domains_AI_Asset\     ← AI asset production
│   ├── Domains_Dev\          ← programming language / style
│   ├── Domains_Business\     ← business
│   ├── Domains_Life\         ← life
│   ├── Domain_Art\           ← art
│   ├── Lab_Infra\            ← domain + project hybrid
│   ├── Lab_Game\             ← game dev toolkit Lab
│   ├── Lab_Content\          ← content production Lab
│   ├── Projects_Game\        ← game dev projects
│   ├── Projects_Infra\       ← infra projects
│   └── Personal\             ← personal records
├── References\               ← readonly references
├── Archives\                 ← non-vault archives
├── Backup\                   ← backups
├── docs\                     ← system docs (this file)
├── _STATUS.md                ← root vault registry
└── CLAUDE.md                 ← root agent entry point
```

### Category rules

| Category | Role | Placement criterion |
|----------|------|---------------------|
| `BasicVaults/` | System vaults (Hub, clone template) | AIHubVault and BasicContentsVault only |
| `Domains_*/` | Domain knowledge on a specific topic | External-material study, experience-based knowledge |
| `Lab_*/` | Domain knowledge + active development | Plugin dev, research experiments |
| `Projects_*/` | Project deliverables with specific goals | Game dev, infra builds |
| `Personal/` | Private records | Diary, retrospectives, growth log |
| `References/` | Read-only official external docs | Lookup only, no edits |

### Default-provided vaults

Two vaults ship with the system:

- **AIHubVault** (`Vaults/BasicVaults/AIHubVault/`): the workspace origin (Hub). The single edit point for shared tools, config, and rules.
- **BasicContentsVault** (`Vaults/BasicVaults/BasicContentsVault/`): the clone template used to create new vaults. Don't put content in it directly.

Users add vaults as needed by cloning BasicContentsVault via `aimv clone`.

---

## 3. Hub-Sync Architecture

### Principle

AIHubVault is the single source. Shared workspace files (scripts, rules, plugin config) are edited in the Hub only; every other vault (a satellite) receives them via sync.

### Sync identification

- **Hub marker**: the vault that holds `.sync/.hub_marker` is the Hub. Satellites don't have it.
- **Sync unit**: the whole `.sync/` folder is mirrored Hub → satellite.
- **Version tracking**: `_WORKSPACE_VERSION.md` records the version. Format: `YYYYMMDDNNNN` (date + 4-digit serial).

### Sync flow

```
Open Obsidian vault
    ↓
Shell Commands: on-layout-ready event
    ↓
node cli.js pre-sync (satellite's local copy)
    ↓
[trampoline] compare Hub's cli.js hash
    → mismatch: re-exec with Hub version
    → match: continue
    ↓
Compare _WORKSPACE_VERSION.md
    → Hub > local: run file mirror
    → same: skip
    ↓
Mirror files + merge plugin config
```

### Trampoline pattern

The pre-sync script itself auto-updates to the Hub's latest version. If the satellite's `cli.js` hash differs from the Hub's, it copies the Hub version and re-executes. This keeps the sync script self-versioning.

### What's synced / not synced

| Target | In sync? |
|--------|----------|
| `.sync/_tools/cli-node/` | Yes (shared CLI tools) |
| `.sync/_Standards/Core/` | Yes (shared operational standards) |
| `.claude/rules/core/` | Yes (shared AI rules) |
| `.claude/commands/core/` | Yes (shared skills) |
| `CLAUDE.md` | No (per-vault file) |
| `_STATUS.md` | No (per-vault status) |
| `Contents/**` | No (per-vault content) |
| `vault_index.json` | No (per-vault index) |
| `.claude/rules/custom/` | No (user's personal rules) |

---

## 4. Edit-Mode Separation

Every edit runs in one of two modes. Don't mix modes within a single task.

### Contents mode

Edit scope: `{vault}/Contents/**`

Writing and editing notes. Internally splits into two sub-modes:

- `[Contents/Domain]`: domain knowledge — study notes, experience-based knowledge, references.
- `[Contents/Project]`: project work management — plans, designs, issue tracking.

Contents mode cannot edit `_Standards/`, `_tools/`, `.claude/`, or vault root files.

### Workspace mode

Edit scope: `_Standards/`, `_tools/`, `.claude/`, vault root files (`_STATUS.md`, `_WORKSPACE_VERSION.md`, `CLAUDE.md`, …).

**Only in AIHubVault.** Editing workspace files directly in another vault causes sync conflicts.

Required workspace-edit procedure:
1. Edit the file.
2. Record a version in `_WORKSPACE_VERSION.md` (max-of-day + 1).
3. Proceed to testing and sync.

Don't move to the next step without recording the version.

### Root-level edits

When changing multi-vault root files (`.claude/`, root config), record the version in `_ROOT_VERSION.md`. Format: `R` + 3-digit sequence (`R001`, `R002`).

---

## 5. Vault Internals

### Standard vault structure

```
{vault}/
├── Contents/
│   ├── Domain/                    ← domain knowledge notes
│   ├── Project/                   ← project work notes
│   │   ├── plan/
│   │   └── idea/
│   ├── CONTENTS_SPEC.md           ← this vault's content scope
│   ├── CONTENTS_AI_RULES.md      ← per-vault AI behavior rules
│   └── CONTENTS_GLOSSARY.md       ← per-vault glossary
├── _Standards/
│   └── Core/
│       ├── CONTENTS_SPEC.md       ← shared content spec
│       └── Script_Registry.md     ← script registry
├── _STATUS.md                     ← Now/Next/Blocked/Decisions
├── _VAULT-INDEX.md                ← folder structure map
├── _WORKSPACE_VERSION.md          ← sync version
├── CLAUDE.md                      ← agent entry point (vault-specific rules)
└── .sync/
    ├── .hub_marker                ← Hub only
    ├── _Standards/Core/           ← shared standards propagated from Hub
    └── _tools/cli-node/           ← Node.js CLI tools
        ├── bin/cli.js             ← entry point (aimv)
        ├── src/commands/          ← 14 command modules
        ├── src/lib/               ← shared libraries
        └── package.json
```

### Per-vault vs. synced files

| File | Kind | Notes |
|------|------|-------|
| `CLAUDE.md` | per-vault | Different in every vault |
| `_STATUS.md` | per-vault | Per-vault current state |
| `_VAULT-INDEX.md` | per-vault | Per-vault folder map |
| `_WORKSPACE_VERSION.md` | sync tracker | Used for Hub-vs-satellite comparison |
| `.sync/_tools/` | synced | Pushed from Hub; don't edit directly |

---

## 6. AI Rule System

### Three-tier hierarchy

```
root .claude/rules/     ← applies to all vaults
    ↓
{vault}/CLAUDE.md        ← vault-specific rules (may override shared rules)
    ↓
{vault}/_WORKFLOW.md     ← per-workflow detailed procedures
```

### Namespaces

```
.claude/rules/core/      ← distribution target; auto-applies to all vaults
.claude/rules/custom/    ← user's personal rules; not in distribution
.claude/commands/core/   ← distribution skills
.claude/commands/custom/ ← user's personal skills; not in distribution
```

### core rules (15)

| File | Role |
|------|------|
| `encoding-safety.md` | Encoding safety (prevent mojibake) |
| `edit-mode-separation.md` | Contents / Workspace edit modes |
| `post-edit-review.md` | Post-edit validation & indexing |
| `script-management.md` | Script de-duplication & registry |
| `script-creation-approval.md` | Pre-approval for new scripts |
| `juggl-style-sync.md` | Juggl graph style sync |
| `note-writing.md` | Note-writing pattern (frontmatter, types, tags) |
| `vault-routing.md` | Vault routing & content placement |
| `session-exit.md` | Session-exit state refresh |
| `token-optimization.md` | Token saving & indexer-first search |
| `temp-file-management.md` | Temp-file management |
| `distribution-sync.md` | Distribution-sync rules |
| `obsidian-config-safety.md` | Safe Obsidian-config editing |
| `vault-individualization.md` | Vault-creation individualization |
| `user-guidance.md` | Agent user-guidance rulebook |

### Adding a new rule

Start new rules in `custom/`; promote to `core/` after validation and register in `MANIFEST.md` + the distribution change log.

---

## 7. Content Indexer

### Role

Crawls each vault's `Contents/**/*.md` to produce `vault_index.json`. AI agents consult the indexer before scanning files directly.

### Extracted fields

| Field | Description |
|-------|-------------|
| `path` | Relative path in the vault |
| `title` | H1 |
| `type` | Frontmatter type |
| `tags` | Frontmatter tags |
| `headings` | H2/H3 list |
| `summary` | Opening summary of the body |
| `links_to` | Files this note links to |
| `links_from` | Files linking to this note |
| `mtime` | Last modified time |
| `hash` | Content hash (for incremental builds) |

### Build modes

- **Full build**: crawl every file.
- **Incremental**: compare `mtime` / `hash`, update only changed files.
- **Cross-vault master index**: supported across multiple vaults.

### Search priority (required)

```
Step 1: index search — keyword / tag / type search against the index
Step 2: fall back to Grep, Glob, or direct file scan only when results are insufficient
```

Don't dive straight into a whole-vault file scan without consulting the indexer.

---

## 8. State Management

### File roles

| File | Location | Role |
|------|----------|------|
| `_STATUS.md` | each vault root | Now/Next/Blocked/Decisions — per-vault current state |
| `_STATUS.md` | multi-vault root | Vault registry — name, type, working agent, last-work date |
| `_SESSION_HANDOFF_{agent}.md` | each vault root | Inter-session context (latest turn only) |
| `_WORKSPACE_VERSION.md` | each vault root | Hub-Sync version tracker |

### Required session-exit updates

1. Vault `_STATUS.md` — update Now/Next/Blocked/Decisions.
2. Root `_STATUS.md` — update the working agent / date for this vault.
3. `_SESSION_HANDOFF_CLAUDE.md` (or agent-specific file) — overwrite.

Missing any of the three = incomplete session exit.

### Agent ownership

When multiple agents share a vault, split ownership to avoid conflicts.

| Agent | Primary scope |
|-------|---------------|
| Claude Code | Multi-vault structure, script dev, rules/skills authoring, `.obsidian/` config |
| Codex | Single-vault note editing, repetitive tasks, distribution-sync runs |

Do-not-concurrent-edit files: `_STATUS.md`, `_WORKSPACE_VERSION.md`, `.obsidian/**`, `_VAULT-INDEX.md`.

---

## 9. Note System

### Required frontmatter

Every note starts with YAML frontmatter containing:

```yaml
---
type: knowledge          # from the core type list
tags: [Unity, game-system]
agent: claude            # cumulative log of working agents
created: 2026-04-13      # or updated
---
```

### Type system

Types are kebab-case, singular, and don't carry a `-note` suffix.

**Content types (11)**

| Type | Purpose |
|------|---------|
| `study-note` | External-material study notes |
| `knowledge` | Domain knowledge — experience-based |
| `design` | System / structure design doc |
| `plan` | Plans, roadmaps |
| `research` | Investigation, analysis, comparison |
| `reference` | External references |
| `report` | Work-result report |
| `spec` | Feature / system spec |
| `guide` | Install / operate / usage guide |
| `concept` | Early idea, direction exploration |
| `memo` | Short memo |

**Issue-management types (6)**: `issue`, `issue-index`, `issue-spec`, `issue-design`, `issue-report`, `debug-design`

**Temporary types (2)**: `temp-draft`, `temp-review`

**Vault-structure types (2)**: `standard`, `folder-index`

For vault-specific types, declare them in that vault's `CLAUDE.md`. Don't invent unregistered types on the fly.

### Tag rules

- Default: kebab-case lowercase (`skill-system`, `game-design`).
- Proper nouns: keep the original spelling (`Unity`, `AI`, `Obsidian`, `Blender`).
- Flat: no hierarchical separator (`/`).
- Singular.

The `## Tag rules` section in a vault's `CLAUDE.md` overrides the default for that vault.

### Note-writing rules

- **WikiLink required**: new notes must include at least one `[[WikiLink]]` to a related note in the same vault.
- **Juggl embed**: place directly under the H1. `local:` takes the filename (no extension).
  ```juggl
  local: 20260413_filename
  ```
- **H1 restrictions**: no URI-reserved characters (`#`, `%`, `&`, `?`, `+`) and no emoji.
- **Filename restrictions**: same — no URI-reserved characters, no emoji. Use `aliases` for display readability.

---

## 10. Vault Creation

Create new vaults by cloning BasicContentsVault. Don't use manual folder copy (`Copy-Item`, `cp`, etc.).

### Procedure

1. **Clone**

   ```bash
   node {BasicContentsVault-path}/.sync/_tools/cli-node/bin/cli.js clone \
     -t {target-path} \
     -n {vault-name}
   ```

   What the clone script handles:
   - Exclude `.git`, caches, sync folders.
   - Strip device-specific plugin config.
   - Refresh make-md systemName.

2. **Individualize CLAUDE.md**: role, scope, out-of-scope items, directory structure, tag rules.

3. **Register in root `_STATUS.md`**: name, category, role, status.

4. **Add routing keywords in root `CLAUDE.md`.**

5. **Build the initial index**:

   ```bash
   node {vault-path}/.sync/_tools/cli-node/bin/cli.js index build -r {vault-path}
   ```

6. **Register in Obsidian**: Vault manager → "Open folder as vault" → select the vault path.

---

## 11. Post-Edit Review

After finishing a note edit, run:

```bash
node {vault-path}/.sync/_tools/cli-node/bin/cli.js review -r {vault-path}
```

Completion conditions:
- `POST_EDIT_REVIEW_BAD=0` — no frontmatter / encoding errors.
- `POST_EDIT_INDEX_UPDATED=1` — content index refreshed.

If `POST_EDIT_INDEX_UPDATED=0` or `POST_EDIT_INDEX_SKIPPED=1`, refresh manually:

```bash
node {vault-path}/.sync/_tools/cli-node/bin/cli.js index build -r {vault-path} -i
```

---

## 12. Distribution Sync

### Targets

Changes under `.claude/rules/core/`, `.claude/commands/core/`, `.sync/_tools/`, `.sync/_Standards/Core/` are distribution targets.

### Flow

```
AIHubVault (edit source)
    ↓
sync-distribution workflow
    ↓
BasicContentsVault (distribution clone template)
    ↓
SellingVault (C:\SellingVault\English\AIMindVaults)
    ↓
git commit + push (github.com/warqun/AIMindVaults-EN)
```

Agents don't access the distribution path directly. Distribution + git push runs only when the user explicitly requests it.

### Distribution content standard

The distribution (SellingVault) is written for buyers / new users. Maintainer-private vaults, custom rules, and environment-specific MCP setups are excluded from the distribution.

---

> Update this document whenever the system structure changes.
