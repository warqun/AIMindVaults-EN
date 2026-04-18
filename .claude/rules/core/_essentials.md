# Essentials (Mandatory · Always Loaded)

> Applies to every session regardless of task type.
> Domain-specific rules are loaded on trigger via `_skill-router.md`.
> See the originals in `.claude/rules-archive/` for full detail.

## 1. Report Language

- All replies to the user are in **English by default**.
- Keep code, filenames, paths, technical terms, and identifiers in their original form.
- Respond in another language only when the user explicitly requests it.
- Translation / rewrite deliverables for distribution (SellingVault) are written in the target language.

## 2. Token Economy (Mandatory)

### Content Indexer First (Mandatory)

When searching notes in a vault, **always use the indexer first**. Do not run full Grep/Glob scans without consulting the indexer.

```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index search -r "{vault-path}" -q "query"
# -t <tag>, --type <type>, -f compact -n 5
```

Fallback conditions: `vault_index.json` missing / indexer returns 0 but existence is likely / non-content files (`.obsidian/`, `_tools/`).

### Delegate Terminal Execution

- Present a confident command → user executes → consume the result, move on.
- No self-debugging loops (run → fail → retry).
- Exception: user explicitly says "run it yourself."

### Prohibited

| Prohibited | Alternative |
|------------|-------------|
| Broad file searches (full scan) | Indexer → confirm path with user |
| Reading large files whole | Only the required line range |
| Re-reading the same file | Reuse the first read |
| Self-debugging loops | Propose a fix, let the user run |
| Unnecessary checks / confirmations | Skip what is already known |

## 3. Vault Routing

- Before creating a note / content, check the **root `_STATUS.md` vault registry** and pick the right vault.
- Also consult the keyword-inference block in root `CLAUDE.md`.
- **BasicContentsVault is off-limits**: it is the clone template for AIHubVault deployment. No direct content work. Use via `/create-vault` skill only.

### Unregistered Vault

Register it immediately in the root `_STATUS.md` vault registry (name, type, content description, path, working agent).

### First Access to a Vault — Build Index (Mandatory)

If `vault_index.json` is missing, build it:

```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault-path}"
```

### Consult Vault CLAUDE.md When Routing Is Ambiguous

When the category alone is not enough, check the candidate vault's CLAUDE.md — "scope" and "not in scope" sections.

## 4. Edit Mode Separation (Critical)

Every edit belongs to **one of `[Contents]` or `[workspace]`**. No mixing.

- `[Contents]` — `Contents/**` content only. No edits to `_Standards/`, `_tools/`, `.codex/`, `.claude/`, or vault-root files.
- `[workspace]` — `_Standards/`, `_tools/`, `.codex/`, `.claude/`, or vault-root files only. No edits to `Contents/**`.

Within Contents mode: branch to `[Contents/Domain]` (knowledge) or `[Contents/Project]` (tasks).

### [workspace] mode — AIHubVault-Only (Mandatory)

- Workspace edits happen **only in AIHubVault**. Other vaults receive them via `node cli.js sync`.
- `.obsidian/` changes are also workspace edits. Do not install plugins directly in individual vaults.

**Workspace edit order (mandatory):**
1. Modify the file.
2. **Immediately** append a version entry in AIHubVault's `_WORKSPACE_VERSION.md` (at most +1 per day, `YYYYMMDDNNNN`).
3. Then test / deploy / sync.

### Root-Level Edits — Version Log (Mandatory)

- Changes to multi-vault root (`.claude/`, `.antigravity/`, root configuration files) are logged in `_ROOT_VERSION.md`.
- Format: `R` + 3-digit counter (`R001`).
- Add to the top of the table.

## 5. Post-Edit Review (Mandatory)

Right after a note edit completes:

```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" review -r "{vault-path}" -s Contents
```

- Do not report completion before `POST_EDIT_REVIEW_BAD=0`.
- **A note task is done only after content indexing finishes.**
  - Default path: on pass `review` calls `index build -i` automatically → confirm `POST_EDIT_INDEX_UPDATED=1`.
  - If `POST_EDIT_INDEX_SKIPPED=1` or the index did not update, rebuild manually:

```bash
node "{vault-path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault-path}" -i
```

Obsidian CLI first: for lookups / searches / history recovery, try `node cli.js bridge` before direct file parsing.

