---
name: create-video-note
description: A Codex-exclusive procedure that retrieves metadata and subtitles from a video URL to create a structured Obsidian note
---

# Create Video Note

**Purpose**: Extract key content from YouTube or other `yt-dlp`-supported videos and create a structured Obsidian note.
**Scope**: Codex-exclusive procedure. Operates independently without sharing `.claude/commands/`.
**Core Rule**: Temporary files must only be handled in `$env:TEMP`. Nothing other than the final output should remain in the vault.

## Step 1: Confirm Input and Target Vault

- Verify inputs:
  - Video URL
  - Whether a target vault is specified
  - Any additional requirements such as beginner-level explanations, translation, or summary depth
- If no vault is specified, route based on topic keywords.
- If routing is ambiguous, ask the user briefly rather than saving to a guessed location.

## Step 2: Create Temporary Working Folder

Create a folder at `$env:TEMP\aimind_video_note_{yyyyMMdd_HHmmss}`.

## Step 3: Retrieve Metadata

- Use `yt-dlp --dump-json "<URL>"` to obtain the following:
  - Title
  - Channel name
  - Duration
  - Upload date
  - Chapters
  - Description
- If no chapters exist, use timestamps from the description as supplementary structure.

## Step 4: Retrieve Subtitles

- Try in the following priority order:
  1. Manual Korean subtitles
  2. Auto-generated Korean subtitles
  3. English subtitles
  4. If no subtitles at all, organize using only the description and chapters
- Downloads must only occur within the temporary folder.
- Use whichever subtitle format is actually obtained (SRT or VTT).

## Step 5: Clean Subtitles

- Remove timecodes, meta headers, and HTML/VTT tags.
- Merge consecutive duplicate sentences from auto-generated subtitles.
- Only correct misrecognitions that are contextually obvious.
- For uncertain parts, leave `[?]` or a comment rather than forcing corrections.

## Step 6: Structure Key Content

- Refine H1 based on the core topic rather than copying the video title verbatim.
- Place a 3-5 line key summary at the top of the note.
- Divide the body into H2 sections based on chapters or topic transitions.
- Each section should prioritize the following order:
  - Core concepts
  - Detailed explanations
  - Tips, comparisons, application points
- If subtitle quality is low, briefly note limitations and corrections at the bottom.

## Step 7: Write the Note

- The default save location is under `Contents/Domain/` in the target vault.
- If the user requested it in a project context, use `Contents/Project/`.
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
  - video
  - [topic-tag]
source: [video URL]
source_title: [original title]
source_channel: [channel name]
created: YYYY-MM-DD
agent: codex
---
```

## Step 8: Review

- Check that sections with unreliable subtitle quality are not used as core evidence in the body.
- Verify wikilinks, frontmatter, and Juggl placement as required by note-writing rules.
- Before completion, run the post-edit review below and confirm `POST_EDIT_INDEX_UPDATED=1`.
```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" review -r "{vault_path}" -s Contents
```
- If `POST_EDIT_INDEX_SKIPPED=1` or `POST_EDIT_INDEX_UPDATED=0`, run manual indexing with the command below and verify again.
```bash
node "{vault_path}/.sync/_tools/cli-node/bin/cli.js" index build -r "{vault_path}" -i
```

## Step 9: Cleanup

- Delete the temporary folder.
- Do not consider the task complete until deletion is confirmed and content indexing is done.

## Failure Handling

- `yt-dlp` not installed: Immediately inform that installation is required.
- No subtitles: Proceed with a reduced summary based on description and chapters, and note the limitation.
- Video private/deleted: Stop immediately and report.
- Subtitle encoding issues: Retry with a different subtitle format; if that also fails, document the cause only.
