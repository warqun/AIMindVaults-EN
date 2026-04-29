# /juggl-note — Create a Standard Note with a Juggl Embed

> Multi-vault: include the target vault as part of the argument or create the note in the currently-worked vault.

Goal: $ARGUMENTS

Run in this order:

1) Decide the target vault + title / location
- If the vault is unspecified, use the currently-worked vault.
- If the title is unspecified, build one core noun phrase from the user's input.
- Default location: `{vault path}/Contents/Domain/temp/`. If the user gives a path, use that.

2) Create the note
- Filename: `[Title].md`
- Default frontmatter:
```yaml
---
tags:
  - AIMindVault
  - [DomainTag]
type: note
updated: YYYY-MM-DD
agent: claude
---
```

3) Body skeleton
- One H1 title
- Juggl embed directly under the title:
```juggl
local: [Title]
```
- Sections:
  - `## Context`
  - `## Key Points`
  - `## Decision / Action`
  - `## Links`

4) Link rules
- Add 1–3 related notes as `[[WikiLink]]`
- Do not leave blank links — write a "to-link later" one-line note instead

5) Template-first
- When possible, use `{vault path}/_Standards/NoteTemplates/TEMPLATE_JugglNote.md`.

6) Closing
- Report the created path on one line
- Suggest `/note-link` if appropriate
