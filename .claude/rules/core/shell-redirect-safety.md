# Shell Redirect Safety (Mandatory)

> Applies uniformly to every vault and every agent.
> Built from the 2026-04-21 incident — mixing the CMD-syntax `2>nul` into Git Bash / MSYS2 generated 41k+ literal `nul` files. Root cause is the POSIX-compatibility design of Cygwin / MSYS2 (Windows-reserved names are accepted as ordinary filenames). For the detailed analysis and the recommended defense layers, see the deep-research note on the cumulative `nul`-file generation issue (2026-04-21).

## 1. Per-Shell NUL-Redirect Syntax (must be memorized)

| Shell | Discard stderr | Discard stdout | Both |
|-------|---------------|----------------|------|
| Bash (Git Bash · Linux · macOS) | `2>/dev/null` | `>/dev/null` | `>/dev/null 2>&1` |
| PowerShell 5 / 7 | `2>$null` | `>$null` | `*>$null` |
| Windows CMD | `2>nul` | `>nul` | `>nul 2>&1` |

Never mix per-shell syntax inside a single command.

## 2. Shell-Identification Criteria (for agent self-correction)

- **Claude Code Bash tool** → Git Bash environment (MSYS2 runtime). Use **Bash syntax only**.
- **Codex Bash tool** → same (note: Windows-native Codex hooks are currently inactive)
- `powershell -Command` · `pwsh -Command` → PowerShell syntax
- `cmd /c` · `.bat` · `.cmd` → CMD syntax
- **If unsure, do not redirect at all** — use the upper tool's native null-handling (e.g., a `--quiet` flag instead of `> /dev/null`).

## 3. Hard Forbid

- **`2>nul` / `>nul` / `2>NUL` in Bash** — Bash interprets `nul` as an **ordinary filename** and creates an empty `nul` file in CWD. This is the **intentional POSIX-compatibility design** of MSYS2 / Cygwin, not a bug.
- **`2>nul` in PowerShell** — use `2>$null` (`nul` is treated as a literal file).
- **Using a Windows-reserved name (CON / PRN / AUX / NUL / COM1-9 / LPT1-9) as a literal filename or folder** — adding an extension does not help (`nul.txt`, `aux.md`, etc.).

## 4. Cross-Platform Principle

Distributed scripts default to **Bash syntax (`2>/dev/null`)**. Use CMD / PowerShell-specific syntax only in Windows-only scripts. Since AIMindVaults is distributed cross-platform (Win / Mac / Linux), Bash syntax has the best portability.

## 5. Multi-Layer Defense (deployed in AIMindVaults)

### 5.1 Agent Layer — Claude Code `PreToolUse` hook

**Deploy location**: `.claude/hooks/block_nul_redirection.py` · `.claude/settings.json` `hooks.PreToolUse.Bash`

Inspects the command string just before a Bash-tool invocation and returns `decision: "deny"` when `2>nul` / `>nul` patterns are detected. The LLM prompt is advisory; the hook is **deterministic**.

**Codex constraint**: Windows-native hooks are currently inactive — bypass via wrapper / proxy is required (see `.claude/templates/ci/bashrc-nul-trap.sh`).

### 5.2 Shell Layer — Bash DEBUG trap

**Template**: `.claude/templates/ci/bashrc-nul-trap.sh`

Append to `~/.bashrc` or any init file the agent sources. The `DEBUG` trap inspects `BASH_COMMAND` immediately before execution and blocks Windows-style NUL redirects. Unlike `PROMPT_COMMAND`, it also catches non-interactive agent invocations.

### 5.3 Repository Layer — Git pre-commit hook

**Templates**: `.claude/templates/ci/pre-commit-reserved-names.sh` + `check-reserved-names.sh`

Install at `.git/hooks/pre-commit` (or chain via husky / lefthook). Blocks the commit when the staged diff contains any reserved name (CON / PRN / AUX / NUL / COM1-9 / LPT1-9). Apply to the deployment repos under `C:/SellingVault/Korean|English/AIMindVaults/.git/hooks/`.

### 5.4 CI Layer — GitHub Actions

**Template**: `.claude/templates/ci/deny-reserved-names.yml`

Install as `.github/workflows/deny-reserved-names.yml` in the deployment repos. On push / pull_request, scan the entire tree → fail the workflow when reserved names exist. pre-commit guards local push; CI guards force-push and external PRs.

### 5.5 Filesystem Layer — Obsidian vault watcher

**Template**: `.claude/templates/ci/vault-watcher.js`

Watches the vault root via Node `fs.watch`. Initial full scan + real-time watch. Run as background via Obsidian Shell Commands `startup` event · PM2 · systemd.

## 6. Incident Rule: Bash `2>nul` Creates Orphan Files (Mandatory)

**Detection**:
- A Bash-tool command containing CMD syntax such as `2>nul`, `>nul`, `2>NUL`, `&>nul`, `2>>nul`
- Found while the agent is authoring it, or in an existing script

