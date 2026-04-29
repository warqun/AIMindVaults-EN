# Essentials (Mandatory · Always Loaded)

> Applies to every session, regardless of work type.
> Domain-specific rules are loaded on trigger via `_skill-router.md`.
> For detailed clauses, refer to the originals under `.claude/rules-archive/`.

## 1. Report Language

- Every report / response to the user is in **English by default**.
- Code, filenames, paths, technical terms, and identifiers stay in **their original English form**.
- Reply in another language only when the user explicitly requests it.
- Translation / rewrite outputs targeting the SellingVault distribution are written in the target language.

## 2. Token Saving (Mandatory)

### Content Indexer First (Mandatory)

When searching for notes inside a vault, **always use the indexer first**. Do not run a full Grep / Glob scan without the indexer.

```bash
node "{vault path}/.sync/_tools/cli-node/bin/cli.js" index search -r "{vault path}" -q "query"
# -t <tag>, --type <type>, -f compact -n 5
```

Fallback conditions: no `vault_index.json` / indexer returns 0 hits but existence is highly likely / non-content files (`.obsidian/`, `_tools/`).

### Terminal Execution Delegation

- Present confident code → user executes → take the result and proceed.
- Do not run a self-debugging loop (run → fail → retry).
- Exception: when the user explicitly says "run it yourself".

### Forbidden

| Forbidden | Alternative |
|-----------|------------|
| Broad file searches (full scans) | Indexer → confirm path with the user |
| Reading entire large files | Read only the needed line range |
| Reading the same file repeatedly | Reuse the first read's result |
| Self-debugging loops | Propose a fix, then ask the user to run it |
| Unnecessary checks / verification | Skip what you already know |

## 3. Vault Routing

- Before creating a note / content, check the **root `_STATUS.md` vault registry** → choose the appropriate vault.
- Also consult the keyword-inference block in the root `CLAUDE.md`.
- **`BasicContentsVault` is forbidden**: it is the AIHubVault clone template; no direct content work. It is exclusively for the `/create-vault` skill.

### When an Unregistered Vault is Discovered

Register it in the root `_STATUS.md` vault registry immediately (vault name, type, content description, path, working agent).

### First Access to a Vault — Index Build (Mandatory)

If `vault_index.json` is missing, build it:

```bash
node "{vault path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault path}"
```

### Reference the Candidate Vault's CLAUDE.md When Routing

When the category alone is not decisive, check the candidate vault's CLAUDE.md "Collection scope" and "Out of scope" sections.

## 4. Edit-Mode Separation (Critical)

Every edit is **either `[Contents]` or `[workspace]`**. No mixing.

- `[Contents]` — `Contents/**` content only. Do not modify `_Standards/`, `_tools/`, `.codex/`, `.claude/`, or vault-root files.
- `[workspace]` — `_Standards/`, `_tools/`, `.codex/`, `.claude/`, vault-root only. Do not modify `Contents/**`.

Inside Contents mode: branch into `[Contents/Domain]` (knowledge) or `[Contents/Project]` (work).

### `[workspace]` Mode — Which Hub to Edit From (Multi-Hub, Mandatory)

**After 2026-04-20 Multi-Hub Phase 1**: the Hub is split into the Core Hub (`CoreHub/`) + Preset Hubs (e.g., `AIHubVault/` with `hubId=default`).

| Edit Target | Edit Location | Propagation |
|-------------|--------------|-------------|
| Core layer (`.sync/_tools/`, `.sync/_Standards/Core/`, `.sync/schemas/`, Core 6 plug-ins) | **CoreHub only** | CoreHub → Preset Hub (`core-sync-all`) → satellites (`sync`) |
| Custom layer (Custom under `.obsidian/plugins/`, `.claude/rules/custom/`, etc.) | **AIHubVault (Preset)** | Preset → satellites (existing sync) |
| Root `.claude/rules/core/`, `.claude/commands/core/` | **AIMindVaults root** | Auto-inherited via Claude CWD ancestry + `deploy` to SellingVault |
| Per-vault `CLAUDE.md`, `_STATUS.md` | The vault itself | No propagation (per-vault) |

**Core editing workflow (mandatory):**
1. Modify the file in CoreHub.
2. **Immediately** run `node .sync/_tools/cli-node/bin/cli.js bump-version -m "change description" --broadcast`.
   - `--broadcast` auto-chains `core-sync-all` → push to all Preset Hubs.
   - **Do not report completion before this command runs** (D1 enforced).
3. The Preset Hub `_WORKSPACE_VERSION.md` does not auto-update — only when notifying satellites of Preset changes is a separate manual `bump-version` required.

**Preset Hub (AIHubVault) workspace edit order (mandatory):**
1. Modify the file (Custom layer only).
2. **Immediately** record the version in AIHubVault's `_WORKSPACE_VERSION.md` (`bump-version -m "..."`).
3. Satellites receive it on the next pre-sync.

**Hard forbid:**
- Editing the Core layer (CORE_PATHS) on a Preset Hub or satellite. Always go through CoreHub.
- Manually creating `.sync/hub-marker.json` or `.hub_marker` on a satellite (it would self-misclassify as a Hub).

### Root-Level Edits — Version Recording (Mandatory)

- For changes at the multi-vault root (`.claude/`, `.antigravity/`, root config files), record in `_ROOT_VERSION.md`.
- Format: `R` + 3-digit sequence (`R001`).
- Add at the top of the table.

