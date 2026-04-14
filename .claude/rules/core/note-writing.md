# Note Writing Pattern (Mandatory)

> Applies to all vaults.

## Language

- Default: the user's primary language (English in this distribution).
- Keep code, identifiers, and paths in their original form.

## Date Format

- `YYYY-MM-DD` only.

## Document Structure

- One H1 title.
- Use H2/H3 to organize when needed.
- Internal links use `[[WikiLinks]]`.
- **Wikilinks required** (mandatory): every new note must contain at least one `[[wikilink]]` to a related note in the same vault. The goal is connecting notes so the AI can explore via link_graph from multiple angles.
- Wikilinks resolve by filename, so filename rules (no URI-reserved characters, no emoji) are a prerequisite.

## Frontmatter (Required)

- Every note starts with YAML frontmatter (`---`).
- `type`, `tags` (must include the vault tag), and `updated` or `created` are required.
- `agent`: record **every** agent that has worked on the note — not just the latest, but a cumulative list.
  - Single: `agent: claude`
  - Multiple: `agent: [claude, codex]` or YAML list form.
- When creating a new folder, register it in `_VAULT-INDEX.md`'s root structure.

## Frontmatter `type` Rules (Mandatory)

### Format

- **kebab-case**: lowercase with hyphens. `study-note` ✓, `StudyNote` ✗, `study_note` ✗.
- **Singular**: `standard` ✓, `standards` ✗.
- **No `-note` suffix**: `knowledge` ✓, `knowledge-note` ✗ (the type itself already implies a note).

### Core Type List

Pick from the list below when writing a note. If none fit, propose a new type to the user and register it after approval.

#### Content Types

| Type | Purpose |
|------|---------|
| `study-note` | Notes from external material (video, doc, lecture) |
| `knowledge` | Domain knowledge — original thinking, experience-based insight |
| `design` | Design docs — system / structure / architecture |
| `plan` | Plans — task plans, roadmaps, schedules |
| `research` | Research — investigation, analysis, comparison |
| `reference` | Reference — organized external references, migration logs |
| `report` | Reports — work results, review outcomes |
| `spec` | Specs — detailed feature/system specifications |
| `guide` | Guides — installation / operation / usage |
| `concept` | Concept docs — early ideas, direction exploration |
| `memo` | Short memos — fleeting notes, quick captures |

#### Issue Management Types

| Type | Purpose |
|------|---------|
| `issue` | Issue record — bug, request, problem |
| `issue-index` | Issue index — list of issues |
| `issue-spec` | Issue spec — per-issue implementation detail |
| `issue-design` | Issue design — resolution design |
| `issue-report` | Issue resolution report — outcome, postmortem |
| `debug-design` | Debug design — debugging process and fix design |

#### Temporary Types

| Type | Purpose |
|------|---------|
| `temp-draft` | Temporary draft — WIP documents, work-in-progress snapshots |
| `temp-review` | Temporary review — one-off review / checklist |

#### Vault Structure Types

| Type | Purpose |
|------|---------|
| `standard` | Vault standard doc — rules / terms / styles under `_Standards/` |
| `folder-index` | Folder index — `Domain.md`, `Project.md`, etc. (folder navigation TOC) |

### Vault-Specific Types

If a vault needs its own types, declare them in that vault's `CLAUDE.md`:

```markdown
## Dedicated Types
| Type | Purpose |
|------|---------|
| `plugin-analysis` | Detailed plugin analysis |
| `system-flow` | System flow diagram |
```

- Vault-specific types must not collide with core type names.
- If another vault starts using the same type, consider promoting it to core.

### Agent Type-Selection Flow (Mandatory)

1. Pick a type from the core list.
2. If the vault's `CLAUDE.md` declares dedicated types, include them as candidates.
3. If nothing fits → propose a new type to the user.
4. On approval → register in the vault `CLAUDE.md` (vault-specific) or this list (universal).
5. **Never use an unregistered type on your own.**

## Frontmatter `tags` Rules

### Role of Tags

Tags are for **content-based fine-grained classification and search keywords** only. Note type is handled by `type`; broad subject area is handled by the vault name and folder structure.

