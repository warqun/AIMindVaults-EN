---
tags:
  - TileMapToolKit
  - plugin
  - timemachine
  - backup
  - restore
  - guide
date: 2026-03-07
---

# Obsidian Time Machine plugin guide

**Purpose**: A powerful plugin that unifies Obsidian's built-in File Recovery snapshots with Git commit history, letting you explore and restore past versions of documents via an intuitive visual timeline.

Source: [GitHub - dsebastien/obsidian-time-machine](https://github.com/dsebastien/obsidian-time-machine)
Detailed manual: [Official docs site](https://developassion.gitbook.io/obsidian-time-machine/)

---

## 🛠 Key features and strengths

1. **Unified timeline slider**
   - Drag the bottom slider to see in real time how the note evolved over time.
2. **Auto Git commit integration (desktop only)**
   - If the vault is wired to a Git repo, **Git commits (blue dots)** and **File Recovery snapshots (gray dots)** merge into a single timeline.
   - Duplicate-content snapshots are smartly auto-deduplicated for a clean timeline.
3. **Intuitive change view (Colored Diff View)**
   - Shows added content (green) vs. deleted content (red) as intuitively as a code diff tool.
4. **Selective restore**
   - You can roll back an entire document to a past point, or pick **just a single paragraph** you accidentally wiped and restore only that into the current document.

---

## 🚀 Getting started

Install once — it runs in the background and you pull it out when you need it.

**[Prerequisite]**
- In Obsidian's Settings → Core plugins, **"File Recovery"** must be enabled. (On by default.)

**[How to view the timeline]**
1. Open the note whose history you want to check.
2. Open the Command Palette (`Ctrl` + `P`) and run:
   > **`Time Machine: Open view`** (or click the clock icon in the right sidebar)
3. Move the slider at the bottom of the screen to travel back.
4. When you find the lost content, Revert the whole document, or right-click to copy just the part you need.

---

## 💡 LatticeCore and backup tips

The **Obsidian Git (10-minute auto-push)** system you just set up and this **Time Machine** plugin are a perfect pair.
- For minor but painful typos or mistakes in front of you (accidental block wipe, etc.), scrub through **Time Machine's** 5-minute snapshots and do a partial restore in one second.
- For catastrophes — lost PC, the whole vault gone — restore everything from the cloud backup stored by **Obsidian Git**.
- This gives you an unbeatable two-layer defense: **short-term micro-restore (Time Machine) + long-term macro-backup (Git)**.
