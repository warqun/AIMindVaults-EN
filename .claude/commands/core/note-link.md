# /note-link — Create Semantic Links Between Notes

> Find existing documents related to the given note and connect them via `[[internal links]]`.
> Performed by Claude's direct semantic analysis (no Smart Connections required).
> Multi-vault: the vault is auto-detected from the file path.

Target file: $ARGUMENTS (filename or path)

## Execution Order

1. **Read the target note**
   - Determine the vault from the file path
   - Extract 3–5 core topics / concepts

2. **Search for related documents** (within the same vault, in this order)
   - Designs under `Contents/Domain/02-design/`
   - Specs under `Contents/Domain/03-spec/`
   - `Contents/Domain/issues/ISSUE_INDEX.md`
   - Debug designs under `Contents/Domain/04-debug/`

3. **Similarity judgement**
   - **High**: directly addresses the same system → add the `[[link]]`
   - **Medium**: contains related concepts → add the `[[link]]` (mark as candidate)
   - **Low**: only surface keywords match → exclude

4. **Insert links**
   - Add to a "## Related" section at the bottom of the target note
   - Reverse: also add a link back to the target note in each connected note

5. **Result report**
   ```
   Linked notes (N):
   - [[filename]] — reason
   - [[filename]] — reason

   Skipped (low):
   - [[filename]] — reason
   ```