### Default Format

The system default is below. Users can override per vault via a `## Tag Rules` section in the vault's `CLAUDE.md`.

- **Proper nouns**: preserve original casing — `Unity`, `AI`, `Obsidian`, `Claude`, `Notion`, `Blender`, `CapCut`, `DOTS`, `MCP`.
- **Everything else**: kebab-case (lowercase + hyphens) — `skill-system`, `plugin-dev`, `game-design`.
- **Flat only**: no hierarchical tags (`/` separator) — `doc/design` ✗ → `design` or an appropriate kebab-case tag.
- **Singular**: `systems` ✗ → `system`.

### What Counts as a Proper Noun

Limited to product names, service names, framework names, and acronyms:
- ✓: `Unity`, `AI`, `Obsidian`, `Claude`, `Notion`, `Blender`, `CapCut`, `DOTS`, `MCP`, `Juggl`.
- ✗: `GameSystem` → `game-system`, `SkillSystem` → `skill-system`, `StyleGuide` → `style-guide`.

### Vault-Identifier Tags (Discouraged)

Using the vault name as a tag is discouraged — the indexer's `vault` field plus the file path already identify it.
- Discouraged: `CombatToolKit`, `AIMindVault`, `TileMapToolKit`, etc. as tags.
- If you intentionally want the vault tag, declare it in the vault's `CLAUDE.md`.

### User Override

Users who prefer a different tag format declare it in the vault's `CLAUDE.md`:

```markdown
## Tag Rules
- Use PascalCase (e.g. `GameDesign`, `SkillSystem`)
- Allow hierarchical tags (e.g. `unity/dots`, `design/system`)
```

When a vault `CLAUDE.md` declares tag rules, those rules take precedence over the default for that vault.

### Agent Tag-Selection Flow

1. If the vault's `CLAUDE.md` has tag rules, follow them.
2. Otherwise, use the default format above.
3. Pick specific keywords that actually classify the note's content.
4. Reuse existing tags with the same meaning rather than creating near-duplicates.
5. Do not add tags that duplicate the vault name or folder name.
6. Only add tags that add search value — tags attached to every note are useless for search.

## Markdown Bold Rules

- No `**text(paren)**` form — Obsidian doesn't render the bold and the `**` shows literally.
- If you need a parenthetical next to bold, move the parens outside: `**text** (paren)` or `**text**: paren explanation`.
- Same for bold with inline code: `**text (\`code\`)**` → `**text**: \`code\``.

## Expression Rules

- No metaphors or figurative expressions. Task names, titles, and descriptions must describe their content directly.
  - Bad: "house cleaning", "planting seeds", "building the skeleton".
  - Good: "pre-sale QA", "initial data entry", "basic structure creation".
- This is strictest for task-management entries (Notion DB, checklists) — a third party must grasp the meaning immediately.

## H1 Title Rules (Mandatory)

- **No URI-reserved characters**: `#`, `%`, `&`, `?`, `+` — breaks indexer `title` field, Obsidian internal links, and Notion sharing.
- **No emoji** — unstable in indexer parsing, search ranking, and external integrations. If you need visual emphasis, use Obsidian's icon (`icon` property) or frontmatter `aliases`.
- **Alternates**: `C#` → `CSharp`, `C++` → `CPP`, `Q&A` → `QnA`.
- H1 is the source of the filename, indexer `title`, and wikilink display name — this rule is non-negotiable.

## Filename Rules

- No URI-reserved characters in filenames: `#`, `%`, `&`, `?`, `+`.
  - In Obsidian URIs and internal links, `#` is interpreted as a heading separator and breaks the link.
  - Details: ObsidianDev vault `20260319_Obsidian_URI_Hash_issue_research.md`.
- No emoji in filenames — cross-OS compatibility, terminal output, and script parsing all become unstable.
- Alternates: `C#` → `CSharp`, `C++` → `CPP`, `Q&A` → `QnA`.
- Use frontmatter `aliases` for readability.

## Forbidden

- No duplicate conclusions in the same document.
- Do not present unsettled content as settled.
