---
name: create-pdf-note
description: A Codex-exclusive procedure that extracts key content from a local PDF or PDF URL and organizes it into a structured Obsidian note
---

# Create PDF Note

**Purpose**: Identify the key content of a PDF document and restructure it as an Obsidian note.
**Scope**: Codex-exclusive procedure. Maintained separately from the Claude pipeline.

## Step 1: Confirm Input and Target Vault

- Verify inputs:
  - Whether it is a local file path or a URL
  - Whether a target vault is specified
  - Whether a specific scope of interest or particular chapters/sections are specified
- If the topic is ambiguous, confirm with the user before saving.

## Step 2: Obtain the Document

- If it is a local PDF, use the original file as-is.
- If it is a URL, check whether downloading is permitted under current working rules; if allowed, download only under `$env:TEMP`.
- Delete PDFs downloaded from URLs after work is complete.

## Step 3: Establish a Reading Strategy

- First review the cover, overview, table of contents, and opening sections to understand the document structure.
- Default strategy by length:
  - 10 pages or fewer: Read in full
  - 10-50 pages: Selective reading based on table of contents
  - Over 50 pages: Prioritize scope of interest
- Appendices, references, and indexes are excluded from the key summary scope by default.

## Step 4: Extract Key Content

- Compress core arguments and concepts into 3-5 main axes.
- Reference chapter/section structure if useful, but do not replicate the note structure verbatim.
- Translate tables, charts, and figures into textual descriptions.
- If only partial pages were read, note the possibility of omissions in the note.

## Step 5: Design Note Structure

- Refine H1 based on core concepts rather than copying the PDF title.
- Place a 3-5 line key summary at the top.
- Restructure the body into H2 sections by chapter/section or topic groups.
- Compress comparable content into tables.
- End with related wikilinks, source information, and notes on reading scope.

## Step 6: Write the Note

- The default save location is under `Contents/Domain/` in the target vault.
- If organizing as a project document, use `Contents/Project/`.
- The note should include:
  - YAML frontmatter
  - H1
  - Juggl block
  - Key summary
  - Structured body
  - At least one related wikilink

Recommended frontmatter:

```yaml
---
type: domain
tags:
  - [vault-tag]
  - pdf
  - [topic-tag]
source: [file path or URL]
source_title: [document title]
source_author: [author]
created: YYYY-MM-DD
agent: codex
---
```

## Step 7: Review

- Verify that conclusions are not overstated relative to the actual pages read.
- Check that no long quotations or verbatim copies from the original remain.
- Verify frontmatter, Juggl, and wikilinks as required by note-writing rules.
- Before completion, run the post-edit review below and confirm `POST_EDIT_INDEX_UPDATED=1`.
```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" review -r "{vault_path}" -s Contents
```
- If `POST_EDIT_INDEX_SKIPPED=1` or `POST_EDIT_INDEX_UPDATED=0`, run manual indexing with the command below and verify again.
```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault_path}" -i
```

## Step 8: Cleanup

- Delete temporary PDFs downloaded from URLs and any intermediate files.
- Do not modify the local original PDF.

## Failure Handling

- Encrypted PDF: Inform that a password is required.
- Scanned image PDF: Note OCR quality limitations.
- Path error: Report the incorrect path and request the correct one.
- Very large PDF: Narrow the scope of interest first.
