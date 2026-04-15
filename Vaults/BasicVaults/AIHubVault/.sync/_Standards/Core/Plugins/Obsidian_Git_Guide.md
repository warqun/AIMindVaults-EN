---
tags:
  - TileMapToolKit
  - plugin
  - git
  - backup
  - version-control
  - guide
date: 2026-03-07
---

# Obsidian Git plugin guide

**Purpose**: A powerful version-control tool that wires your Obsidian vault to a Git repository for automatic backups (Commit) and sync (Push/Pull).

Source: [GitHub - Vinzent03/obsidian-git](https://github.com/Vinzent03/obsidian-git)
Detailed manual: [Official docs site](https://publish.obsidian.md/git-doc)

---

## 🛠 Key features and strengths

1. **Auto commit and sync (Auto Backup/Sync)**
   - Every interval you set (e.g., 10 minutes), it auto-commits changes and `pull`s latest / `push`es to the remote (GitHub, etc.).
   - Timer-based backup lets Obsidian back up on its own while idle after you finish writing.
2. **Auto-pull on startup**
   - When using multiple PCs or mobile laptops, it force-syncs to latest the moment Obsidian opens, preventing conflicts.
3. **Source Control View**
   - Like VSCode's Source Control tab — a UI panel that shows at a glance which files are modified / added / deleted.
   - Open with `Open source control view`.
4. **History & Diff View**
   - Browse commit history (`Open history view`) or diff a specific file before/after (`Open diff view`).
5. **Gutter signs (desktop only)**
   - Colored markers in the editor's line-number gutter show added/modified/deleted lines so you can see what you just touched.

---

## 🚀 Manual usage (common commands)

Even with auto backup on, these commands let you control sync / backup directly (run via `Ctrl+P`).

- **`Obsidian Git: Commit all changes`**
  - Immediately, manually commits all changes so far. (Prompts for a commit message.)
- **`Obsidian Git: Push`**
  - Immediately pushes committed history to the remote (GitHub). Pressing this manually at end-of-day is a good habit.
- **`Obsidian Git: Pull`**
  - Immediately pulls the latest data from the remote (work done on other devices) into the current vault.
- **`Obsidian Git: Open source control view`**
  - Opens the Git Source Control UI in the right panel for fine-grained file-level commit management.

---

## 💡 LatticeCore tips and cautions

- **Optimal LatticeCore setup:** Follow [[ObsidianGit_TimeMachine_Setup_Guide]] to configure **"10-minute auto commit + push"** — you'll get a near-perfect backup environment without typing Git commands like a developer.
- **Time Machine integration:** On desktop, these Git commits are fully integrated into the `Time Machine` slider as **blue dots**, so you can time-travel via the timeline instead of digging through commit logs.
- **Mobile caveats:** Git integration on mobile (iOS/Android) can be unstable or slow (author's warning). Prefer Git backup on PC / laptop rather than heavy sync on mobile.