## 6. Note Writing (Frontmatter · H1 · Filename)

### Frontmatter Required

- Every note begins with YAML frontmatter (`---`).
- Required: `type`, `tags`, and `updated` or `created`.
- `agent`: record the **accumulated** agents (not only latest). Multiple: `[claude, codex]`.

### `type` Rules

- **kebab-case**, **singular**, **no `-note` suffix** (`knowledge` OK / `knowledge-note` NO).
- Core type list (canonical: `.claude/rules-archive/note-writing.md` § "Core Type List"):
  - Content: `study-note`, `knowledge`, `design`, `plan`, `research`, `reference`, `report`, `spec`, `guide`, `concept`, `memo`
  - Issues: `issue`, `issue-index`, `issue-spec`, `issue-design`, `issue-report`, `debug-design`
  - Temporary: `temp-draft`, `temp-review`
  - Structural: `standard`, `folder-index`
- Declare vault-specific types in that vault's `CLAUDE.md`.
- Do not invent unregistered types — propose to the user and register first.

### `tags` Rules (Default Format)

- **Proper nouns**: keep original spelling (`Unity`, `AI`, `Obsidian`, `Claude`, `MCP`).
- **Others**: kebab-case (`skill-system`, `plugin-dev`).
- **Flat only**: no `/` hierarchy.
- **Singular**: not `systems` → `system`.
- Vault-identifier tags are discouraged (the indexer's `vault` field identifies).
- If the vault's `CLAUDE.md` declares tag rules, those take precedence.

### H1 Title · Filename (Mandatory)

- Reserved URI characters are banned: `#`, `%`, `&`, `?`, `+`.
- No emojis.
- Replacements: `C#` → `CSharp`, `C++` → `CPP`, `Q&A` → `QnA`.
- Use frontmatter `aliases` for readability.

### Wikilink Required (Mandatory)

- A new note must contain at least one `[[WikiLink]]` to a related note in the same vault.
- Filenames drive resolution, so filename rules must be respected.

### Markdown Bold Rule

- No `**text(parens)**` — Obsidian does not render `**` adjacent to `(`.
- Place parentheses outside bold: `**text** (parens)` or `**text**: parens`.

### Expression Rules

- No metaphors / analogies. Task names and titles describe content directly.
- Dates: `YYYY-MM-DD` only.

### Prohibited

- Duplicating a conclusion within the same document.
- Stating unresolved content as final.

## 7. Session Exit (Mandatory)

### Update _STATUS.md (Required)

At session end, update the working vault's `_STATUS.md` **directly**:
- **Now**: finished / in-progress work
- **Next**: next continuation task
- **Blocked**: blockers (or "none")
- **Decisions**: decisions made (`(YYYY-MM-DD)` format)

Also update the working-agent date for the vault in the root `_STATUS.md` registry (`agent / YYYY-MM-DD`). Add the entry if missing.

**Do not end a session without updating both vault and root.**

### Session Handoff Note (Required)

- Claude → `_SESSION_HANDOFF_CLAUDE.md`
- Codex → `_SESSION_HANDOFF_CODEX.md`

Each agent updates **only its own file**. Keep only the latest pass (no history accumulation).

Record: work summary (1–3 lines), per-vault changes (path-focused), decisions (`(YYYY-MM-DD)`), next-session first task, cautions.

### Linking Per-Vault and Root Handoffs (Required)

When writing a `_SESSION_HANDOFF_{agent}.md` in an individual vault, leave a reference in the root handoff's **per-vault changes** section:

```markdown
### {vault-name} (`{vault-path}`)
- Detailed handoff: see `{vault-path}/_SESSION_HANDOFF_{agent}.md`
- One-line summary
```

## 8. References (Source Rules)

This document consolidates the always-loaded core. See originals for detail / background / incident rules:

- `.claude/rules-archive/token-optimization.md` — token economy detail
- `.claude/rules-archive/session-exit.md` — session exit detail
- `.claude/rules-archive/note-writing.md` — full note writing (type list, tag rules, frontmatter details)
- `.claude/rules-archive/vault-routing.md` — vault routing detail
- `.claude/rules-archive/post-edit-review.md` — Post-Edit Review detail
- `.claude/rules-archive/edit-mode-separation.md` — edit mode detail