**Immediate correction**: in Bash, use **`2>/dev/null` · `>/dev/null`** only. Violations are auto-blocked by `.claude/hooks/block_nul_redirection.py`.

**Post-handling** (when files were already created):
- Windows `nul` is reserved; ordinary `rm` · `Remove-Item` · `del` cannot delete it (interpreted as a device).
- Use **the `\\?\<full_path>\nul` UNC prefix + `[System.IO.File]::Delete()`** — disables string parsing and passes the path straight to the filesystem.
- `Test-Path -LiteralPath '\\?\...\nul'` always returns false — call Delete directly without checking and handle the exception.
- PowerShell example:
  ```powershell
  [System.IO.File]::Delete('\\?\C:\path\to\nul')
  ```

**Throughput ranking** (estimated, per research):
1. Native Rust / C++ `DeleteFileW` loop (UTF-16 directly, minimal overhead)
2. PowerShell `[System.IO.File]::Delete('\\?\...')` loop (object-wrapper overhead)
3. `cmd del \\?\...` batch (highest risk of reserved-name parser collision; not recommended)

## 7. Incident Rule: PowerShell Recursive-Scan Early Termination (Mandatory)

When searching for `nul` files, **do not use `Get-ChildItem -Recurse -Filter nul`**.

**Root cause** (research-confirmed): the issue is not in Windows `FindFirstFileEx` / `FindNextFile`, but in **the PowerShell FileSystemProvider failing to materialize FileInfo**. `-ErrorAction SilentlyContinue` only suppresses output and does not restore the recursion. Result: only the upper layer is exposed and the lower subtree is hidden.

**Symptom**: a "delete → re-scan → more found" pattern (50 → 19 → 41,440 etc.). The scan does not "discover" omissions; the **previously hidden subtree is exposed step-by-step**.

**Correct scan methods** (in order of reliability):

1. **cmd `dir /A /B /S` + `findstr /i "\\nul$"`** — Windows directory-listing API; no reserved-name ghosts.
2. **Python `os.scandir` / `os.walk`** — calls `FindFirstFileW` / `FindNextFileW` directly on Windows; no PowerShell intermediate layer.
3. **Rust `walkdir` crate** — defaults to `follow_links(false)`; best performance for large trees.
4. **PowerShell `Get-ChildItem -Recurse` (without Filter) + `Where-Object { $_.Name -eq 'nul' }`** — bypassing Filter reduces ghosts (edge cases may remain).

**Verification** (whether a scan result is a real file):

```powershell
# Real file → Exists=True; ghost → False
[System.IO.File]::Exists('\\?\C:\path\to\nul')
```

When `[System.IO.File]::Delete('\\?\...')` is called, an exception message stating "Access denied to '\\.\nul'" indicates no file; success means a real file is deleted.

**Reference incident**: 2026-04-21 AIMindVaults — `Get-ChildItem -Filter nul` returned 41,440 entries; `cmd dir` returned 0. The total real deletions are 50 + 19 + 41,440 (interpreted as the hidden subtree being unfolded in stages).

## 8. Incident Rule: Obsidian Shell Commands Plugin Shell Audit (Mandatory)

The Obsidian Shell Commands plugin lets you choose the global default shell among CMD / PS5 / PS7 / custom. If `nul` appears inside a **dynamically-generated folder** like `.space/` or `#tag/`, that is a clue that an automatic command ran in Git Bash / a custom bash during an Obsidian session.

**Audit procedure**:
1. Check the global default-shell setting.
2. Check per-command override shell.
3. Verify whether the custom shell path is `bash.exe` / `sh.exe` / `git-bash.exe`.
4. Check commands triggered by `startup` / `open-file` / `create-file` events.
5. Search every command string for `nul`, `NUL`, `2>nul`, `>nul`, `sh -c`, `bash -lc`.
6. Pause suspicious commands or replace with `/dev/null` syntax.

## 9. Full Windows Reserved Names (extended)

| Category | Names |
|----------|-------|
| Devices | `NUL`, `CON`, `PRN`, `AUX` |
| Serial ports | `COM1`, `COM2`, `COM3`, `COM4`, `COM5`, `COM6`, `COM7`, `COM8`, `COM9` |
| Parallel ports | `LPT1`, `LPT2`, `LPT3`, `LPT4`, `LPT5`, `LPT6`, `LPT7`, `LPT8`, `LPT9` |

Case-insensitive. Adding an extension does not help (`nul.txt`, `con.md`, etc.). The same shell-mixing accident can cause equally severe failures with `con`, `aux`, `prn`, etc.

## 10. References

- Deep research (external LLM): the 2026-04-21 cumulative-`nul`-file generation note
- 2026-04-21 incident distribution change log: rules R069 ~ R072
- Claude Code hooks official docs: https://docs.claude.com/en/docs/claude-code/hooks
- Microsoft DOS reserved names + `\\?\` UNC prefix: MSDN Win32 File Namespaces
- Templates directory: `.claude/templates/ci/` (5 files)
- Hook deploy location: `.claude/hooks/block_nul_redirection.py` + `.claude/settings.json`
