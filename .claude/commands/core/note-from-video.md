# /note-from-video — Video → Vault-Note Conversion Pipeline

> A standardized pipeline that takes a video URL and produces a structured note.
> Targets platforms supported by yt-dlp (YouTube, Vimeo, etc.).

Input: $ARGUMENTS

## Pipeline

### Step 1: Collect metadata

- Use yt-dlp to extract video metadata (title, channel, duration, chapters).
- Command: `yt-dlp --dump-json "URL" | jq '{title, channel, duration, chapters}'`
- If chapters are absent, try to extract timestamps from the description.

### Step 2: Acquire subtitles

Try in order:

1. **Manual subtitles (target language)**: `yt-dlp --list-subs "URL"` → if available, download.
2. **Auto-generated (target language)**: download auto-generated target-language subs if no manual.
3. **Auto-generated (English → target language)**: download English subs if no target-language is available.
4. **No subtitles**: capture only the description via Chrome MCP and report to the user.

Download command:
```bash
yt-dlp --write-sub --write-auto-sub --sub-lang en --sub-format srt --skip-download -o "$TEMP/aimind_yt_sub/%(id)s" "URL"
```

### Step 3: Subtitle cleanup

- Read the SRT, drop timecodes, merge duplicate sentences.
- Correct obvious mis-recognitions in auto-generated subtitles (only when context is unambiguous).
- Record any corrections at the bottom of the note (transparency).

### Step 4: Vault routing

- Decide the target vault from the video's topic keywords (see the root CLAUDE.md vault-entry protocol).
- Use the vault the user specified, if any.
- If ambiguous, confirm with the user.
- Place under the target vault's `Contents/Domain/` (use the topic subfolder if one exists).

### Step 5: Structure the note

Use the video's chapter layout, but apply these principles:

- **H1**: `{core topic}` (refine the video title to a core concept).
- **Key summary**: condense the video into 3–5 lines (top of the note).
- **Body**: split into H2 sections by chapter or topic transition.
- **Each section**: core concept → details → table / comparison (if applicable).
- **Closing**: related materials, recommended resources, wikilinks.

Frontmatter:
```yaml
---
type: domain
tags:
  - [vault tag]
  - [topic tags]
source: [video URL]
source_title: [original video title]
source_channel: [channel name]
created: YYYY-MM-DD
agent: claude
---
```

Include a Juggl embed (filename-based).

### Step 6: Quality verification

- Run post-edit review after authoring the note.
- Mark unclear bits caused by subtitle mis-recognition with `[?]`.

### Step 7: Cleanup

- Delete `$TEMP/aimind_yt_sub/` temp files.
- Confirm deletion before reporting completion.

## Beginner-Note Option

If the user requests "for beginners" or "easy version":
- Add parenthetical glosses for jargon.
- Reinforce with analogies / examples.
- Bold the key points.
- Use tables and comparisons aggressively.

## On Failure

| Situation | Response |
|-----------|----------|
| yt-dlp not installed | Tell the user how to install it |
| No subtitles | Use description + chapters as far as possible; state the limit |
| Private / deleted video | Report immediately |
| SRT parse failure | Retry with VTT format |
