# /note-link — Create Semantic Links Between Notes

> Find existing documents related to the given note and connect them via [[internal links]].
> Done by Claude's direct semantic analysis — no Smart Connections required.
> Multi-vault: auto-detect the vault from the file path.

Target file: $ARGUMENTS (filename or path)

## Execution Order

1. **Read the target note**
   - Detect the vault from the file path.
   - Extract 3–5 key topics/concepts.

2. **Search for related documents** (within the same vault, in this order)
   - `Contents/Domain/02-design/` design docs.
   - `Contents/Domain/03-spec/` specs.
   - `Contents/Domain/issues/ISSUE_INDEX.md`.
   - `Contents/Domain/04-debug/` debug designs.

3. **Similarity judgment**
   - **High**: directly addresses the same system → add `[[link]]`.
   - **Medium**: contains related concepts → add `[[link]]` (mark as candidate).
   - **Low**: only surface keyword match → skip.

4. **Insert links**
   - Append under a "## Related" section at the bottom of the target note.
   - Reverse direction: add the target note's link to each linked note as well.

5. **Report**
   ```
   Linked notes (N):
   - [[filename]] — reason
   - [[filename]] — reason

   Skipped (low):
   - [[filename]] — reason
   ```
