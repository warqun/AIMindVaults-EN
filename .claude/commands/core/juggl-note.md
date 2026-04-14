# /juggl-note — Create a Standard Note with a Juggl Embed

> Multi-vault: include the target vault in the argument, or create in the currently-active vault.

Goal: $ARGUMENTS

Execute in this order:

1) Decide the target vault + title/location
- If no vault is specified, use the currently-active vault.
- If no title is given, derive a single-noun-phrase title from the user's input.
- Default location is `{vault-path}/Contents/Domain/temp/`; use a user-supplied path when given.

2) Create the note
- Filename: `[Title].md`
- Default frontmatter:
```yaml
---
tags:
  - [VaultTag]
  - [DomainTag]
type: note
updated: YYYY-MM-DD
agent: claude
---
```

3) Scaffold the body
- One H1 title.
- Juggl embed right below the H1:
```juggl
local: [Title]
```
- Sections:
  - `## Context`
  - `## Key Points`
  - `## Decision / Action`
  - `## Links`

4) Link rules
- Add 1–3 related notes as `[[WikiLink]]`.
- Don't leave uncertain links blank — add a "link later" one-liner memo instead.

5) Template preference
- Prefer `{vault-path}/_Standards/NoteTemplates/TEMPLATE_JugglNote.md` when it exists.

6) Closing
- Report the created path in one line.
- Suggest `/note-link` if further linking would help.
