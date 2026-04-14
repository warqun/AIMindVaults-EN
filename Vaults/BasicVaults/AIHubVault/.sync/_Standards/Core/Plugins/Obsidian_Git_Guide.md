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

# Obsidian Git Plugin Usage Guide

**Purpose**: A powerful version control tool that connects your Obsidian vault to a Git repository for automatic backup (Commit) and synchronization (Push/Pull).

Original link: [GitHub - Vinzent03/obsidian-git](https://github.com/Vinzent03/obsidian-git)
Detailed manual: [Official documentation](https://publish.obsidian.md/git-doc)

---

## Key Features and Benefits

1. **Auto Commit and Sync (Auto Backup/Sync)**
   - Automatically commits changes at set intervals (e.g., 10 minutes), and pulls from or pushes to the remote repository (GitHub, etc.).
   - Supports timer-based backup, allowing automatic backup when Obsidian is idle after you finish writing.
2. **Auto-pull on Startup**
   - When using multiple PCs or laptops, forces sync to the latest state as soon as Obsidian opens, preventing conflicts.
3. **Source Control View**
   - Like VSCode's source control tab, provides a UI panel showing which files have been modified/added/deleted at a glance.
   - Open with the `Open source control view` command.
4. **History and Diff View**
   - Browse commit logs (`Open history view`) or compare before/after changes for specific files (`Open diff view`).
5. **Editor Hints (Gutter Signs - Desktop Only)**
   - Shows added/modified/deleted lines with colors in the left gutter area of the editor, so you can see what you just changed.

---

## Manual Usage (Frequently Used Commands)

Even with auto-backup enabled, these commands are useful when you want direct control over sync/backup (`Ctrl+P` to execute).

- **`Obsidian Git: Commit all changes`**
  - Immediately manually commits all current changes. (A prompt will ask for a commit message)
- **`Obsidian Git: Push`**
  - Immediately sends committed history to the remote repository (GitHub). Good practice to push manually before ending work.
- **`Obsidian Git: Pull`**
  - Immediately pulls the latest data from the remote repository (work done on other devices) into the current vault.
- **`Obsidian Git: Open source control view`**
  - Opens the Git source control UI in the right panel for fine-grained file-level commit management.

---

## Tips and Considerations

- **Optimized environment:** Refer to the [[ObsidianGit_TimeMachine_Setup_Guide]] note and set up **"10-minute auto commit+push"** — you'll have a near-perfect backup environment without having to type Git commands like a developer.
- **Time Machine plugin integration:** On desktop, Git commit history appears as **blue dots** perfectly integrated into the `Time Machine` slider, so you can easily go back in time via the timeline instead of digging through commit logs.
- **Mobile caution:** Git integration on mobile (iOS/Android) can be relatively unstable or slow (developer warning). Therefore, it's best to primarily run Git backup on PC/laptop rather than setting up aggressive sync on mobile devices.
