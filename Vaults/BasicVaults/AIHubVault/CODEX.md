# CODEX.md — AIMindVault Codex Instructions

> This file is auto-loaded by the OpenAI Codex VSCode extension at session start.
> Detailed rules are split by module under `.codex/rules/`.

---

## Role

Codex's role in this project:
- Structuring, contract documents, and Vault organization
- Bulk edits (tag normalization, Juggl block insertion, etc.)
- Documenting and normalizing what Claude (Claudian) designs

---

## Session start order (mandatory)

```
1. This file (CODEX.md) — auto-loaded
2. .codex/rules/never-do.md     ← must read
3. _WORKFLOW.md
4. _STATUS.md
5. .codex/AGENT_STATUS.md
```

> Skipping step 2 has caused encoding accidents and file corruption in the past (twice).

---

## Absolute prohibitions (memorize immediately)

### Encoding
```powershell
# Forbidden — breaks Korean markdown
Get-Content *.md | Set-Content *.md
Get-Content *.md -Raw | ... | Set-Content
Add-Content *.md "..."

# Allowed — fixed UTF-8
$t = [System.IO.File]::ReadAllText($p, [Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($p, $t, [Text.UTF8Encoding]::new($false))
```

### Bulk edits
- Never replace across all files at once.
- Always follow: Dry-run → 3-file sample → visual check → full run.

---

## Edit completion gate (mandatory)

After every note edit:
```powershell
node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
```
Do not report completion until `POST_EDIT_REVIEW_BAD=0`.

---

## Rule file list

| File | Contents |
|------|----------|
| `.codex/rules/never-do.md` | Detailed list of prohibitions |
| `.codex/rules/note-writing.md` | Frontmatter and Juggl rules |
| `.codex/rules/bulk-edit-safety.md` | 5-step protocol for bulk edits |

## Playbooks (procedures)

| File | When to use |
|------|-------------|
| `.codex/playbooks/juggl-insert.md` | Single or bulk Juggl block insertion |
| `.codex/playbooks/session-end.md` | Pre-session-end checklist |

---

## Edit-mode separation (mandatory)

Every edit belongs to exactly one of two modes. Mixing is forbidden.

- **`[Domain]` mode**: modify only `Domain/**` content. Forbidden to touch `_Standards/`, `_tools/`, `.claude/`, `.codex/`, or vault root files.
- **`[workspace]` mode**: modify vault infrastructure (`_Standards/`, `_tools/`, `.claude/`, `.codex/`, `Tags/`, vault root files). Forbidden to touch `Domain/**` content bodies.
- Declare the mode at the start of work. Declare explicitly when switching.
- Details: `_WORKFLOW.md` § 6).

---

## Top 3 priorities

1. Confirm conventions > speed
2. Minimal edits > bulk edits
3. Verification complete > fast completion reports

---

## Core project paths

| Path | Purpose |
|------|---------|
| `_WORKFLOW.md` | Full operational rules |
| `_STATUS.md` | Current progress |
| `_VAULT-INDEX.md` | Document location map |
| `.codex/AGENT_STATUS.md` | Codex work status |
