# AIMindVaults Customization Guide

This guide explains how to extend and adjust AIMindVaults for your own environment.
Start from the default (AIHubVault + BasicContentsVault) and add or change as needed.

---

## 1. Adding Vaults

Add a vault when a new topic or project appears, so knowledge stays separated.

### Creating a vault

Clone `BasicContentsVault` as a template.

```bash
node cli.js clone -t "<target-path>" -n "<vault-name>"
```

Example:

```bash
node cli.js clone -t "Vaults/Domains_Dev/Python" -n "Python"
```

Do not use manual folder copies (`Copy-Item`, `cp`, `xcopy`). They skip automated steps such as plugin-config handling, sync-folder handling, and indexer initialization.

### Picking a category

Choose the parent folder that matches the vault's nature.

| Category | Path | Criterion |
|----------|------|-----------|
| Domains_* | `Vaults/Domains_<area>/` | Knowledge accumulation on a topic (tool, language, technique) |
| Lab_* | `Vaults/Lab_<area>/` | Knowledge + active development/experimentation |
| Projects_* | `Vaults/Projects_<area>/` | Real project execution and task management |
| Personal | `Vaults/Personal/` | Private logs — diary, retrospectives |

Examples: a language-knowledge vault → `Vaults/Domains_Dev/YourLanguageVault/`; a product project → `Vaults/Projects_<area>/YourProject/`.

### Required post-creation steps

After creating the vault, complete the following 6 steps in order.

**1. Individualize CLAUDE.md**

