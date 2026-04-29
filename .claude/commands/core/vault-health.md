# /vault-health — Vault Health Diagnosis

> Inspect the document state of the given vault and propose improvements.
> Multi-vault: pass the target vault as an argument.

Argument: $ARGUMENTS (vault name)

## Execution Order

1. **Decide the target vault** (argument or user confirmation)

2. **Check the issue-index state**
   - Read `{vault path}/Contents/Domain/issues/ISSUE_INDEX.md`
   - Count 🔴 unresolved issues
   - Identify the oldest unresolved issue

3. **Check design ↔ spec sync**
   - Compare `{vault path}/Contents/Domain/02-design/` vs `{vault path}/Contents/Domain/03-spec/`
   - List any mismatches

4. **Check `_VAULT-INDEX.md` freshness**
   - Compare actual file structure with `_VAULT-INDEX` content
   - Flag missing files / sections

5. **Check empty / stub files**
   - Detect near-empty files (under 5 lines) under `Contents/Domain/`

6. **Print diagnosis** (table format)

   ```
   | Item | State | Action |
   |------|-------|--------|
   | Unresolved issues | N | next target: HX |
   | Design ↔ spec sync | ✅/⚠️ | - |
   | _VAULT-INDEX freshness | ✅/⚠️ | - |
   | Stub files | N | listed |
   ```

7. **Propose one priority action**
