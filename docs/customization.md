# AIMindVaults Customization Guide

This document explains how to extend and adjust AIMindVaults for your environment.
Starting from the default setup (AIHubVault + BasicContentsVault), you can add or change as much as you need.

---

## 1. Adding a Vault

When a new topic or project comes up, add a vault to keep its knowledge separated.

### Creating a vault

Clone `BasicContentsVault` as the template.

```bash
node cli.js clone -t "<target path>" -n "<vault name>"
```

Example:

```bash
node cli.js clone -t "Vaults/Domains_Dev/Python" -n "Python"
```

Do not use manual folder copying (`Copy-Item`, `cp`, `xcopy`). It skips automated steps such as plug-in settings handling, sync-folder treatment, and indexer initialization.

### Choosing a category

Pick the parent folder that matches the vault's nature.

| Category | Path | Criteria |
|----------|------|----------|
| Domains_* | `Vaults/Domains_<area>/` | Knowledge accumulation for a specific topic (tools, languages, techniques) |
| Lab_* | `Vaults/Lab_<area>/` | Knowledge accumulation + hands-on development/experiments |
| Projects_* | `Vaults/Projects_<area>/` | Real project execution and work tracking |
| Personal | `Vaults/Personal/` | Personal records, diary, retrospectives |

Examples: Python language knowledge → `Vaults/Domains_Dev/Python/`; a game-development project → `Vaults/Projects_Game/MyGame/`.

### Required steps after creation

After creating a vault, complete the following six steps in order.

**1. Individualize CLAUDE.md**

