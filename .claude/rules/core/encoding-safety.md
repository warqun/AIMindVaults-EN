# Encoding Safety (Mandatory)

> Applies to all vaults. Based on 2026-03-04 incident.

## Required Rules

- Before bulk-editing anything under `Contents`, run encoding validation first.
- Bulk-edit scripts must use UTF-8 fixed I/O only.
- Do not run downstream automation until `BAD_COUNT=0` is confirmed after the edit.

## Incident Rule: Mojibake Prevention (Mandatory)

- Never rewrite Korean markdown with a Get-Content + Set-Content pipeline.
- Use only UTF-8 fixed .NET I/O for full-file edits.
- Prefer line-local patch edits; avoid full-file rewrites.
- If mojibake appears, stop immediately, restore from an Obsidian snapshot, then retry with a safe method.

## Incident Rule: Bulk Replace Safety (Mandatory)

- Never run global markdown rewrites across all notes at once.
- Use staged rollout: dry-run → 3-file sample → full run.
- For Juggl edits, modify only inside the fenced `juggl ... ` block scope.
- Validate invariants (local count, fenced block integrity, frontmatter integrity) before and after the run.
- If corruption signs appear, stop, restore from snapshot, then retry with safer parser logic.
