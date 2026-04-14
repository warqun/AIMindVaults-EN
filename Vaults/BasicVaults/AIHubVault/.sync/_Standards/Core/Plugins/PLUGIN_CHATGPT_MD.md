---
tags:
  - TileMapToolKit
type: plugin-standard
plugin: chatgpt-md
updated: 2026-03-06
---

# ChatGPT MD

## Features

- LLM conversation/response generation inside Obsidian notes
- Connect to local LLM backends like Ollama/LM Studio
- Agent preset-based role separation

## Basic Setup Procedure

1. Install/activate `ChatGPT MD` from Obsidian Community Plugins
2. In plugin Settings, select Provider as `Ollama`
3. Set Base URL: `http://localhost:11434`
4. Set default model (e.g., model name pulled locally)
5. Test with a prompt to confirm responses

## Plugin Usage (Execution Order)

1. Open Command Palette (`Ctrl/Cmd + P`)
2. Select model with `ChatGPT MD: Select Model`
3. Select prompt text (or block) in the note
4. Execute `ChatGPT MD: Chat`
5. Verify response is recorded in the note
6. If session reset is needed, use `ChatGPT MD: Clear Chat`
7. For template-based new sessions, use `ChatGPT MD: New Chat From Template`

## Practice Notes

- For quick testing: `Notes/Temp_ChatGPTMD_Ollama_Sandbox.md`
- Recommended: Execute in Planner -> Builder -> Reviewer order within the same note

## Task Usage Criteria

- Draft generation/rewriting/summarization: ChatGPT MD standalone
- Multi-agent division of labor: Separate Agent presets per task
- Local-first policy: Use Ollama connection as default when possible

## Recommended Operation Pattern

1. Planner Agent: Requirement decomposition/checklist creation
2. Builder Agent: Draft body generation
3. Reviewer Agent: Gap/conflict review

## Notes

- Model responses are treated as drafts; final decisions are confirmed via document rules (`_WORKFLOW.md`)
- Keep permission scope minimal when using tool calling
