---
tags:
type: plugin-standard
plugin: chatgpt-md
updated: 2026-03-06
---

# ChatGPT MD

## Features

- Generate LLM chats / responses inside Obsidian notes
- Connect to local LLM backends (Ollama / LM Studio, etc.)
- Role separation via agent presets

## Initial setup

1. Install and enable `ChatGPT MD` from Obsidian Community Plugins
2. In plugin Settings, choose Provider = `Ollama`
3. Set Base URL: `http://localhost:11434`
4. Pick a default model (e.g., a locally pulled model name)
5. Verify with a test prompt

## Usage (execution order)

1. Open the command palette (`Ctrl/Cmd + P`)
2. `ChatGPT MD: Select Model` to pick a model
3. Select a prompt sentence (or block) in the note
4. Run `ChatGPT MD: Chat`
5. Confirm the response is written to the note
6. To reset the session: `ChatGPT MD: Clear Chat`
7. Start a new template-based session: `ChatGPT MD: New Chat From Template`

## Practice notes

- Quick test: `Notes/Temp_ChatGPTMD_Ollama_Sandbox.md`
- Recommended: run Planner → Builder → Reviewer in the same note

## When to use

- Draft / rewrite / summarize: ChatGPT MD alone
- Multi-agent division of labor: split agent presets per task
- Local-first policy: default to Ollama when possible

## Recommended pattern

1. Planner Agent: decompose requirements / build a checklist
2. Builder Agent: draft the body
3. Reviewer Agent: check gaps / conflicts

## Cautions

- Treat model responses as drafts; finalize per `_WORKFLOW.md`
- When using tool calling, keep permissions minimal
