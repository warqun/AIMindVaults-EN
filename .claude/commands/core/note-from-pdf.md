# /note-from-pdf — PDF → Vault Note Pipeline

> Convert a local PDF file or a PDF URL into a structured note.

Input: $ARGUMENTS

## Pipeline Stages

### Stage 1: Acquire and read the PDF

**Local file:**
- Read directly with the Read tool (PDF supported).
- Over 10 pages requires the `pages` parameter to specify a range (max 20 pages/request).
- For large PDFs, check the ToC first → selectively read key pages.

**URL:**
- Ask the user to confirm the download (show filename, source).
- On approval, download into `$TEMP/aimind_pdf/`.
- Read after download.

**Paging strategy:**
1. Read pages 1–3 first (ToC / overview).
2. Select key-section pages from the ToC.
3. Read only the selected pages (token saving).
4. If a full read is required, report to the user first.

### Stage 2: Extract the core content

- Use ToC / structure when available.
- **Compress main claims/concepts into 3–5 points.**
- For figures/diagrams, describe the content in prose.
- Exclude appendices, bibliography, index (mention separately if relevant).

### Stage 3: Route to a vault

- Choose the target vault by topic keyword.
- Use the user's specified vault if given.
- If ambiguous, ask the user.

### Stage 4: Structure the note

- **H1**: title refined to the core concept.
- **Summary**: compress the whole document into 3–5 lines.
- **Body**: reference the source's chapter/section structure; restructure if needed.
  - Each section: concept → concrete detail → table/comparison.
- **Related**: wikilinks, source info.

Frontmatter:
```yaml
---
type: domain
tags:
  - [vault-tag]
  - [topic-tags]
source: [file path or URL]
source_title: [document title]
source_author: [author]
created: YYYY-MM-DD
agent: claude
---
```

Include a Juggl embed.

### Stage 5: Quality check

- Run post-edit review.
- If you read only a restricted page range, disclose the possible omissions.

### Stage 6: Cleanup

- For URL-downloaded PDFs, delete `$TEMP/aimind_pdf/`.
- Local files stay in place (do not delete).

## Strategy for Large PDFs

| Size | Strategy |
|------|----------|
| ~10 pages | Read all |
| 10–50 pages | ToC → pick key sections → selective read |
| 50+ pages | Ask the user which range; read only that |

## Copyright Rules

- Same as `/note-from-article`: restatement in your own words; direct quotes ≤ 15 words, limit one.

## Failure Handling

| Situation | Response |
|-----------|----------|
| Encrypted PDF | Report to user, request password |
| Scanned-image PDF (OCR needed) | Try Read; report on failure |
| File path error | Ask user for the correct path |
| Very large file (200+ pages) | Ask the user to narrow the scope |
