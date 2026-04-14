# CODEX.md — AIMindVault Codex Instructions

> This file is automatically loaded by the OpenAI Codex VSCode extension at session start.
> Detailed rules are separated into modules under `.codex/rules/`.

---

## Role

Codex's role in this project:
- **Dedicated to structuring, contract documents, and Vault organization**
- Bulk editing tasks (tag normalization, Juggl block insertion, etc.)
- Documenting and normalizing content designed by Claude (Claudian)

---

## Session Start Order (Mandatory)

```
1. This file (CODEX.md) — Auto-loaded
2. .codex/rules/never-do.md     <- Must read
3. _WORKFLOW.md
4. _STATUS.md
5. .codex/AGENT_STATUS.md
```

> Skipping step 2 will cause encoding incidents and file corruption to recur. (2 past incidents)

---

## Absolute Prohibitions (Memorize Immediately)

### Encoding
```powershell
# PROHIBITED — Breaks Korean/CJK markdown
Get-Content *.md | Set-Content *.md
Get-Content *.md -Raw | ... | Set-Content
Add-Content *.md "..."

# ALLOWED — Fixed UTF-8
$t = [System.IO.File]::ReadAllText($p, [Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($p, $t, [Text.UTF8Encoding]::new($false))
```

### Bulk Edits
- Never replace all files at once with global substitution
- Must follow: Dry-run -> 3 samples -> visual check -> full run

---

## Edit Completion Gate (Mandatory)

After all note edits:
```powershell
node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
```
Do not report completion before `POST_EDIT_REVIEW_BAD=0`.

---

## Rule File List

| File | Description |
|------|-------------|
| `.codex/rules/never-do.md` | Absolute prohibition list (detailed) |
| `.codex/rules/note-writing.md` | Frontmatter, Juggl rules |
| `.codex/rules/bulk-edit-safety.md` | Bulk edit 5-step protocol |

## Playbooks (Procedures)

| File | When to Use |
|------|-------------|
| `.codex/playbooks/juggl-insert.md` | Juggl block single/bulk insertion |
| `.codex/playbooks/session-end.md` | Session end checklist |

---

## Edit Mode Separation (Mandatory)

All edits belong to one of two modes. Mixing is prohibited.

- **`[Domain]` mode**: Only modify `Domain/**` content. Modifying `_Standards/`, `_tools/`, `.claude/`, `.codex/`, `_forge/`, vault root files is prohibited.
- **`[workspace]` mode**: Modify vault infrastructure (`_Standards/`, `_tools/`, `.claude/`, `.codex/`, `_forge/`, `Tags/`, vault root files). Modifying `Domain/**` body content is prohibited.
- Mode declaration is required at work start. Switching requires explicit declaration.
- Detailed rules: `_WORKFLOW.md` section 6)

---

## 3 Priority Principles

1. Rule verification > Speed
2. Minimal edits > Bulk edits
3. Verified completion > Fast completion reports

---

## Project Key Paths

| Path | Purpose |
|------|---------|
| `_WORKFLOW.md` | Overall operational rules |
| `_STATUS.md` | Current progress status |
| `_VAULT-INDEX.md` | Document location map |
| `.codex/AGENT_STATUS.md` | Codex work status |
