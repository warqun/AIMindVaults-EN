# /note-from-article — Web Article / Text → Vault Note Pipeline

> Convert a web article, blog, document URL, or user-pasted text into a structured note.

Input: $ARGUMENTS

## Pipeline Stages

### Stage 1: Acquire the content

For a URL, try in priority order:

1. **WebFetch**: URL + prompt → body extraction.
2. **Chrome MCP**: if WebFetch fails → navigate → get_page_text.
3. **User paste**: if all the above fail, ask the user to paste the body.

If text is supplied directly → skip stage 1.

Extract metadata: title, author/source, publish date, URL.

### Stage 2: Grasp the core content

- Read the source and **compress the main claims/concepts into 3–5 points**.
- Separate peripheral content (ads, author bio, CTAs) from the essentials.
- If the source has structure (sections, subheadings), reference it — but don't copy verbatim.

### Stage 3: Route to a vault

- Choose the target vault by topic keyword.
- Use the user's specified vault if given.
- If ambiguous, ask the user.
- Place under the target vault's `Contents/Domain/`.

### Stage 4: Structure the note

- **H1**: title refined to the core concept (not the raw article title).
- **Summary**: compress the whole article into 3–5 lines (top of the note).
- **Body**: H2 sections by topic. Summarize and restructure — respect copyright.
  - Allow only one direct quote, up to 15 words.
  - Paraphrase everything else in your own words.
- **Comparison/table**: tabulate contrastable content.
- **Related**: wikilinks, original link.

Frontmatter:
```yaml
---
type: domain
tags:
  - [vault-tag]
  - [topic-tags]
source: [URL or source]
source_title: [original title]
source_author: [author/outlet]
created: YYYY-MM-DD
agent: claude
---
```

Include a Juggl embed.

### Stage 5: Quality check

- Run post-edit review.
- Self-check for key omissions against the source.

## Copyright Rules

- Do not transcribe the source verbatim.
- The note is a **restatement of the source's core concepts in your own words**.
- Quotes: up to 15 words, with quotation marks, limit one.
- No continuous paraphrases longer than 30 words.

## Failure Handling

| Situation | Response |
|-----------|----------|
| Page requires login | Ask the user to paste the body |
| Page needs JS rendering | Switch to Chrome MCP |
| Content too short | Write as-is; report if reinforcement is needed |
| Multilingual content | Translate to the user's language; keep key terms alongside the original |