Open `CLAUDE.md` at the vault root and write the role, collection scope, and tag rules to fit this vault.
For how to fill it in, see [5. Vault CLAUDE.md authoring guide](#5-vault-claudemd-authoring-guide).

**2. Initialize _STATUS.md**

Open `_STATUS.md` at the vault root and seed the current state (Now, Next, Blocked).

**3. Register in the root CLAUDE.md vault registry**

Add the new vault to the vault-registry table in `C:\AIMindVaults\CLAUDE.md`.

```markdown
| MyVault | `Vaults/Domains_Dev/MyVault/` | Role description | active |
```

**4. Add routing keywords to the root CLAUDE.md**

In the same file's "Vault entry protocol > keyword inference" section, add keywords that should resolve to this vault.

```markdown
- "Python", "pandas", "pip" → Vaults/Domains_Dev/Python
```

**5. Register in the Obsidian Vault Manager**

Obsidian app > Vault Manager > "Open folder as vault" > select the vault path.
Do not use the `obsidian://open?path=` URI for an unregistered vault — that path is very slow.

**6. Initial index build**

Build the index so that note search inside the vault is available.

```bash
node cli.js index build -r "<vault path>"
```

Example:

```bash
node cli.js index build -r "Vaults/Domains_Dev/Python"
```

---

## 2. Customizing Rules

You can add or adjust the behaviour rules that agents (Claude Code, etc.) follow.

### core vs custom

| Location | Path | Nature |
|----------|------|--------|
| core rules | `.claude/rules/core/` | System core rules. May be overwritten on update. Editing not recommended. |
| custom rules | `.claude/rules/custom/` | User-only. Not part of deployment sync. Free to add or modify. |

If your settings must survive updates, write them under `custom/`.

### How to add a custom rule

Create a Markdown file inside `.claude/rules/custom/`.

File template:

```markdown
# Rule title (Mandatory or Optional)

> Scope description.

## Rules

- Specific rule
- Specific rule
```

`Mandatory` rules must be followed by the agent; `Optional` rules are recommendations.

Example — MCP server integration rule (`mcp-notion.md`):

```markdown
# Notion MCP Usage (Mandatory)

> Applies to Notion-related tasks.

## Rules

- Use the Notion MCP tools first for page reads/writes.
- Direct API calls are allowed only when MCP tools cannot do the job.
```

Example — per-project coding style (`python-style.md`):

```markdown
# Python Coding Style (Mandatory)

> Applies when writing Python code.

## Rules

- Annotate every function parameter and return value with type hints.
- Write docstrings in Google style.
- Include a module-description docstring at the top of each file.
```

---

## 3. Customizing Skills

Skills are slash commands invoked in Claude Code as `/skill-name`.
Turning a frequent workflow into a skill reduces repeated instructions.

### core vs custom

| Location | Path | Nature |
|----------|------|--------|
| core skills | `.claude/commands/core/` | System core skills. Editing not recommended. |
| custom skills | `.claude/commands/custom/` | User-only. Free to add. |

### How to add a custom skill

Create a Markdown file inside `.claude/commands/custom/`.
The filename becomes the skill name. `/my-skill` → `my-skill.md`.

Example — weekly retrospective skill (`weekly-review.md`):

```markdown
# /weekly-review — Weekly retrospective writer

Creates this week's retrospective note under Vaults/Personal/Diary/.

## Procedure

1. Identify this week's date range (Monday–Sunday)
2. Filename: `YYYY-MM-DD_weekly_review.md` (Monday's date)
3. Frontmatter: type=memo, tags=[diary, weekly-review]
4. Sections: This week's accomplishments / What went well / What to improve / Next week's plan
5. Run post_note_edit_review
```

---

## 4. Tag Rule Overrides

The default tag format applies system-wide, but a vault can use a different format.

### Default tag format

- General keywords: kebab-case (lowercase + hyphen) — `skill-system`, `game-design`
- Proper nouns (product/framework names): keep original spelling — `Unity`, `Notion`, `AI`
- Hierarchical tags (the `/` separator) are not allowed
- Singular form — `systems` ✗ → `system` ✓

### Per-vault override

Adding a `## Tag rules` section to a vault's `CLAUDE.md` makes that rule take precedence inside that vault.

```markdown
## Tag rules

- Use PascalCase (e.g. `GameDesign`, `SkillSystem`)
- Hierarchical tags allowed (e.g. `unity/dots`, `design/system`)
- Vault identifier tag: `GameDesign` (mandatory on every note)
```

If the section is not declared, the system default tag format applies.

---

## 5. Vault CLAUDE.md Authoring Guide

A vault's `CLAUDE.md` is the first file an agent reads on entering that vault.
The clearer the vault's role is, the more reliably the agent places content in the right location.

### Required sections

```markdown
# <Vault name>

## Role of this vault

This vault accumulates knowledge on <topic>.
<Describe the role in 1-2 sentences>

## Collection scope

Content that belongs here:

- <Inclusion target 1>
- <Inclusion target 2>
- <Inclusion target 3>

## What is not collected

The following content routes to other vaults:

- <Exclusion> → <Target vault>
- <Exclusion> → <Target vault>

## Directory structure

Contents/
  Domain/         <- Domain knowledge notes
    <topic folder>/
  Project/        <- Project-related notes (optional)

## Tag rules

- Vault identifier tag: `<vault tag>` (mandatory on every note)
- Other tags follow the system default format

## Session-entry rules

1. Read `_STATUS.md` (current progress)
2. Confirm the target work folder
```

### Declaring custom types

If you have content that does not classify well under the core types (study-note, knowledge, design, plan, etc.), declare custom types.

```markdown
## Custom types

| Type | Use |
|------|-----|
| `recipe` | Recipe document |
| `experiment` | Cooking experiment record |
```

Custom-type names must not collide with core type names.

### Example template — domain vault

```markdown
# Python

## Role of this vault

Accumulates knowledge of the Python language and its ecosystem.
Covers syntax, patterns, the standard library, and major package usage.

## Collection scope

- Python language syntax and runtime semantics
- Standard library usage (os, pathlib, dataclasses, etc.)
- Usage of major packages (pandas, numpy, requests, etc.)
- Python-based scripting patterns

## What is not collected

- AI/ML model training, data-science analysis → AI vault or a dedicated project vault
- Web frameworks (FastAPI, Django) → consider splitting to a dedicated vault
- Coding style, clean-code principles → AI_Coding vault

## Directory structure

Contents/
  Domain/
    Syntax/         <- Language syntax
    StdLib/         <- Standard library
    Packages/       <- External packages
    Patterns/       <- Code patterns

## Tag rules

- Vault identifier tag: `Python` (mandatory on every note)
- Other tags follow the system default format

## Session-entry rules

1. Read `_STATUS.md`
2. Confirm the relevant topic folder
```

---

## 6. Agent Configuration

Decide which AI agents you will use and place only the entry-point files for those agents in the vault.

### Agent entry-point files

| Agent | Entry-point file |
|-------|------------------|
| Claude Code | `CLAUDE.md` |
| Codex | `CODEX.md` |

Do not create files for agents you do not use.
Example: if you only use Claude Code, only `CLAUDE.md` is needed.

### Multi-agent usage

When two agents work side by side, they may collide on the same files.
The following ownership split is recommended.

| Agent | Area of responsibility |
|-------|------------------------|
| Claude Code | Vault structure changes, script development, rule/skill authoring, multi-vault tasks |
| Secondary agent | Single-vault note edits, repetitive tasks, background cleanup |

The following files must be edited by only one agent. Concurrent edits risk data loss.

- `_STATUS.md`
- `_WORKSPACE_VERSION.md`
- `.obsidian/**`
- `_VAULT-INDEX.md`

---

## 7. Plug-in Management

Obsidian plug-ins are managed centrally in AIHubVault and propagated to every vault by sync.

### Plug-in install / change principles

- Plug-in install, removal, and settings changes happen **only on AIHubVault**.
- Do not install directly into a satellite vault's `.obsidian/plugins/`.
- Run sync after a change to propagate it to other vaults automatically.

### Core plug-ins (cannot be removed)

The following plug-ins are required for system functionality.

| Plug-in | Role |
|---------|------|
| local-rest-api | Communication between agents and Obsidian |
| dataview | Data queries and views |
| templater | Note templates |
| linter | Automatic note formatting |

### Adding custom plug-ins

You may add any plug-ins beyond the Core plug-ins above.

1. Open AIHubVault in Obsidian
2. Settings > Community plug-ins > Install plug-in
3. Run sync to propagate to other vaults

If a particular vault should disable a particular plug-in, declare that in the vault's `CLAUDE.md`.

```markdown
## Plug-in exceptions

- Excalidraw: not used in this vault (disabled)
```

---

## 8. Understanding Deployment Sync

When you receive a system update, you should know which areas survive overwrites and which do not.

### core vs custom namespaces

```
.claude/rules/core/      <- May be overwritten on update (system rules)
.claude/rules/custom/    <- Not an update target (your settings preserved)

.claude/commands/core/   <- May be overwritten on update (system skills)
.claude/commands/custom/ <- Not an update target (your skills preserved)
```

**Anything you add or modify must live under `custom/` to survive updates.**

### Per-vault files (not part of deployment sync)

The following files differ per vault, so updates do not overwrite them.

- `CLAUDE.md` (per-vault role definition)
- `_STATUS.md` (per-vault progress)
- `_VAULT-INDEX.md` (per-vault folder structure)
- `_Standards/CONTENTS_SPEC.md` (per-vault content scope)

### Recommended update sequence

1. Pull the update (refreshes core/ files)
2. Read `_ROOT_VERSION.md` to understand the changes
3. Review whether any custom/ files conflict
4. Adjust custom/ files if needed

---

## References

- Vault routing keywords: root `CLAUDE.md` > Vault entry protocol
- Rule injection structure and context-window optimization: [context-optimization.md](context-optimization.md)
- Unified rules for note authoring, session end, edit modes, etc.: `.claude/rules/core/_essentials.md`
- Detailed vault-creation rules: `.claude/rules-archive/vault-individualization.md` (read on `/create-vault` Skill invocation)
- Skill Router: `.claude/rules/core/_skill-router.md`
