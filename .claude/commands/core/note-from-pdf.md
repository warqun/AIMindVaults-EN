# /note-from-pdf — PDF → Vault-Note Conversion Pipeline

> Convert a local PDF or a PDF URL into a structured note.

Input: $ARGUMENTS

## Pipeline

### Step 1: Acquire and read the PDF

**Local file:**
- Read directly via the `Read` tool (PDF is supported).
- For 10+ pages, the `pages` parameter is required (max 20 pages per request).
- For large PDFs, inspect the table of contents first, then read only the key pages.

**URL:**
- Confirm the download with the user (filename, source).
- After approval, download to `$TEMP/aimind_pdf/`.
- Read after download.

**Page strategy:**
1. Read pages 1–3 first (TOC / overview).
2. Pick key sections from the TOC.
3. Read only the selected pages (token saving).
4. If the entire PDF must be read, report to the user and proceed.

### Step 2: Extract the core content

- Use the TOC / structure when available.
- **Distill 3–5 main claims / concepts.**
- For figures / diagrams, describe them in text.
- Skip appendices, bibliography, and index (mention separately if needed).

### Step 3: Vault routing

- Decide the target vault from the PDF's topic keywords.
- Use the vault the user specified, if any.
- If ambiguous, confirm with the user.

### Step 4: Structure the note

- **H1**: refined-core-concept title.
- **Key summary**: condense the document into 3–5 lines.
- **Body**: follow the source's chapter / section structure but reorganize when useful.
  - Each section: concept → details → table / comparison.
- **Related**: wikilinks, source info.

Frontmatter:
```yaml
---
type: domain
tags:
  - [vault tag]
  - [topic tags]
source: [file path or URL]
source_title: [document title]
source_author: [author]
created: YYYY-MM-DD
agent: claude
---
```

Include a Juggl embed.

### Step 5: Quality verification

- Run post-edit review.
- If page range was limited, note the possibility of omissions.

### Step 6: Cleanup

- If downloaded from a URL, delete `$TEMP/aimind_pdf/`.
- Local files are kept (do not delete the source).

## Large-PDF Strategy

| PDF size | Strategy |
|----------|----------|
| ~10 pages | Read in full |
| 10–50 pages | TOC → pick key sections → read selectively |
| 50+ pages | Confirm scope of interest with the user → read only that scope |

## Copyright Rules

- Same as `note-from-article`: re-state in your own words; one direct quote up to 15 words.

## On Failure

| Situation | Response |
|-----------|----------|
| Encrypted PDF | Report and ask for the password |
| Scanned-image PDF (OCR needed) | Try `Read`; if it fails, report |
| File-path error | Confirm the correct path with the user |
| Very large file (200+ pages) | Ask the user to narrow the range |
