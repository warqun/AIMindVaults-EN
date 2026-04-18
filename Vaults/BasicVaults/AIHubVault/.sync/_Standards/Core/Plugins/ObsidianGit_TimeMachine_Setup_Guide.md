---
tags:
  - plugin
  - git
  - backup
  - timemachine
  - guide
date: 2026-03-07
---

# Obsidian Git + Time Machine optimal setup guide (2026)

**Purpose**: An optimized configuration combo for a fully backed-up Obsidian vault and a past-timeline restore system. Maximizes the synergy between Obsidian Git and Time Machine.

This combo lets you intuitively scrub the timeline to recover accidentally deleted content (Time Machine) while simultaneously keeping a safe long-term, versioned cloud backup on GitHub (Obsidian Git) — **the best backup + timeline system**.

---

## 1. Obsidian Git — optimal auto-commit settings (most important!)

**Path**: `Settings` → `Community plugins` → open `Obsidian Git` settings (⚙️)

| Setting | Recommended value | Reason / tip |
| :--- | :--- | :--- |
| **Auto commit-and-sync interval** | **10 minutes** (range 5–15) | 5 min commits too often and gets heavy; 10 min is most stable. |
| **Auto commit-and-sync after stopping file edits** | `On` | Commits right when edits stop — near real-time backup |
| **Auto pull interval** | **10 minutes** | Match the commit interval |
| **Auto pull on startup** | `On` | Pulls the latest version every time Obsidian opens |
| **Push on commit-and-sync** | `On` | Pushes to GitHub together with the commit (backup confirmed) |
| **Author name for commit** | Your name | (required) |
| **Author email for commit** | Your GitHub email | (required) |
| **Commit message template** | `{{date:YYYY-MM-DD HH:mm}} {{message}}` | Time is auto-recorded in commit messages — great for identification later |
| **Merge strategy** | `Merge` (or `Rebase`) | For a solo personal vault, `Merge` is the simplest and safest |

**Extra options worth enabling:**
- `Auto backup after latest commit` → `On`
- `Pull changes before commit` → `On`

> 💡 **Effect:** With this setup, 100–200 auto-commits accumulate per day naturally without straining Obsidian performance.

---

## 2. Time Machine — how to view the timeline

Time Machine requires **almost no extra configuration**.
If Git is already wired to the vault, it **automatically merges Git commit history and Obsidian's built-in File Recovery snapshots into a single timeline** (duplicates are auto-removed).

### Three ways to open the timeline

1. **Easiest (recommended)**
   - Open the note whose history you want to see.
   - In the right sidebar, click the **Time Machine icon (clock ⏱️)**.
   - The timeline slider appears at the bottom of the screen!
2. **Open from the Command Palette**
   - Press `Ctrl + P`, search `Time Machine: Open timeline for current file`, run it.
3. **Open from the explorer**
   - Right-click a note title in the file explorer and select `Open Time Machine`.

### Timeline features
- **Drag the slider left/right** at the bottom to preview past versions in real time.
- After picking a point, you can roll back the whole document, or **copy and revert only a specific paragraph / section**.
- On the timeline, **blue dots are Git commits**, **gray dots are system File Recovery** snapshots.

---

## 3. Optimal combo summary (follow this as-is)

1. **File Recovery (core plugin)**
   - Enable (interval: `5 minutes` recommended)
2. **Obsidian Git (community plugin)**
   - Set 10-minute auto-sync per the table above
3. **Time Machine (community plugin)**
   - Install and enable (auto-integrates)

With this in place:
- If you accidentally wipe a note, the **Time Machine timeline** gives you instant partial recovery.
- Long-term corruption/loss is defended against via safe auto-save (backup) on **GitHub**.
- Git-based on PC, File Recovery timeline on mobile — the defense system runs anywhere, anytime.
