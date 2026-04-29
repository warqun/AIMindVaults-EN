# /note-from-article — Web Article / Text → Vault-Note Conversion Pipeline

> Convert a web article, blog, or document URL — or text the user pastes — into a structured note.

Input: $ARGUMENTS

## Pipeline

### Step 1: Acquire content

If a URL is given, try in order:

1. **WebFetch**: extract the body via URL + prompt
2. **Chrome MCP**: if WebFetch fails → navigate → get_page_text
3. **User paste**: if the above fail, ask the user to paste the body

If text is given directly → skip step 1.

Metadata to extract:
- Title, author / source, publication date, URL

### Step 2: Identify the core content

- Read the source and **distill 3–5 main claims / concepts**.
- Separate ancillary content (ads, self-introduction, CTAs) from core content.
- Reference the source's structure (sections, subheadings) but do not copy verbatim.

### Step 3: Vault routing

- Decide the target vault by topic keywords.
- Use the vault the user specified, if any.
- If ambiguous, confirm with the user.
- Place under the target vault's `Contents/Domain/`.

### Step 4: Structure the note

- **H1**: the title refined to a core concept (not the original title verbatim).
- **Key summary**: condense the whole article into 3–5 lines (top of the note).
- **Body**: H2 sections per topic. Summarize and reorganize while respecting copyright.
  - Allow at most one direct quote of up to 15 words.
  - Re-state the rest in your own words.
- **Comparison / table**: turn comparable items into a table.
- **Related**: wikilinks and the source URL.

Frontmatter:
```yaml
---
type: domain
tags:
  - [vault tag]
  - [topic tags]
source: [URL or source]
source_title: [original title]
source_author: [author / outlet]
created: YYYY-MM-DD
agent: claude
---
```

Include a Juggl embed.

### Step 5: Quality verification

- Run post-edit review.
- Self-check whether any core point from the source is missing.

## Copyright Rules

- Do not transfer the source verbatim.
- The note is a **re-expression of the source's core ideas** in your own words.
- Quotes: at most 15 words, with quotation marks, max one quote.
- Do not paraphrase 30+ consecutive words.

## On Failure

| Situation | Response |
|-----------|----------|
| Page requires login | Ask the user to paste the body |
| JS-rendered page required | Switch to Chrome MCP |
| Content too short | Take what you have; report if reinforcement needed |
| Multilingual content | Translate to the user's language; keep core technical terms in the original alongside |
