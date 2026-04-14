---
tags:
  - TileMapToolKit
  - plugin
  - git
  - backup
  - timemachine
  - guide
date: 2026-03-07
---

# Obsidian Git + Time Machine Optimal Setup Guide (2026)

**Purpose**: Build an optimized backup and point-in-time timeline recovery system for your Obsidian vault. This guide maximizes the synergy between the Obsidian Git plugin and the Time Machine plugin.

This combination provides intuitive timeline-based partial recovery (Time Machine) when you accidentally delete content, while simultaneously maintaining long-term version-controlled backups on the cloud via GitHub (Obsidian Git) — the **ultimate backup + timeline system**.

---

## 1. Obsidian Git — Optimal Auto-Commit Settings (Most Important!)

**Settings path**: `Settings` → `Community plugins` → `Obsidian Git` settings (gear icon)

| Setting | Recommended Value | Reason / Tips |
|:--------|:------------------|:--------------|
| **Auto commit-and-sync interval** | **10 minutes** (5-15 range) | 5 minutes creates too many commits and can get heavy. 10 minutes is the most stable. |
| **Auto commit-and-sync after stopping file edits** | `On` | Commits right after edits stop, increasing real-time backup coverage |
| **Auto pull interval** | **10 minutes** | Match with commit interval |
| **Auto pull on startup** | `On` | Automatically pulls the latest version every time Obsidian starts |
| **Push on commit-and-sync** | `On` | Auto-push to GitHub remote on commit (confirms backup) |
| **Author name for commit** | Your name | (Required) |
| **Author email for commit** | GitHub email | (Required) |
| **Commit message template** | `{{date:YYYY-MM-DD HH:mm}} {{message}}` | Time is auto-recorded in commit messages, making later identification very easy |
| **Merge strategy** | `Merge` (or `Rebase`) | `Merge` is the safest and most straightforward for personal vaults |

**Additionally recommended options:**
- `Auto backup after latest commit` → `On`
- `Pull changes before commit` → `On`

> **Effect:** With this setup, around 100-200 auto-commits will naturally accumulate per day without putting strain on Obsidian performance.

---

## 2. Time Machine — How to View the Timeline

The Time Machine plugin **requires almost no complex configuration**.
If Git is already connected to your vault, it **automatically merges Git commit history and Obsidian's built-in File Recovery snapshots into a single timeline** (duplicates are automatically removed).

### How to Access the Timeline (3 methods)

1. **Easiest method (recommended)**
   - Open the note you want to view past history for.
   - Click the **Time Machine icon (clock shape)** in the right sidebar menu.
   - The timeline slider appears at the bottom of the screen immediately!
2. **Via Command Palette**
   - Press `Ctrl + P` and search for `Time Machine: Open timeline for current file`.
3. **From File Explorer**
   - Right-click the note title in the file explorer and select `Open Time Machine`.

### Timeline Features
- **Drag the bottom slider left and right** to preview past versions (edit history) in real time.
- Besides rolling back the entire document to a specific point, you can **copy and restore just a specific paragraph (partial)**.
- **Blue dots** on the timeline represent Git commits, while **gray dots** represent system File Recovery snapshots.

---

## 3. Complete Optimal Setup Summary (Follow These Steps)

1. **File Recovery (Core Plugin)**
   - Enable (recommended interval: `5 minutes`)
2. **Obsidian Git (Community Plugin)**
   - Configure 10-minute interval auto-sync as per the optimization table above
3. **Time Machine (Community Plugin)**
   - Install and activate (auto-integrates)

With this setup:
- If you accidentally lose note content, you can **instantly perform partial recovery via the Time Machine timeline**.
- Long-term document corruption/loss is prevented by **automatic backup to GitHub**.
- On PC, the Git-based system works, and on mobile, the File Recovery timeline provides defense — **protection everywhere, anytime**.
