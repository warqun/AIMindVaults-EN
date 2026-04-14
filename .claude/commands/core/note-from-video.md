# /note-from-video — Video → Vault Note Pipeline

> A structured pipeline that takes a video URL and produces a well-formed note.
> Targets yt-dlp-supported platforms (YouTube, Vimeo, etc.).

Input: $ARGUMENTS

## Pipeline Stages

### Stage 1: Collect metadata

- Pull video metadata via yt-dlp (title, channel, duration, chapters).
- Command: `yt-dlp --dump-json "URL" | jq '{title, channel, duration, chapters}'`
- If there are no chapters, try extracting timestamps from the video description.

### Stage 2: Acquire subtitles

Try in priority order:

1. **Manual subtitles (user's language)**: `yt-dlp --list-subs "URL"` → download if present.
2. **Auto-generated (user's language)**: if no manual track, grab the auto-generated track.
3. **Auto-generated (source language)**: if the user's language isn't available, fall back to the source language.
4. **No subtitles**: use Chrome MCP to capture only the description, and report the limitation to the user.

Download command:
```bash
yt-dlp --write-sub --write-auto-sub --sub-lang en --sub-format srt --skip-download -o "$TEMP/aimind_yt_sub/%(id)s" "URL"
```

### Stage 3: Clean the subtitles

- Read the SRT, strip timecodes, merge duplicate lines.
- Correct obvious mis-recognitions in auto-generated subtitles (only when context makes the intended word unambiguous).
- Log the corrections at the bottom of the note (transparency).

### Stage 4: Route to a vault

- Choose the target vault based on topic keywords (see root `CLAUDE.md` entry protocol).
- Use the user's specified vault if given.
- If ambiguous, ask the user.
- Place under `Contents/Domain/` of the target vault (use a topic sub-folder if one exists).

### Stage 5: Structure the note

Organize around chapters, with these principles:

- **H1**: `{core topic}` — refined to the key concept, not the raw video title.
- **Summary**: compress the whole video into 3–5 lines (top of the note).
- **Body**: split into H2 sections by chapter or topic transition.
- **Each section**: concept → concrete explanation → table/comparison (if relevant).
- **Closing**: related material, recommended resources, wikilinks.

Frontmatter:
```yaml
---
type: domain
tags:
  - [vault-tag]
  - [topic-tags]
source: [video URL]
source_title: [original title]
source_channel: [channel name]
created: YYYY-MM-DD
agent: claude
---
```

Include a Juggl embed (filename-based).

### Stage 6: Quality check

- Run post-edit review after writing.
- Mark any parts rendered unclear by subtitle mis-recognition with `[?]`.

### Stage 7: Cleanup

- Delete the `$TEMP/aimind_yt_sub/` temp files.
- Report completion after deletion is confirmed.

## Beginner-Note Option

If the user asks for "beginner-friendly" / "simple":
- Add parenthetical definitions to technical terms.
- Strengthen analogies and examples.
- Bold the key takeaways.
- Use tables and comparisons aggressively.

## Failure Handling

| Situation | Response |
|-----------|----------|
| yt-dlp not installed | Guide the user through installation |
| No subtitles | Organize from description + chapters; state the limit |
| Video private/deleted | Report immediately |
| SRT parse fail | Retry with VTT format |
