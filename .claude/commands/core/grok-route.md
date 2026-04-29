# /grok-route — Pre-Work Grok Branching Router

Argument: $ARGUMENTS
Usage: `/grok-route [work description]`

---

## Purpose

When given a work directive, analyze the whole task to:
1. Identify items better delegated to Grok 3
2. Generate a Grok prompt the user can paste directly
3. Have Claude handle the rest

---

## Execution Order

### 1. Decompose the task

Read `$ARGUMENTS` and extract the sub-task list.

### 2. Decide Grok suitability

| Criterion | Grok mode |
|-----------|-----------|
| Keywords like "latest", "bug", "error", "trend", "community", "forum" | DeepSearch |
| Formula / balancing / algorithm / numeric verification | Think / Big Brain |
| Subtitle, long-document one-shot conversion / summarization (from external file) | General (large) |
| Real-time info on X / Twitter; short-form planning | DeepSearch |
| Editing vault files / design discussion / writing a Spec | → Claude |
| Issue confirmation / multi-file coordination / continuous context required | → Claude |

### 3. Output format (fixed)

```
═══════════════════════════════════════
🟡 To send to Grok (paste this)
═══════════════════════════════════════

[Mode: DeepSearch / Think / General]
────────────────────────────────
[Full prompt to paste into Grok]
────────────────────────────────

(Skip this section if there is no Grok item.)

═══════════════════════════════════════
✅ Claude will handle
═══════════════════════════════════════

1. [item]
2. [item]

Let me know when the Grok result comes back — I will fold it into the documents.
═══════════════════════════════════════
```

### 4. Grok prompt-writing rules

- **DeepSearch**: "Investigate the latest [topic] via DeepSearch and summarize the key points."
- **Think mode**: "Verify this [formula / algorithm]. Use Think mode."
- **Large conversion**: "Convert the following content into Obsidian-note format."
- Write the prompt in the user's language; keep technical terms in English.

### 5. Follow-up

- If there is a Grok item: wait for the user's response.
- If not: start Claude's work immediately.
