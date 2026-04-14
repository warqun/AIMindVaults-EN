---
tags:
  - TileMapToolKit
  - plugin
  - notion
  - sync
  - publish
  - guide
date: 2026-03-07
---

# Obsidian to NotionNext (Sync Plugin) Usage Guide

**Purpose**: A plugin that synchronizes and publishes markdown documents written in Obsidian to Notion databases (regular Notion pages, NotionNext blog templates, etc.) with one click.

Original link: [GitHub - obsidian-to-NotionNext](https://github.com/jxpeng98/obsidian-to-NotionNext)
Detailed manual: [Official documentation](https://obsidian-to-notionnext.pages.dev/)

---

## Key Features and Benefits

1. **Diverse Database Support**
   - Supports regular Notion databases, Notion-based blog **NotionNext** templates, and fully custom user schemas.
2. **Frontmatter Mapping**
   - Freely map metadata (YAML/Properties) attributes from the top of Obsidian notes 1:1 to specific column properties in Notion databases.
3. **Automatic Attachment Upload**
   - Automatically uploads local image files (png, jpg, etc.) and PDF files when syncing to Notion.
   - Recognizes both `[[wiki link]]` and `[markdown link]()` format image attachments.
4. **Flexible Target Settings**
   - Each time you press the sync button, you can select in real-time "which Notion database to send to."

---

## Basic Setup and Usage Flow

This plugin shines most when using Obsidian as a 'local writing repository' and Notion as a 'web viewer for publishing or collaboration space.'

**Initial Setup Requirements:**
1. Issue a Notion API **Integration Token (internal integration API key)**
2. Grant **Connect permissions** to the Integration from the `...` menu at the top right of the Notion database page to sync
3. Enter the Token and Database ID in the plugin settings and specify frontmatter mapping rules

**Sync Workflow:**
1. Write content in Obsidian as usual and add images.
2. Execute a **Sync to Notion** related command from the Command Palette (`Ctrl+P`).
3. Local markdown and images are automatically converted and uploaded as new items (or updated) in the specified Notion DB.
4. (Optional) After sync, a Notion share link is generated to the clipboard for immediate sharing.

---

## Tips

When you need to deliver planning documents, meeting notes, or outsourcing work orders written in your multi-vault architecture to **external people who primarily use Notion (freelance editors, team members, etc.)**, this is very useful.
Keep documents safely in your local vault (Obsidian), and easily push only the external distribution pages to Notion and share the link.
