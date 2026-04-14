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

# Obsidian Time Machine Plugin Usage Guide

**Purpose**: A powerful plugin that integrates Obsidian's built-in 'File Recovery' snapshots with Git commit history, providing an intuitive visual timeline to browse and restore past versions of your documents.

Original link: [GitHub - dsebastien/obsidian-time-machine](https://github.com/dsebastien/obsidian-time-machine)
Detailed manual: [Official documentation](https://developassion.gitbook.io/obsidian-time-machine/)

---

## Key Features and Benefits

1. **Integrated Timeline Slider**
   - Drag the bottom slider to see how your note has changed over time in real-time preview.
2. **Automatic Git Commit Integration (Desktop Only)**
   - If the vault is connected to a Git repository, it **merges Git commit history (blue dots)** and **File Recovery snapshots (gray dots)** into a single timeline.
   - Duplicate snapshots are intelligently auto-deduplicated for a clean timeline.
3. **Intuitive Change View (Colored Diff View)**
   - Shows what was added (green) and deleted (red) like a code comparison tool.
4. **Selective Restore Support**
   - You can restore the entire document to a past point, or select and recover **just a specific paragraph** into the current document.

---

## Getting Started

This plugin works in the background once installed — just pull it up when needed.

**[Prerequisites]**
- **"File Recovery"** must be enabled in Obsidian default settings (Settings -> Core plugins). (Usually enabled by default)

**[How to View the Timeline]**
1. Open the note whose change history you want to review.
2. Open the Command Palette (`Ctrl` + `P`) and run this command:
   > **`Time Machine: Open view`** (or click the clock icon in the right sidebar)
3. Move the slider that appears at the bottom to navigate to past points in time.
4. If you find lost content, either Revert the entire document or right-click copy just the parts you need.

---

## Tips and Backup Usage

The **Obsidian Git (10-minute auto-push)** system paired with this **Time Machine** plugin is a perfect combination.
- For immediate critical typos or mistakes (accidental block deletion, etc.), **flip through Time Machine's 5-minute snapshots** for instant partial recovery.
- For major incidents like PC loss or entire vault data loss, perform full recovery from the **cloud backup stored in Obsidian Git**.
- In other words, **short-term micro recovery (Time Machine) + long-term macro backup (Git)** creates an invincible dual defense system!
