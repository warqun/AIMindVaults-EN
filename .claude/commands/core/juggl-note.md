# /juggl-note — Create Standard Note with Juggl Embed

> Multi-vault: Include the target vault in the arguments, or create in the currently active vault.

Goal: $ARGUMENTS

Execute in the following order:

1) Determine target vault + title/location
- If no vault is specified, use the currently active vault.
- If no title is provided, create one title from the key noun phrases in the user's input.
- Default location is `{vault-path}/Contents/Domain/temp/`, but use the specified path if the user provides one.

2) Create the note
- Filename: `[Title].md`
- Frontmatter defaults:
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

3) Write the body skeleton
- One H1 heading
- Juggl embed immediately below the heading:
```juggl
local: [Title]
```
- Sections:
  - `## Context`
  - `## Key Points`
  - `## Decision / Action`
  - `## Links`

4) Link handling rules
- Add 1-3 related notes as `[[WikiLink]]`s
- Do not leave blank spaces for uncertain links; instead, leave a one-line memo saying "to be linked later"

5) Template priority rule
- If available, prefer using `{vault-path}/_Standards/NoteTemplates/TEMPLATE_JugglNote.md`.

6) Completion guidance
- Report the created path to the user in one line
- Suggest using `/note-link` if needed
