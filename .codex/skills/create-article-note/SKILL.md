---
name: create-article-note
description: A Codex-exclusive procedure that organizes web articles, blog posts, document pages, or user-provided text into a structured Obsidian note
---

# Create Article Note

**Purpose**: Extract key concepts from a URL or body text and restructure them as an Obsidian note.
**Scope**: Codex-exclusive procedure. Maintained separately from Claude commands.

## Step 1: Confirm Input and Target Vault

- Verify inputs:
  - Whether it is a URL or pasted text
  - Whether a target vault is specified
  - Whether there are requirements for summary depth, translation, or beginner-level explanations
- Route the target vault based on topic.
- If ambiguous, confirm with the user before saving.

## Step 2: Obtain the Body Text

- If a URL, use the extraction method that works best for the body text.
- Extract only the page body; exclude ads, CTAs, comments, and navigation.
- If body extraction fails due to login requirements or heavy JS rendering, ask the user to provide the text.
- If possible, also obtain the following metadata:
  - Original title
  - Author or publication
  - Publication date
  - Original URL

## Step 3: Isolate Key Arguments

- Read the entire article and compress key arguments or concepts into 3-5 main axes.
- Separate peripheral content such as examples, marketing copy, and author bios from the core body.
- Use original subheadings only as reference; restructure the note as needed.

## Step 4: Design Note Structure

- Refine H1 based on core concepts rather than copying the original title.
- Place a 3-5 line key summary at the top.
- Restructure the body into H2-based topic groupings.
- Compress comparable content into tables.
- End with related wikilinks and the original source link.

## Step 5: Maintain Copyright Safety

- Do not copy long passages from the original.
- If direct quotation is needed, limit it to a single short sentence.
- Restructure everything else in your own words.
- Instead of long continuous paraphrasing, explain core concepts and structure in a fresh way.

## Step 6: Write the Note

- The default save location is under `Contents/Domain/` in the target vault.
- If in a project work context, use `Contents/Project/`.
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
  - article
  - [topic-tag]
source: [original URL or source]
source_title: [original title]
source_author: [author or publication]
created: YYYY-MM-DD
agent: codex
---
```

## Step 7: Review

- Verify that key points from the original are not missing.
- Check that no long passages were carried over from the original text.
- Verify frontmatter, Juggl, and wikilinks as required by note-writing rules.
- Before completion, run the post-edit review below and confirm `POST_EDIT_INDEX_UPDATED=1`.
```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" review -r "{vault_path}" -s Contents
```
- If `POST_EDIT_INDEX_SKIPPED=1` or `POST_EDIT_INDEX_UPDATED=0`, run manual indexing with the command below and verify again.
```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault_path}" -i
```

## Failure Handling

- Login required: Ask the user to provide the body text.
- Body too short: Organize as a short note and note the information limitation.
- Multilingual document: Organize in English, with key terms shown in the original language alongside.
- Body extraction failure: Do not just save the link; report the failure reason and what input is needed.
