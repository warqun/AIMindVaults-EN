# /grok-route — Pre-Task Grok Branch Router

Arguments: $ARGUMENTS
Usage: `/grok-route [task description]`

---

## Purpose

Upon receiving a task instruction, analyze the entire task to:
1. Identify items that would yield better results when sent to Grok 3
2. Generate a ready-to-paste Grok prompt for the user
3. Handle the remainder directly with Claude

---

## Execution Order

### 1. Task Decomposition

Read `$ARGUMENTS` and extract a list of subtasks.

### 2. Determine Grok Suitability

| Criteria | Grok Mode |
|----------|-----------|
| Keywords: "latest", "bug", "error", "trend", "community", "forum" | DeepSearch |
| Formulas, balancing, algorithms, numerical verification requests | Think / Big Brain |
| Subtitle/long document single conversion/summarization (external file-based) | Standard (large context) |
| X/Twitter real-time information, short-form content planning | DeepSearch |
| Vault file editing, design discussions, spec writing | -> Claude handles |
| Issue finalization, multi-file coordination, continuous context required | -> Claude handles |

### 3. Output Format (fixed)

```
===================================
[Grok] Items to send to Grok (copy and paste)
===================================

[Mode: DeepSearch / Think / Standard]
------------------------------------
[Full prompt to paste into Grok]
------------------------------------

(Omit this section if there are no Grok items)

===================================
[Claude] Items Claude will handle
===================================

1. [Item]
2. [Item]

Let me know when you get the Grok results -> I'll incorporate them into the documents.
===================================
```

### 4. Grok Prompt Writing Rules

- **For DeepSearch**: "Research the latest status of [topic] using DeepSearch and summarize the key points."
- **For Think mode**: "Verify [formula/algorithm]. Use Think mode."
- **For large context conversion**: "Convert the following content into Obsidian note format."
- Write prompts in the user's preferred language; keep technical terms in English

### 5. Follow-Up

- If there are Grok items: wait for user response
- If there are no Grok items: proceed directly with Claude's tasks
