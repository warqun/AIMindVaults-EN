---
tags:
  - TileMapToolKit
  - plugin
  - youtube
  - transcript
  - guide
date: 2026-03-07
---

# Youtube Transcript (YTranscript) Plugin Usage Guide

**Purpose**: Extract YouTube video (lectures, tutorials, etc.) scripts and timestamps directly into Obsidian notes for seamless video-based learning and note-taking. No need to write Python scripts or worry about bot bypasses — everything is handled within Obsidian.

---

## Key Features and Benefits

- **Full Mobile/Desktop Support:** Works smoothly on both PC and mobile.
- **Clickable Timestamps:** Timestamps like `00:15` are inserted next to extracted scripts; clicking jumps directly to that point in the video.
- **Side Panel (Classic) Support:** Display the script in a right-side tab while writing your own summary notes in the main pane.

---

## Usage Summary

### 1. Inline (Insert) Method (Recommended: Quick Note-Taking)
Inserts the full script directly into the note body.

1. Place your cursor where you want to insert.
2. Copy the YouTube video URL.
3. Open the Command Palette (`Ctrl` + `P`) and run:
   > **`Youtube Transcript: Insert Youtube transcript`**
4. Confirm the URL in the popup and press Enter — the translated script with timestamps is inserted directly into your note.

**(Note)** URL capture works in this order:
- Currently selected (highlighted) text in the note
- System clipboard (copied address)
- Manual input prompt (if neither is available)

### 2. Side Panel Method (Recommended: Focused Learning on PC)
Use this when you want to separate note-writing from reference reading.

1. Select a YouTube video link in the editor.
2. From the popup (or right-click menu), run:
   > **`Youtube Transcript: Get Youtube transcript from selected url`**
3. A side panel opens with timestamped text.
4. You can drag and drop specific lines from the panel into your note to insert partial content.
5. In Settings, you can change how often timestamps appear (e.g., every 32 lines).

---

## Tips
- After copying the script as-is, use a powerful language model like GPT or Claude (or related plugins) with prompts like **'summarize key content in 3 lines'** to rapidly digest the content for maximum efficiency.
