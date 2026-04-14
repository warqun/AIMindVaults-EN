# Note Writing Patterns (Mandatory)

> Applies uniformly to all vaults.

## Language

- Default language is English.
- Code, identifiers, and paths remain in their original form.

## Date Format

- Use YYYY-MM-DD format only.

## Document Structure

- One H1 title per document.
- Use H2/H3 for structure as needed.
- Use [[WikiLink]] for internal links.
- **WikiLinks required** (Mandatory): When creating a new note, include at least one `[[WikiLink]]` to a related note within the same vault. The purpose is to ensure inter-note connections so that AI can explore from multiple angles via the link_graph.
- WikiLinks are resolved based on filenames, so compliance with filename rules (no URI reserved characters or emojis) is a prerequisite.

## Frontmatter Required

- Every note must start with YAML Frontmatter (`---`).
- `type`, `tags` (including vault tag), and `updated` or `created` are required.
- `agent`: Record **all** agents that have worked on the note. This is a cumulative record, not just the most recent contributor.
  - Single: `agent: claude`
  - Multiple: `agent: [claude, codex]` or YAML list format
- When creating a new folder, register it in the `_VAULT-INDEX.md` root structure.

## Frontmatter `type` Rules (Mandatory)

### Format

- **kebab-case**: lowercase + hyphens. `study-note` O, `StudyNote` X, `study_note` X
- **Singular form**: `standard` O, `standards` X
- **No `-note` suffix**: `knowledge` O, `knowledge-note` X (the type itself implies it is a note)

### Core Type List

Select from the list below when writing notes. If a type not in the list is needed, propose it to the user for approval before registering it.

#### Content Types

| Type | Purpose |
|------|---------|
| `study-note` | Study notes from external sources (videos, documents, lectures) |
| `knowledge` | Domain knowledge — original thinking, experience-based knowledge |
| `design` | Design documents — system, structure, architecture design |
| `plan` | Plans — work plans, roadmaps, schedules |
| `research` | Research — investigation, analysis, comparison |
| `reference` | Reference materials — external reference compilation, migration records |
| `report` | Reports — work results, review outcome reports |
| `spec` | Spec documents — detailed feature/system specifications |
| `guide` | Guides — installation/operation/usage instructions |
| `concept` | Concept documents — initial ideas, direction exploration |
| `memo` | Short memos — temporary records, quick notes |

#### Issue Management Types

| Type | Purpose |
|------|---------|
| `issue` | Issue records — problem discovery, bugs, improvement requests |
| `issue-index` | Issue index — issue list management |
| `issue-spec` | Issue detailed spec — per-issue implementation specification |
| `issue-design` | Issue design — design for resolving an issue |
| `issue-report` | Issue resolution report — resolution results, post-mortem analysis |
| `debug-design` | Debug design — debugging process and resolution design |

#### Temporary Types

| Type | Purpose |
|------|---------|
| `temp-draft` | Temporary draft — incomplete document, work-in-progress snapshot |
| `temp-review` | Temporary review — one-time review/checklist |

#### Vault Structure Types

| Type | Purpose |
|------|---------|
| `standard` | Vault standard document — rules/terminology/style under `_Standards/` |
| `folder-index` | Folder index — table of contents for folder navigation such as `Domain.md`, `Project.md` |

### Vault-Specific Types

If a vault requires unique types, declare them in that vault's `CLAUDE.md`.

```markdown
## Vault-Specific Types
| Type | Purpose |
|------|---------|
| `plugin-analysis` | Detailed plugin analysis |
| `system-flow` | System flow diagram |
```

- Vault-specific types must not conflict with core type names.
- If a vault-specific type starts being used in other vaults, consider promoting it to a core type.

### Agent Type Selection Flow (Mandatory)

1. Select an appropriate type from the core type list.
2. If the vault's `CLAUDE.md` defines vault-specific types, include them as candidates.
3. If no suitable type exists, propose a new type to the user.
4. Upon approval, register it in the vault's `CLAUDE.md` if vault-specific, or in this list if general-purpose.
5. **Do not use unregistered types arbitrarily.**

## Frontmatter `tags` Rules

### Role of Tags

Tags are exclusively for **content-based detailed classification and search keywords**. Note type is handled by `type`, and major topic area is handled by the vault name and folder structure.

