---
tags:
  - plugin
  - youtube
  - transcript
  - guide
date: 2026-03-07
---

# Youtube Transcript (YTranscript) plugin guide

**Purpose**: Extract YouTube video (lectures, tutorials, etc.) transcripts and timestamps directly into Obsidian notes for smooth video-based learning and note-taking. No Python scripts, no bot-evasion hassles — everything is done inside Obsidian.

---

## 🛠 Key features and strengths

- **Full mobile/desktop support:** Works smoothly on mobile as well as PC.
- **Clickable timestamps:** Timestamps like `00:15` are inserted next to the extracted script — click one to jump to that point in the video.
- **Side-panel (Classic) support:** Pin the transcript in the right side tab while writing your own summary note in the main pane.

---

## 🚀 Usage summary

### 1. Inline (insert) mode (recommended for fast note-taking)
Directly insert the full transcript into the note body.

1. Place the cursor where you want to insert.
2. Copy the YouTube video URL.
3. Open the Command Palette (`Ctrl` + `P`) and run:
   > **`Youtube Transcript: Insert Youtube transcript`**
4. Confirm the URL in the popup and hit Enter — the translated transcript with timestamps is inserted into your note.

**(Note)** It captures the URL in the following order:
- Currently selected (dragged) text in the note
- System clipboard (URL you copied)
- Manual input prompt (if neither is available)

### 2. Side-panel mode (recommended for focused study on PC)
For when you want to separate note authoring from the source reference.

1. Select a YouTube video link in the editor.
2. From the popup (or right-click menu, etc.), run:
   > **`Youtube Transcript: Get Youtube transcript from selected url`**
3. A side panel opens with timestamped text.
4. Inside the panel, drag-and-drop specific lines into the note to insert only parts.
5. In Settings, change the interval at which timestamps appear (e.g., every 32 lines).

---

## 💡 Usage tips

- After copying the transcript, feed it to a strong language model like GPT or Claude (or a related plugin) with a prompt like **"summarize the key points in 3 lines"** — this combo gives you the fastest comprehension workflow.