Open the vault's `CLAUDE.md` and fill in role, scope, and tag rules for this specific vault.
See [5. Vault CLAUDE.md authoring guide](#5-vault-claudemd-authoring-guide).

**2. Initialize _STATUS.md**

Open the vault's `_STATUS.md` and set the initial state (Now, Next, Blocked).

**3. Register in the root CLAUDE.md vault registry**

Add a row to the vault registry table in `C:\AIMindVaults\CLAUDE.md`.

```markdown
| MyVault | `Vaults/Domains_Dev/MyVault/` | role description | active |
```

**4. Add routing keywords in the root CLAUDE.md**

In the "Vault entry protocol > keyword inference" section, add keywords that route to this vault.

```markdown
- "Python", "pandas", "pip" → Vaults/Domains_Dev/Python
```

**5. Register in Obsidian's vault manager**

Obsidian app → Vault manager → "Open folder as vault" → select the vault path.
Do not use the `obsidian://open?path=` URI on an unregistered vault — it is very slow.

**6. Build the initial index**

Build the index so note search works in this vault.

```bash
node cli.js index build -r "<vault-path>"
```

Example:

```bash
node cli.js index build -r "Vaults/Domains_Dev/Python"
```

---

## 2. Customizing Rules

You can add or adjust the behavior rules that agents (Claude Code, etc.) follow.

### core vs custom

| Location | Path | Nature |
|----------|------|--------|
| core rules | `.claude/rules/core/` | System-critical rules. May be overwritten on update. Not recommended to edit. |
| custom rules | `.claude/rules/custom/` | Yours. Not part of the distribution sync. Add/edit freely. |

If you want a setting preserved across updates, put it in `custom/`.

### How to add a custom rule

Create a markdown file under `.claude/rules/custom/`.

File format:

```markdown
# Rule title (Mandatory or Optional)

> Scope description.

## Rules

- Specific rule
- Specific rule
```

`Mandatory` = agent must follow; `Optional` = recommendation.

Example — MCP server integration (`mcp-notion.md`):

```markdown
# Notion MCP (Mandatory)

> Applies to Notion-related tasks.

## Rules

- Use Notion MCP tools for page read/write.
- Only call the API directly when MCP tools cannot handle the task.
```

Example — project coding style (`python-style.md`):

```markdown
# Python coding style (Mandatory)

> Applies when writing Python code.

## Rules

- Add type hints to every function parameter and return.
- Write Google-style docstrings.
- Include a module-level docstring at the top of each file.
```

---

## 3. Customizing Skills

Skills are slash commands invoked via `/skill-name` in Claude Code.
Turn recurring workflows into skills to cut down on repeated instructions.

### core vs custom

| Location | Path | Nature |
|----------|------|--------|
| core skills | `.claude/commands/core/` | System skills. Not recommended to edit. |
| custom skills | `.claude/commands/custom/` | Yours. Add freely. |

### How to add a custom skill

Create a markdown file under `.claude/commands/custom/`.
The filename becomes the skill name: `/my-skill` → `my-skill.md`.

Example — weekly-review skill (`weekly-review.md`):

```markdown
# /weekly-review — Weekly retrospective

Generate this week's retrospective note under `Vaults/Personal/<YourDiaryVault>/`.

## Procedure

1. Determine this week's date range (Mon–Sun).
2. Filename: `YYYY-MM-DD_weekly-review.md` (based on Monday's date).
3. frontmatter: type=memo, tags=[diary, weekly-review].
4. Sections: what I did / what went well / what to improve / next week's plan.
5. Run post-edit review.
```

---

## 4. Tag Rule Override

The default tag format applies globally, but you can override it per vault.

### Default tag format

- General keywords: kebab-case (lowercase + hyphen) — `skill-system`, `game-design`.
- Proper nouns (product / framework names): keep the original spelling — `Unity`, `Notion`, `AI`.
- No hierarchical tags (`/` separator).
- Singular — `systems` ✗ → `system` ✓.

### Per-vault override

Add a `## Tag rules` section to the vault's `CLAUDE.md` and the vault will use that format instead.

```markdown
## Tag rules

- Use PascalCase (e.g. `MyDomain`, `SkillSystem`)
- Allow hierarchical tags (e.g. `domain/subtopic`, `design/system`)
- Vault-identifying tag: `<VaultName>` (required on every note)
```

Without that section, the system default applies.

---

## 5. Vault CLAUDE.md Authoring Guide

A vault's `CLAUDE.md` is the first file the agent reads on entering the vault.
The clearer the vault's role is defined, the more reliably the agent places content.

### Required sections

```markdown
# <vault-name>

## Role of this vault

This vault accumulates knowledge about <topic>.
<Describe the role in 1–2 sentences.>

## Scope

Content that belongs here:

- <target 1>
- <target 2>
- <target 3>

## Out of scope

Route the following elsewhere:

- <excluded item> → <target vault>
- <excluded item> → <target vault>

## Directory structure

Contents/
  Domain/         <- domain knowledge notes
    <topic-folder>/
  Project/        <- project-related notes (optional)

## Tag rules

- Vault-identifying tag: `<vault-tag>` (required on every note)
- Other tags follow the system default format

## Session entry rules

1. Read `_STATUS.md` (current progress).
2. Check the target working folder.
```

### Declaring vault-specific types

If your content doesn't fit the core types (study-note, knowledge, design, plan, …), declare vault-specific ones.

```markdown
## Vault-specific types

| Type | Purpose |
|------|---------|
| `recipe` | Recipe document |
| `experiment` | Cooking experiment log |
```

Names must not collide with core types.

### Template — Domain vault

```markdown
# Python

## Role of this vault

Accumulate knowledge about Python and its ecosystem.
Covers syntax, patterns, the standard library, and major package usage.

## Scope

- Python language syntax and semantics
- Standard library usage (os, pathlib, dataclasses, ...)
- Major packages (pandas, numpy, requests, ...) usage
- Python-based scripting patterns

## Out of scope

- AI/ML model training, data science analysis → AI vault or a dedicated project vault
- Web frameworks (FastAPI, Django) — consider a dedicated vault
- Coding style, clean-code principles → AI_Coding vault

## Directory structure

Contents/
  Domain/
    Syntax/         <- language syntax
    StdLib/         <- standard library
    Packages/       <- external packages
    Patterns/       <- code patterns

## Tag rules

- Vault-identifying tag: `Python` (required on every note)
- Other tags follow the system default

## Session entry rules

1. Read `_STATUS.md`.
2. Check the topic folder.
```

---

## 6. Agent Composition

Decide which AI agents you will use, and place only those agents' entry-point files in the vault.

### Entry-point file per agent

| Agent | Entry-point file |
|-------|------------------|
| Claude Code | `CLAUDE.md` |
| Codex | `AGENTS.md` |

Don't create files for agents you won't use.
Using only Claude Code? Keep only `CLAUDE.md`.

### When using multiple agents

If two agents work on the same vault, they can collide on the same files.
Split ownership as recommended below.

| Agent | Primary area |
|-------|--------------|
| Claude Code | Vault structure changes, script dev, rules/skills authoring, multi-vault work |
| Secondary agent | Single-vault note edits, repetitive tasks, background cleanup |

The following files must be edited by one agent only — concurrent edits risk data loss.

- `_STATUS.md`
- `_WORKSPACE_VERSION.md`
- `.obsidian/**`
- `_VAULT-INDEX.md`

---

## 7. Plugin Management

Obsidian plugins are managed centrally in AIHubVault and propagated via sync.

### Install / change policy

- Install, remove, or configure plugins **only in AIHubVault**.
- Don't install directly into an individual vault's `.obsidian/plugins/`.
- After the change, run sync to propagate to the rest.

### Core plugins (cannot be removed)

These are required for system functionality.

| Plugin | Role |
|--------|------|
| local-rest-api | Agent ↔ Obsidian communication |
| dataview | Data queries and views |
| templater | Note templates |
| linter | Note-format auto-cleanup |

### Adding custom plugins

Add any additional plugins you need.

1. Open AIHubVault in Obsidian.
2. Settings → Community plugins → install.
3. Run sync to propagate.

To disable a specific plugin in a specific vault, declare it in that vault's `CLAUDE.md`.

```markdown
## Plugin exceptions

- Excalidraw: disabled in this vault
```

---

## 8. Understanding the Distribution Sync

Know what updates overwrite vs. what they leave alone.

### core vs custom namespaces

```
.claude/rules/core/      <- may be overwritten on update (system rules)
.claude/rules/custom/    <- not touched by updates (your rules preserved)

.claude/commands/core/   <- may be overwritten on update (system skills)
.claude/commands/custom/ <- not touched by updates (your skills preserved)
```

**Anything you add or modify goes in `custom/` — only then will updates preserve it.**

### Per-vault files (not part of the distribution sync)

These are unique per vault and are never overwritten by updates.

- `CLAUDE.md` (per-vault role)
- `_STATUS.md` (per-vault status)
- `_VAULT-INDEX.md` (per-vault folder map)
- `_Standards/CONTENTS_SPEC.md` (per-vault content scope)

### Recommended update order

1. Pull updates (core/ files refresh).
2. Check `_ROOT_VERSION.md` for the changes.
3. Review for conflicts with your custom/ files.
4. Adjust custom/ as needed.

---

## References

- Vault routing keywords: root `CLAUDE.md` > Vault entry protocol
- Rule injection structure & context window optimization: [context-optimization.md](context-optimization.md)
- Consolidated core rules (note writing, session exit, edit mode, etc.): `.claude/rules/core/_essentials.md`
- Vault creation details: `.claude/rules-archive/vault-individualization.md` (Read when `/create-vault` Skill invoked)
- Skill Router: `.claude/rules/core/_skill-router.md`
