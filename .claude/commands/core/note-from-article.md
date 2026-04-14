# /note-from-article — Web Article/Text to Vault Note Conversion Pipeline

> Converts a web article, blog post, document URL, or user-pasted text into a structured note.

Input: $ARGUMENTS

## Pipeline Stages

### Stage 1: Acquire Content

If a URL is provided, attempt in priority order:

1. **WebFetch**: Extract body text using URL + prompt
2. **Chrome MCP**: If WebFetch fails -> navigate -> get_page_text
3. **User paste**: If all above fail, request the user to paste the body text

If text is provided directly -> skip Stage 1.

Metadata extraction:
- Title, author/source, publication date, URL

### Stage 2: Identify Key Content

- Read the original text and **compress the core arguments/concepts into 3-5 points**
- Separate supplementary content (ads, author bios, CTAs) from core content
- Reference the original structure (sections, subheadings) if present, but do not copy it as-is

### Stage 3: Vault Routing

- Determine the target vault based on the article's topic keywords
- If the user specified a vault, use it as-is
- If ambiguous, confirm with the user
- Place under the target vault's Contents/Domain/

### Stage 4: Note Structuring

- **H1**: A refined title based on the core concept (not the original title verbatim)
- **Key Summary**: Compress the entire article into 3-5 lines (top of the note)
- **Body**: H2 sections organized by topic. Summarize and restructure the original while respecting copyright
  - Direct quotation limited to one instance of 15 words or fewer
  - All other content must be restated in your own words
- **Comparisons/Tables**: Organize comparable content into tables
- **Related Materials**: WikiLinks, original article link

Frontmatter:
```yaml
---
type: domain
tags:
  - [vault-tag]
  - [topic-tags]
source: [URL or source]
source_title: [original title]
source_author: [author/publisher]
created: YYYY-MM-DD
agent: claude
---
```

Include Juggl embed.

### Stage 5: Quality Verification

- Run post-edit review
- Self-check for key omissions compared to the original

## Copyright Rules

- Do not copy the original text verbatim
- The note is **a restructured expression of the original's core concepts in your own words**
- Quotations must be 15 words or fewer, use quotation marks, limited to 1 instance
- No continuous paraphrasing exceeding 30 words

## Failure Handling

| Situation | Response |
|-----------|----------|
| Page requires login | Request the user to paste the body text |
| Page requires JS rendering | Switch to Chrome MCP |
| Content is too short | Organize as-is; report to user if supplementation is needed |
| Multilingual content | Translate to the user's language while keeping key terms in the original language |
