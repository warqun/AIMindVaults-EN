# Encoding Safety (Mandatory)

> Applies uniformly to all vaults. Based on 2026-03-04 Incident.

## Required Rules

- Before bulk-modifying `Contents`, always run encoding verification first.
- Bulk modification scripts must use UTF-8 fixed I/O only.
- Do not run subsequent automation tasks until `BAD_COUNT=0` is confirmed after modification.

## Incident Rule: Mojibake Prevention (Mandatory)

- Never rewrite Korean markdown with Get-Content + Set-Content pipeline.
- Use only UTF-8 fixed .NET I/O for full-file edits.
- Prefer line-local patch edits; avoid full file rewrite.
- If mojibake appears, stop immediately, restore from Obsidian snapshot, then retry with safe method.

## Incident Rule: Bulk Replace Safety (Mandatory)

- Never run global markdown rewrites on all notes at once.
- Use staged rollout: dry-run → 3-file sample → full run.
- For Juggl edits, modify only inside fenced `juggl ... ` block scope.
- Validate invariants (local count, fenced block integrity, frontmatter integrity) before and after run.
- If corruption signs appear, stop, snapshot-restore, then retry with safer parser logic.