### Default Format

The following is the system default tag format. Users can define their own format in the `## Tag Rules` section of the vault's `CLAUDE.md` to override it.

- **Proper nouns**: Retain original casing — `Unity`, `AI`, `Obsidian`, `Claude`, `Notion`, `Blender`, `CapCut`, `DOTS`, `MCP`
- **Everything else**: kebab-case (lowercase + hyphens) — `skill-system`, `plugin-dev`, `game-design`
- **Flat only**: Hierarchical tags (`/` separator) are prohibited — `doc/design` X → `design` or appropriate kebab-case
- **Singular form**: `systems` X → `system`

### Proper Noun Criteria

Limited to product names, service names, framework names, and abbreviations:
- O: `Unity`, `AI`, `Obsidian`, `Claude`, `Notion`, `Blender`, `CapCut`, `DOTS`, `MCP`, `Juggl`
- X: `GameSystem` → `game-system`, `SkillSystem` → `skill-system`, `StyleGuide` → `style-guide`

### Vault Identification Tags (Not Recommended)

Using the vault name as a tag is not recommended. The indexer `vault` field and file path provide sufficient identification.
- Not recommended: Using `CombatToolKit`, `AIMindVault`, `TileMapToolKit`, etc. as tags
- If the user intentionally wants to keep vault tags, specify it in the vault's `CLAUDE.md`.

### User Override

If the user prefers a different tag format, declare it in the vault's `CLAUDE.md` as follows:

```markdown
## Tag Rules
- Use PascalCase (e.g., `GameDesign`, `SkillSystem`)
- Allow hierarchical tags (e.g., `unity/dots`, `design/system`)
```

When tag rules are declared in the vault's `CLAUDE.md`, those rules take precedence over the default format in that vault.

### Agent Tag Selection Flow

1. If the vault's `CLAUDE.md` has tag rules, follow them.
2. If not, apply the default format above.
3. Select specific keywords that classify the note's content.
4. If an existing tag with the same meaning already exists, reuse it.
5. Do not add tags that duplicate the vault name or folder name.
6. Assign only tags that are meaningful for search — tags that appear on every note have no search value.

## Markdown Bold Rules

- `**text(parentheses)**` format is prohibited — Obsidian does not render the bold and displays `**` literally.
- If parenthetical supplementation is needed, move it outside the bold: `**text** (parentheses)` or `**text**: parenthetical explanation`
- The same applies when inline code is inside bold: `**text (\`code\`)**` → `**text**: \`code\``

## Expression Rules

- Figurative and metaphorical expressions are prohibited. Task names, titles, and descriptions must directly describe the content.
  - Incorrect: "house cleaning", "planting seeds", "building the skeleton"
  - Correct: "pre-sale quality inspection", "initial data entry", "create basic structure"
- Strict enforcement especially for task management items (Notion DB, checklists, etc.) — must be immediately understandable by any third party.

## H1 Title Rules (Mandatory)

- **No URI reserved characters**: `#`, `%`, `&`, `?`, `+` — causes parsing errors and broken links in the indexer title field, Obsidian internal links, and Notion sharing.
- **No emojis** — unstable for indexer parsing, search ranking, and external system integration. If visual emphasis is needed, use Obsidian icons (`icon` property) or frontmatter `aliases` instead.
- **Alternative notation**: `C#` → `CSharp`, `C++` → `CPP`, `Q&A` → `QnA`
- H1 titles are the source for filenames, indexer titles, and WikiLink display names, so the above rules must be followed.

## Filename Rules

- Do not use URI reserved characters in filenames: `#`, `%`, `&`, `?`, `+`
  - `#` is interpreted as a heading separator in Obsidian URI/internal links, breaking the link
  - Details: ObsidianDev vault `20260319_Obsidian_URI_Hash_Issue_Research.md`
- Do not use emojis in filenames — instability across OS compatibility, terminal output, and script parsing.
- Alternative notation: `C#` → `CSharp`, `C++` → `CPP`, `Q&A` → `QnA`
- Maintain readability via frontmatter `aliases`

## Prohibited

- Duplicate conclusions within the same document are prohibited.
- Expressing unconfirmed content as confirmed is prohibited.