## 5. Post-Edit Review (Mandatory)

Right after a note edit completes:

```bash
node "{vault path}/.sync/_tools/cli-node/bin/cli.js" review -r "{vault path}" -s Contents
```

- Do not report completion before confirming `POST_EDIT_REVIEW_BAD=0`.
- **A note task is not finished until content indexing has completed.**
  - Default path: `review` passes → `index build -i` is auto-invoked → confirm `POST_EDIT_INDEX_UPDATED=1`.
  - If `POST_EDIT_INDEX_SKIPPED=1` or no update, run a manual index:

```bash
node "{vault path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault path}" -i
```

Prefer the Obsidian CLI: for inspect / search / history recovery, try `node cli.js bridge` first; parse files directly only when the CLI result is insufficient.

## 6. Note Authoring (Frontmatter · H1 · Filename)

### Required Frontmatter

- Every note begins with YAML frontmatter (`---`).
- Required: `type`, `tags`, and either `updated` or `created`.
- `agent`: cumulative record of working agents (not just the latest). Use a list when multiple: `[claude, codex]`.

### `type` Rule

- **kebab-case**, **singular**, **`-note` suffix forbidden** (`knowledge` ✓ / `knowledge-note` ✗).
- Core type list (originals at `.claude/rules-archive/note-writing.md § Core type list`):
  - Content: `study-note`, `knowledge`, `design`, `plan`, `research`, `reference`, `report`, `spec`, `guide`, `concept`, `memo`
  - Issue: `issue`, `issue-index`, `issue-spec`, `issue-design`, `issue-report`, `debug-design`
  - Temporary: `temp-draft`, `temp-review`
  - Structure: `standard`, `folder-index`
- Vault-specific types are declared in that vault's `CLAUDE.md`.
- Do not use unregistered types arbitrarily — propose to the user, then register.

### `tags` Rule (default format)

- **Proper nouns**: keep the original spelling (`Unity`, `AI`, `Obsidian`, `Claude`, `MCP`).
- **Otherwise**: kebab-case (`skill-system`, `plugin-dev`).
- **Flat only**: no `/` hierarchy.
- **Singular**: `systems` ✗ → `system`.
- A vault-identifier tag is discouraged (the indexer's `vault` field identifies it).
- If the vault's `CLAUDE.md` declares a "Tag rule", that takes precedence.

### H1 Title · Filename (mandatory)

- URI-reserved characters forbidden: `#`, `%`, `&`, `?`, `+`.
- Emoji forbidden.
- Substitutions: `C#` → `CSharp`, `C++` → `CPP`, `Q&A` → `QnA`.
- Use frontmatter `aliases` for readability.

### Wikilink Required (mandatory)

- When creating a new note, include at least one `[[wikilink]]` to a related note in the same vault.
- Resolution is filename-based, so following the filename rules is a prerequisite.

### Markdown Bold Rule

- `**text(parens)**` is forbidden — Obsidian fails to render the `**`.
- Place parentheses outside the bold: `**text** (parens)` or `**text**: parens`.

### Style

- No metaphor or simile. Task names / titles describe the content directly.
- Date format: `YYYY-MM-DD` only.

### Forbidden

- Duplicate conclusions in the same document.
- Stating uncertain content as if it were settled.

## 7. Session End (Mandatory)

### `_STATUS.md` Update (required)

At session end, **directly update** the worked vault's `_STATUS.md`:
- **Now**: completed / in-progress work
- **Next**: the next item to continue with
- **Blocked**: blockers (write "None" if none)
- **Decisions**: decisions made (`(YYYY-MM-DD)` format)

Also update the working-agent date in the root `_STATUS.md` vault registry's row for that vault (`agent-name / YYYY-MM-DD`). Add a row if it is missing.

**Do not end the session without updating both the vault's and the root's `_STATUS.md`.**

### Session-Handoff Note (required)

- Claude → `_SESSION_HANDOFF_CLAUDE.md`
- Codex → `_SESSION_HANDOFF_CODEX.md`

Each agent updates **only its own file**. Keep just the latest entry (no history accumulation).

Record: 1–3-line task summary, per-vault changes (path-centric), decisions (`(YYYY-MM-DD)`), the first task for the next session, cautions.

### Per-Vault Handoff and Root Handoff Linkage (required)

When writing a `_SESSION_HANDOFF_{agent}.md` for a specific vault, leave a reference in the root handoff's "Per-vault changes" section:

```markdown
### {vault name} (`{vault path}`)
- Detailed handoff: see `{vault path}/_SESSION_HANDOFF_{agent}.md`
- 1-line summary
```

## 8. References (original rules)

This document consolidates the rules below into the always-loaded core. For detailed clauses, background, and Incident Rules, see the originals:

- `.claude/rules-archive/token-optimization.md` — token-saving details
- `.claude/rules-archive/session-exit.md` — session-end details
- `.claude/rules-archive/note-writing.md` — note authoring (full type list, tag rules, frontmatter details)
- `.claude/rules-archive/vault-routing.md` — detailed routing rules
- `.claude/rules-archive/post-edit-review.md` — Post-Edit Review details
- `.claude/rules-archive/edit-mode-separation.md` — edit-mode details
- `.claude/rules-archive/report-language.md` — report-language original
