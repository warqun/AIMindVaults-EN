# /note-from-video — Video to Vault Note Conversion Pipeline

> A standardized pipeline that receives a video URL and generates a structured note.
> Targets YouTube, Vimeo, and other platforms supported by yt-dlp.

Input: $ARGUMENTS

## Pipeline Stages

### Stage 1: Collect Metadata

- Extract video metadata with yt-dlp (title, channel, duration, chapters)
- Command: `yt-dlp --dump-json "URL" | jq '{title, channel, duration, chapters}'`
- If no chapters exist, attempt to extract timestamps from the video description

### Stage 2: Obtain Subtitles

Attempt in priority order:

1. **Manual subtitles (target language)**: `yt-dlp --list-subs "URL"` -> download if available
2. **Auto-generated subtitles (target language)**: If no manual subtitles, download auto-generated subtitles
3. **Auto-generated subtitles (en)**: If target language unavailable, download English subtitles
4. **No subtitles**: Use Chrome MCP to capture only the video page description, report to user

Download command:
```bash
yt-dlp --write-sub --write-auto-sub --sub-lang ko --sub-format srt --skip-download -o "$TEMP/aimind_yt_sub/%(id)s" "URL"
```

### Stage 3: Refine Subtitles

- Read the SRT file, removing timecodes and merging duplicate sentences
- Correct obvious auto-generated subtitle misrecognitions (only when contextually clear)
- Record corrected items at the bottom of the note (for transparency)

### Stage 4: Vault Routing

- Determine the target vault based on video topic keywords (refer to root CLAUDE.md vault entry protocol)
- If the user specified a vault, use it as-is
- If ambiguous, confirm with the user
- Place under the target vault's Contents/Domain/ (use topic subfolders if available)

### Stage 5: Note Structuring

Structure based on chapters, applying the following principles:

- **H1**: `{Core Topic}` (refined to core concept, not the video title verbatim)
- **Key Summary**: Compress the entire video into 3-5 lines (top of the note)
- **Body**: H2 sections split by chapter or topic transitions
- **Each Section**: Core concept -> detailed explanation -> tables/comparisons (where applicable)
- **Closing**: Related materials, recommended resources, WikiLinks

Frontmatter:
```yaml
---
type: domain
tags:
  - [vault-tag]
  - [topic-tags]
source: [video URL]
source_title: [original video title]
source_channel: [channel name]
created: YYYY-MM-DD
agent: claude
---
```

Include Juggl embed (filename-based).

### Stage 6: Quality Verification

- Run post-edit review after note creation
- Mark any unclear passages from subtitle misrecognition with `[?]`

### Stage 7: Cleanup

- Delete temporary files in `$TEMP/aimind_yt_sub/`
- Confirm deletion before reporting completion

## Beginner Note Option

If the user requests "beginner-friendly", "easy", etc.:
- Add parenthetical explanations for technical terms
- Reinforce with analogies/examples
- Highlight key points in bold
- Actively use tables and comparisons

## Failure Handling

| Situation | Response |
|-----------|----------|
| yt-dlp not installed | Guide user through installation |
| No subtitles | Organize from description + chapters as much as possible, state limitations |
| Video is private/deleted | Report immediately |
| SRT parsing failure | Retry with VTT format |
