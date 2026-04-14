# /vault-health — Vault Health Diagnosis

> Inspects the document status of a specified vault and suggests improvements.
> Multi-vault: Specify the target vault as an argument.

Arguments: $ARGUMENTS (vault name)

## Execution Order

1. **Determine Target Vault** (from argument or confirm with user)

2. **Check Issue Index Status**
   - Read `{vault-path}/Contents/Domain/issues/ISSUE_INDEX.md`
   - Count open issues
   - Identify the oldest open issue

3. **Check Design-Spec Sync**
   - Compare `{vault-path}/Contents/Domain/02-design/` vs `{vault-path}/Contents/Domain/03-spec/`
   - If mismatches exist, output the list

4. **Check _VAULT-INDEX.md Currency**
   - Compare actual file structure against _VAULT-INDEX contents
   - Flag any missing files/sections

5. **Check for Empty or Stub Files**
   - Detect files under `Contents/Domain/` with minimal content (fewer than 5 lines)

6. **Output Diagnosis Results** (table format)

   ```
   | Item | Status | Action Needed |
   |------|--------|---------------|
   | Open issues | N items | Next target: HX |
   | Design-spec sync | OK/Warning | - |
   | _VAULT-INDEX currency | OK/Warning | - |
   | Stub files | N items | Show list |
   ```

7. **Suggest 1 Priority Action**
