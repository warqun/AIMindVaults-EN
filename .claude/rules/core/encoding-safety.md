# Encoding Safety (Mandatory)

> Applied uniformly to every vault. Based on the 2026-03-04 incident.

## Required Rules

- Always run encoding verification before any bulk edit under `Contents`.
- Bulk-edit scripts may use UTF-8-pinned I/O only.
- Do not run downstream automation until you have confirmed `BAD_COUNT=0` after the edit.

## Incident Rule: Mojibake Prevention (Mandatory)

- Never rewrite Korean markdown with a Get-Content + Set-Content pipeline.
- Use only UTF-8-pinned .NET I/O for full-file edits.
- Prefer line-local patch edits; avoid full-file rewrites.
- If mojibake appears, stop immediately, restore from the Obsidian snapshot, then retry with a safe method.

## Incident Rule: Bulk Replace Safety (Mandatory)

- Never run a global markdown rewrite across all notes at once.
- Use a staged rollout: dry-run → 3-file sample → full run.
- For Juggl edits, modify only inside the fenced `juggl ...` block scope.
- Validate invariants (local count, fenced-block integrity, frontmatter integrity) before and after the run.
- If corruption signs appear, stop, restore the snapshot, then retry with safer parser logic.
