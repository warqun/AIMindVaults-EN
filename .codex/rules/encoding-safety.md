# Codex Root Encoding Safety

> Root hub follows the same UTF-8 safety baseline as the vaults.

## Rules

- Never rewrite Korean markdown with `Get-Content | Set-Content`
- Prefer patch-local edits over full-file rewrites
- If a bulk edit is required later, use dry-run, sample, then full run
- If mojibake appears, stop immediately and recover before continuing
