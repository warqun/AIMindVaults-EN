# /grok-route — Pre-Work Routing via Grok

Argument: $ARGUMENTS
Usage: `/grok-route [task description]`

---

## Purpose

When you receive a task, analyze the whole job and:
1. Identify items better handled by Grok 3.
2. Produce a Grok prompt the user can paste directly.
3. Handle the rest in Claude.

---

## Execution Order

### 1. Task breakdown

Read `$ARGUMENTS` and extract the sub-task list.

### 2. Grok-fit decision

| Criterion | Grok mode |
|-----------|-----------|
| Keywords: "latest", "bug", "error", "trend", "community", "forum" | DeepSearch |
| Formula / balancing / algorithm / numeric verification requests | Think / Big Brain |
| Subtitle / long-doc single-pass conversion / summary (external file-based) | Standard (large context) |
| X/Twitter real-time info, short-form content planning | DeepSearch |
| Vault file editing, design discussion, spec writing | → Claude handles |
| Issue settlement, multi-file coordination, continuous context | → Claude handles |

### 3. Output format (fixed)

```
═══════════════════════════════════════
🟡 Send to Grok (paste and use)
═══════════════════════════════════════

[Mode: DeepSearch / Think / Standard]
────────────────────────────────
[Full prompt to paste into Grok]
────────────────────────────────

(Omit this section if no Grok item applies.)

═══════════════════════════════════════
✅ Handled by Claude
═══════════════════════════════════════

1. [item]
2. [item]

Let me know when you have the Grok result → I'll fold it into the docs.
═══════════════════════════════════════
```

### 4. Grok prompt authoring rules

- **For DeepSearch**: "Research the current state of [topic] via DeepSearch and summarize the key points."
- **For Think mode**: "Verify [formula/algorithm]. Use Think mode."
- **For large conversion**: "Convert the following content into Obsidian note format."
- Write prompts in the user's language; keep technical terms in English.

### 5. Follow-up

- If a Grok item exists: wait for the user's response.
- If no Grok item: start the Claude work immediately.
