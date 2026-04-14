# CODEX.md — AIMindVault Codex Instructions

> This file is automatically loaded by the OpenAI Codex VSCode extension at session start.
> Detailed rules are modularized in `.codex/rules/`.

---

## Role

The role of Codex in this project:
- Dedicated to **structuring, contract documents, and Vault organization**
- Bulk modification tasks (tag normalization, Juggl block insertion, etc.)
- Documenting and formalizing content designed by Claude (Claudian)

---

## Session Start Order (Mandatory)

```
1. This file (CODEX.md) — auto-loaded
2. .codex/rules/never-do.md     <- must read
3. _WORKFLOW.md
4. _STATUS.md
5. .codex/AGENT_STATUS.md
```

> Skipping step 2 will cause encoding incidents and file corruption to recur. (Occurred twice previously)

---

## Absolute Prohibitions (Memorize Immediately)

### Encoding
```powershell
# Prohibited — causes markdown character corruption
Get-Content *.md | Set-Content *.md
Get-Content *.md -Raw | ... | Set-Content
Add-Content *.md "..."

# Allowed — UTF-8 fixed
$t = [System.IO.File]::ReadAllText($p, [Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($p, $t, [Text.UTF8Encoding]::new($false))
```

### Bulk Modifications
- Replacing all files at once is prohibited
- Must follow: Dry-run -> 3 samples -> visual verification -> full execution

---

## Edit Completion Gate (Mandatory)

After all note edits:
```powershell
node ".sync/_tools/cli-node/bin/cli.js" review -r . -s Contents
```
Do not report completion before confirming `POST_EDIT_REVIEW_BAD=0`.

---

## Rule File List

| File | Content |
|------|---------|
| `.codex/rules/never-do.md` | Absolute prohibitions (detailed) |
| `.codex/rules/note-writing.md` | Frontmatter, Juggl rules |
| `.codex/rules/bulk-edit-safety.md` | Bulk edit 5-step protocol |

## Playbooks (Procedures)

| File | When to Use |
|------|-------------|
| `.codex/playbooks/juggl-insert.md` | Single/bulk Juggl block insertion |
| `.codex/playbooks/session-end.md` | Pre-session-end checklist |

---

## Edit Mode Separation (Mandatory)

All edits belong to one of two modes. Mixing is prohibited.

- **`[Domain]` mode**: Modify only `Domain/**` content. Modifying `_Standards/`, `_tools/`, `.claude/`, `.codex/`, `_forge/`, vault root files is prohibited.
- **`[workspace]` mode**: Modify vault infrastructure (`_Standards/`, `_tools/`, `.claude/`, `.codex/`, `_forge/`, `Tags/`, vault root files). Modifying `Domain/**` body content is prohibited.
- Mode declaration is required at work start. Explicit declaration required when switching.
- Detailed rules: `_WORKFLOW.md` § 6)

---

## 3 Priority Principles

1. Rule verification > Speed
2. Minimal modification > Bulk modification
3. Verification complete > Quick completion report

---

## Key Project Paths

| Path | Purpose |
|------|---------|
| `_WORKFLOW.md` | Full operational rules |
| `_STATUS.md` | Current progress status |
| `_VAULT-INDEX.md` | Document location map |
| `.codex/AGENT_STATUS.md` | Codex work status |
