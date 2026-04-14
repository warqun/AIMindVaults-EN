# /vault-health — Vault Health Check

> Audit the state of a vault's documents and propose improvements.
> Multi-vault: pass the target vault as an argument.

Argument: $ARGUMENTS (vault name)

## Execution Order

1. **Decide the target vault** (argument or user confirmation).

2. **Check issue-index state**
   - Read `{vault-path}/Contents/Domain/issues/ISSUE_INDEX.md`.
   - Count open issues (🔴).
   - Note the oldest open issue.

3. **Check design-spec sync**
   - `{vault-path}/Contents/Domain/02-design/` vs `{vault-path}/Contents/Domain/03-spec/`.
   - Print any mismatches.

4. **Check _VAULT-INDEX.md freshness**
   - Compare actual file structure against _VAULT-INDEX contents.
   - Flag missing files/sections.

5. **Check empty/stub files**
   - Detect nearly-empty files (< 5 lines) under `Contents/Domain/`.

6. **Print the diagnostic** (table form)

   ```
   | Item | Status | Action |
   |------|--------|--------|
   | Open issues | N | next target: HX |
   | Design-spec sync | ✅/⚠️ | - |
   | _VAULT-INDEX freshness | ✅/⚠️ | - |
   | Stub files | N | list shown |
   ```

7. **Suggest one priority action**
