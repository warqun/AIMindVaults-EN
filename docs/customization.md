# AIMindVaults User Customization Guide

This document explains how to extend and adjust AIMindVaults to fit your environment.
Starting from the default setup (AIHubVault + BasicContentsVault), you can add and modify as needed.

---

## 1. Adding Vaults

When a new topic or project comes up, add a vault to manage knowledge separately.

### Creating a Vault

Clone `BasicContentsVault` as a template.

```bash
node cli.js clone -t "<target_path>" -n "<vault_name>"
```

Example:

```bash
node cli.js clone -t "Vaults/Domains_Dev/Python" -n "Python"
```

Do not use manual folder copying (`Copy-Item`, `cp`, `xcopy`). Automated steps such as plugin settings, sync folder handling, and indexer initialization will be skipped.

### Choosing a Category

Select the parent folder that matches the vault's purpose.

| Category | Path | Criteria |
|----------|------|----------|
| Domains_* | `Vaults/Domains_<area>/` | Knowledge accumulation on a specific topic (tools, languages, techniques, etc.) |
| Lab_* | `Vaults/Lab_<area>/` | Knowledge accumulation + hands-on development/experimentation hybrid |
| Projects_* | `Vaults/Projects_<area>/` | Active project execution and work management |
| Personal | `Vaults/Personal/` | Personal records, diary, retrospectives |

Examples: Python language knowledge → `Vaults/Domains_Dev/Python/`, game development project → `Vaults/Projects_Game/MyGame/`

### Required Steps After Creation

Complete the following 6 steps in order after creating a vault.

**1. Individualize CLAUDE.md**

