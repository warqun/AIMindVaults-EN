# /note-link — Create Semantic Links Between Notes

> Finds existing documents related to a specified note and connects them via [[internal links]].
> Performed by Claude's direct semantic analysis, without Smart Connections.
> Multi-vault: Automatically determines the vault from the file path.

Target file: $ARGUMENTS (filename or path)

## Execution Order

1. **Read Target Note**
   - Determine vault from file path
   - Extract 3-5 core topics/concepts

2. **Search for Related Documents** (within the vault, in this order)
   - `Contents/Domain/02-design/` design documents
   - `Contents/Domain/03-spec/` specification documents
   - `Contents/Domain/issues/ISSUE_INDEX.md`
   - `Contents/Domain/04-debug/` debug designs

3. **Assess Similarity**
   - **High**: Directly addresses the same system -> add [[link]]
   - **Medium**: Contains related concepts -> add [[link]] (marked as candidate)
   - **Low**: Only surface keyword matches -> exclude

4. **Insert Links**
   - Add to the "## Related Documents" section at the bottom of the target note
   - Reverse direction: Also add a link to the target note in the connected notes

5. **Report Results**
   ```
   Connected notes (N):
   - [[filename]] — reason
   - [[filename]] — reason

   Skipped (low relevance):
   - [[filename]] — reason
   ```
