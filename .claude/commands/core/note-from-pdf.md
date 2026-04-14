# /note-from-pdf — PDF to Vault Note Conversion Pipeline

> Converts a local PDF file or PDF from a URL into a structured note.

Input: $ARGUMENTS

## Pipeline Stages

### Stage 1: Acquire and Read PDF

**For local files:**
- Read directly with the Read tool (PDF supported)
- For PDFs exceeding 10 pages, the `pages` parameter must be specified (max 20 pages/request)
- For large PDFs, check the table of contents first -> selectively read only key pages

**For URLs:**
- Request download confirmation from the user (specify filename and source)
- After approval, download to `$TEMP/aimind_pdf/`
- Read with the Read tool after download

**Page strategy:**
1. Read pages 1-3 first (identify table of contents/overview)
2. Select key section pages based on table of contents
3. Read only selected pages (token conservation)
4. If the entire document must be read, report to the user before proceeding

### Stage 2: Extract Key Content

- Leverage table of contents/structure if available
- **Compress core arguments/concepts into 3-5 points**
- If figures/charts are present, describe their content in text
- Exclude appendices, references, and indexes (mention separately if needed)

### Stage 3: Vault Routing

- Determine the target vault based on PDF topic keywords
- If the user specified a vault, use it as-is
- If ambiguous, confirm with the user

### Stage 4: Note Structuring

- **H1**: A refined title based on the core concept
- **Key Summary**: Compress the entire document into 3-5 lines
- **Body**: Reference the original's chapter/section structure, restructuring as needed
  - Each section follows: concept explanation -> specific details -> tables/comparisons
- **Related Materials**: WikiLinks, original document information

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

Include Juggl embed.

### Stage 5: Quality Verification

- Run post-edit review
- If page range was limited during reading, explicitly note potential omissions

### Stage 6: Cleanup

- If downloaded from a URL, delete `$TEMP/aimind_pdf/`
- Keep local files intact (do not delete)

## Large PDF Strategy

| PDF Size | Strategy |
|----------|----------|
| ~10 pages | Read in full |
| 10-50 pages | Table of contents -> select key sections -> selective reading |
| 50+ pages | Confirm scope of interest with user -> read only that range |

## Copyright Rules

- Same as note-from-article: restructure in your own words, direct quotation limited to 15 words, 1 instance

## Failure Handling

| Situation | Response |
|-----------|----------|
| Encrypted PDF | Report to user, request password |
| Scanned image PDF (OCR needed) | Attempt with Read; report on failure |
| File path error | Confirm correct path with user |
| Very large file (200+ pages) | Request scope reduction |