Open `CLAUDE.md` at the vault root and define the role, collection scope, and tag rules for the vault.
See [5. Vault CLAUDE.md Writing Guide](#5-vault-claudemd-writing-guide) below for details.

**2. Initialize _STATUS.md**

Open `_STATUS.md` at the vault root and fill in the initial state (Now, Next, Blocked).

**3. Register in the Root CLAUDE.md Vault Registry**

Add the new vault to the vault registry table in `C:\AIMindVaults\CLAUDE.md`.

```markdown
| MyVault | `Vaults/Domains_Dev/MyVault/` | Role description | active |
```

**4. Add Routing Keywords to Root CLAUDE.md**

In the same file, add keywords to the "Vault Entry Protocol > Keyword Inference" section so the vault can be discovered.

```markdown
- "Python", "pandas", "pip" → Vaults/Domains_Dev/Python
```

**5. Register in Obsidian Vault Manager**

Obsidian app > Vault manager > "Open folder as vault" > Select vault path.
Do not use `obsidian://open?path=` URI for unregistered vaults — it causes very slow app startup.

**6. Initial Index Build**

Build the index to enable note search within the vault.

```bash
node cli.js index build -r "<vault_path>"
```

Example:

```bash
node cli.js index build -r "Vaults/Domains_Dev/Python"
```

---

## 2. Customizing Rules

You can add or adjust behavioral rules that agents (Claude Code, etc.) follow.

### core vs custom

| Location | Path | Nature |
|----------|------|--------|
| Core rules | `.claude/rules/core/` | Essential system rules. May be overwritten on update. Modification not recommended. |
| Custom rules | `.claude/rules/custom/` | User-specific. Not subject to distribution sync. Freely add/modify. |

If your settings must persist through updates, always write them in `custom/`.

### Adding Custom Rules

Create a markdown file inside `.claude/rules/custom/`.

File format:

```markdown
# Rule Title (Mandatory or Optional)

> Scope description.

## Rules

- Specific rule content
- Specific rule content
```

`Mandatory` means the agent must follow the rule; `Optional` is a recommendation.

Example — MCP server integration rule (`mcp-notion.md`):

```markdown
# Notion MCP Usage (Mandatory)

> Applied when working with Notion.

## Rules

- Use the Notion MCP tools first for page read/write operations.
- Direct API calls are only allowed when MCP tools cannot accomplish the task.
```

Example — Project-specific coding style (`python-style.md`):

```markdown
# Python Coding Style (Mandatory)

> Applied when writing Python code.

## Rules

- Specify type hints for all function parameters and return values.
- Write docstrings in Google style.
- Include a module description docstring at the top of each file.
```

---

## 3. Customizing Skills

Skills are slash commands invoked with `/skill-name` in Claude Code.
Creating skills for frequently used workflows reduces repetitive instructions.

### core vs custom

| Location | Path | Nature |
|----------|------|--------|
| Core skills | `.claude/commands/core/` | Essential system skills. Modification not recommended. |
| Custom skills | `.claude/commands/custom/` | User-specific. Freely add. |

### Adding Custom Skills

Create a markdown file inside `.claude/commands/custom/`.
The filename becomes the skill name. `/my-skill` → `my-skill.md`

Example — Weekly review skill (`weekly-review.md`):

```markdown
# /weekly-review — Write Weekly Review

Create a weekly review note in Vaults/Personal/Diary/.

## Procedure

1. Determine the date range for the current week (Monday–Sunday)
2. Filename: `YYYY-MM-DD_weekly-review.md` (based on Monday's date)
3. Frontmatter: type=memo, tags=[diary, weekly-review]
4. Sections: What I did this week / What went well / What to improve / Next week's plan
5. Run post_note_edit_review
```

---

## 4. Overriding Tag Rules

The default tag format applies system-wide, but you can use a different format per vault.

### Default Tag Format

- General keywords: kebab-case (lowercase + hyphen) — `skill-system`, `game-design`
- Proper nouns (product names, frameworks): Preserve original spelling — `Unity`, `Notion`, `AI`
- No hierarchical tags (`/` separator)
- Singular form — `systems` X → `system` O

### Per-Vault Override

Adding a `## Tag Rules` section to the vault's `CLAUDE.md` makes that format take precedence within the vault.

```markdown
## Tag Rules

- Use PascalCase (e.g., `GameDesign`, `SkillSystem`)
- Allow hierarchical tags (e.g., `unity/dots`, `design/system`)
- Vault identifier tag: `GameDesign` (required on all notes)
```

If no such section is declared, the system default tag format applies.

---

## 5. Vault CLAUDE.md Writing Guide

The vault's `CLAUDE.md` is the first file an agent reads when entering the vault.
The more clearly you define the vault's role, the more accurately the agent places content.

### Required Sections

```markdown
# <VaultName>

## Role

This vault accumulates knowledge about <topic>.
<Describe the role clearly in 1-2 lines>

## Collection Scope

Content that belongs in this vault:

- <Target 1>
- <Target 2>
- <Target 3>

## Out of Scope

The following content should be routed to other vaults:

- <Excluded item> → <Target vault name>
- <Excluded item> → <Target vault name>

## Directory Structure

Contents/
  Domain/         <- Domain knowledge notes
    <TopicFolder>/
  Project/        <- Project-related notes (optional)

## Tag Rules

- Vault identifier tag: `<VaultTag>` (required on all notes)
- Other tags follow the system default format

## Session Entry Rules

1. Read `_STATUS.md` (understand current progress)
2. Check the target folder
```

### Declaring Vault-Specific Types

If content doesn't fit the core types (study-note, knowledge, design, plan, etc.), declare vault-specific types.

```markdown
## Vault-Specific Types

| Type | Purpose |
|------|---------|
| `recipe` | Recipe document |
| `experiment` | Cooking experiment record |
```

Vault-specific type names must not conflict with core types.

### Example Template — Domain Vault

```markdown
# Python

## Role

Accumulates knowledge about the Python language and its ecosystem.
Covers syntax, patterns, standard library, and key package usage.

## Collection Scope

- Python language syntax and behavior
- Standard library usage (os, pathlib, dataclasses, etc.)
- Key package usage (pandas, numpy, requests, etc.)
- Python-based scripting patterns

## Out of Scope

- AI/ML model training, data science analysis → AI vault or separate project vault
- Web frameworks (FastAPI, Django) → Consider splitting into a separate vault
- Coding style, clean code principles → AI_Coding vault

## Directory Structure

Contents/
  Domain/
    Syntax/         <- Language syntax
    StdLib/         <- Standard library
    Packages/       <- External packages
    Patterns/       <- Code patterns

## Tag Rules

- Vault identifier tag: `Python` (required on all notes)
- Other tags follow the system default format

## Session Entry Rules

1. Read `_STATUS.md`
2. Check the relevant topic folder
```

---

## 6. Agent Configuration

Decide which AI agents to use, and place only the entry point files for those agents in each vault.

### Agent Entry Point Files

| Agent | Entry Point File |
|-------|-----------------|
| Claude Code | `CLAUDE.md` |
| Codex | `CODEX.md` |

Do not create files for agents you don't use.
For example, if you only use Claude Code, only `CLAUDE.md` is needed.

### When Using Multiple Agents

Using two agents together can cause conflicts if they modify the same file simultaneously.
The following ownership separation is recommended.

| Agent | Responsible Area |
|-------|-----------------|
| Claude Code | Vault structure changes, script development, rule/skill authoring, multi-vault tasks |
| Secondary agent | Note editing within a single vault, repetitive tasks, background cleanup |

The following files should only be modified by one agent at a time. Simultaneous edits risk data loss.

- `_STATUS.md`
- `_WORKSPACE_VERSION.md`
- `.obsidian/**`
- `_VAULT-INDEX.md`

---

## 7. Plugin Management

Obsidian plugins are centrally managed in AIHubVault and propagated to all vaults through sync.

### Plugin Installation/Modification Principles

- Plugin installation, removal, and configuration changes should be done **only in AIHubVault**.
- Do not install directly into individual vaults' `.obsidian/plugins/`.
- After making changes, run sync to automatically propagate to all other vaults.

### Core Plugins (Cannot Be Removed)

The following plugins are essential for system functionality.

| Plugin | Role |
|--------|------|
| local-rest-api | Communication between agents and Obsidian |
| dataview | Data queries and views |
| templater | Note templates |
| linter | Automatic note formatting |

### Adding Custom Plugins

You can freely add any plugins beyond the core set.

1. Open AIHubVault in Obsidian
2. Settings > Community plugins > Install plugin
3. Run sync to propagate to other vaults

If you want to disable a specific plugin in a particular vault, specify it in that vault's `CLAUDE.md`.

```markdown
## Plugin Exceptions

- Excalidraw: Not used in this vault (disabled)
```

---

## 8. Understanding Distribution Sync

You need to understand the distinction so your settings don't get overwritten when receiving system updates.

### core vs custom Namespace

```
.claude/rules/core/      <- May be overwritten on update (system rules)
.claude/rules/custom/    <- Not an update target (your settings preserved)

.claude/commands/core/   <- May be overwritten on update (system skills)
.claude/commands/custom/ <- Not an update target (your skills preserved)
```

**All files you add or modify should go in `custom/` to persist through updates.**

### Vault-Specific Files (Not Subject to Distribution Sync)

The following files have different content per vault, so updates will not overwrite them.

- `CLAUDE.md` (vault-specific role definition)
- `_STATUS.md` (vault-specific progress status)
- `_VAULT-INDEX.md` (vault-specific folder structure)
- `_Standards/CONTENTS_SPEC.md` (vault-specific content scope)

### Recommended Update Procedure

1. Receive update (core/ files refreshed)
2. Check `_ROOT_VERSION.md` to understand what changed
3. Review for conflicts with your custom/ files
4. Adjust custom/ files if needed

---

## Reference

- Vault routing keywords: Root `CLAUDE.md` > Vault Entry Protocol
- Note writing rules: `.claude/rules/core/note-writing.md`
- Detailed vault creation rules: `.claude/rules/core/vault-individualization.md`
- Session exit routine: `.claude/rules/core/session-exit.md`
