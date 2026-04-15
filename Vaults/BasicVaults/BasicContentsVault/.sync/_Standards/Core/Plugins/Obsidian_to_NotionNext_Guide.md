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

# Obsidian to NotionNext (sync plugin) guide

**Purpose**: One-click sync and publish from Obsidian markdown to a Notion database (regular Notion page, NotionNext blog template, etc.).

Source: [GitHub - obsidian-to-NotionNext](https://github.com/jxpeng98/obsidian-to-NotionNext)
Detailed manual: [Official docs site](https://obsidian-to-notionnext.pages.dev/)

---

## 🛠 Key features and strengths

1. **Multiple database types**
   - Supports regular Notion databases, the Notion-based blog template **NotionNext**, and fully user-custom schemas.
2. **Frontmatter mapping**
   - 1:1 map any YAML/Properties metadata at the top of an Obsidian note to a specific column property in a Notion database.
3. **Automatic attachment upload**
   - Auto-uploads local image files (png, jpg, etc.) and PDFs to Notion during sync.
   - Recognizes both `[[WikiLink]]` and `[markdownLink]()` image attachments.
4. **Flexible targeting**
   - Pick which Notion database to send to each time you press the sync button.

---

## 🚀 Initial setup and usage flow (expected)

This plugin shines when Obsidian is your "local authoring store" and Notion is a "publishing web viewer or collaboration space."

**Initial setup:**
1. Issue a Notion API **Integration Token (internal integration API key)**.
2. On the target Notion database page, open `...` at the top right and **grant Connect permission** to your Integration.
3. Enter the Token and Database ID in the plugin settings and define frontmatter mapping rules.

**Sync workflow:**
1. Write in Obsidian as usual, including images.
2. Run the **Sync to Notion** command via the Command Palette (`Ctrl+P`).
3. Local markdown and images are auto-converted and uploaded (or updated) as a new item in the specified Notion DB.
4. (Optional) Right after sync, Notion's Share Link is placed on the clipboard — share it immediately.

---

## 💡 LatticeCore tips

Hugely useful when you need to hand off spec docs, meeting notes, outsourcing briefs written in the multi-vault architecture to **external people who primarily use Notion** (outsourced editors, teammates, etc.).
Keep documents safely in your local vault (Obsidian), and push just the external-facing pages to Notion — then toss the share link out.
