---
description: "Open multiple Obsidian notes in separate new tabs"
---

# /open-notes — Open Multiple Notes in New Tabs

## Purpose

Opens multiple specified Obsidian notes, each in a separate new tab, for simultaneous reference.

## Prerequisites

- The `local-rest-api` plugin must be installed and activated in the target vault (Core plugin)
- Obsidian must have the target vault open

## Method

The `obsidian://open` URI replaces the current tab, so it is not used here.
Instead, a two-step REST endpoint call via `local-rest-api` creates a new tab and then opens the file.

## Procedure

### 1. Finalize Target File List

- If note paths/titles/keywords are given as arguments, search via Glob to identify paths
- If the vault name is not specified, extract from the path or confirm with the user

### 2. Determine Active Vault (mandatory)

Check which vault is **currently open** in Obsidian. In a multi-vault environment, individual vaults open independently, so the path reference for the API differs.

```python
import urllib.request, json, ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

req = urllib.request.Request('https://localhost:27124/vault/',
    headers={'Authorization': f'Bearer {api_key}', 'Accept': 'application/json'})
resp = urllib.request.urlopen(req, context=ctx)
vault_info = json.loads(resp.read())
# Check the current vault root path from vault_info
```

### 3. Path Conversion (mandatory)

Convert AIMindVaults root-relative paths to **active vault-relative paths**.

```python
# Example: AIMindVaults root-relative path
full_path = 'Vaults/Projects_Game/JissouGame/Contents/Project/02-design/entities/file.md'

# If the active vault is JissouGame -> remove the vault path prefix
vault_prefix = 'Vaults/Projects_Game/JissouGame/'
vault_relative = full_path.removeprefix(vault_prefix)
# Result: 'Contents/Project/02-design/entities/file.md'
```

**Conversion rules:**
- Remove the prefix from the target file's disk path up to the vault root
- Match against vault paths in the vault registry (root `CLAUDE.md`) to identify the prefix
- If the prefix doesn't match (= file from a different vault) -> guide the user to switch vaults

### 4. Read API Key

```python
import json
api_key = json.load(open('{vault-path}/.obsidian/plugins/obsidian-local-rest-api/data.json'))['apiKey']
```

### 5. Verify File Existence (mandatory — safety check)

**Always verify file existence before calling `/open/`.** `/open/` automatically creates a new empty file if the file doesn't exist, so calling it without verification creates junk files.

```python
def check_file_exists(filepath):
    encoded = urllib.parse.quote(filepath, safe='/')
    req = urllib.request.Request(f'{base}/vault/{encoded}',
        headers={'Authorization': f'Bearer {api_key}', 'Accept': 'application/vnd.olrapi.note+json'})
    try:
        urllib.request.urlopen(req, context=ctx)
        return True
    except urllib.error.HTTPError as e:
        if e.code == 404:
            return False
        raise
```

### 6. Open Each Note in a New Tab (Python)

```python
import urllib.request, urllib.parse, json, ssl, time

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

base = 'https://localhost:27124'

def do_post(path, body=None):
    data = json.dumps(body).encode() if body else None
    req = urllib.request.Request(base + path, data=data, method='POST',
        headers={'Authorization': f'Bearer {api_key}', 'Content-Type': 'application/json'})
    resp = urllib.request.urlopen(req, context=ctx)
    return resp.status

def open_in_new_tab(filepath):
    if not check_file_exists(filepath):
        print(f'SKIP: File not found - {filepath}')
        return False
    do_post('/commands/workspace:new-tab')       # 204 = new tab created
    time.sleep(0.3)
    encoded = urllib.parse.quote(filepath, safe='/')
    do_post(f'/open/{encoded}')                   # 200 = file opened
    return True
```

### 7. If the Vault Is Not Yet Open

```bash
start "" "obsidian://open?vault=VaultName"
```

Wait 3 seconds, then proceed with REST API calls.

## Key API Reference

| Endpoint | Method | Response | Purpose |
|----------|--------|----------|---------|
| `/vault/{filepath}` | GET | 200/404 | **Verify file existence (mandatory before open)** |
| `/commands/workspace:new-tab` | POST | 204 | Create new tab |
| `/open/{filepath}` | POST | 200 | Open file in the currently active tab |
| `/commands/` | GET | 200 | List available commands |
| `/` | GET | 200 | Check API status |

- HTTPS port 27124 (self-signed cert -> SSL verify must be disabled)
- HTTP port 27123 (status check only, no authentication)
- Non-ASCII paths require `urllib.parse.quote`
- curl has encoding issues with non-ASCII characters; Python urllib is recommended

## Warnings

- **`/open/` automatically creates a new empty file if the file doesn't exist.** Calling it without path verification creates junk files/folders.
- **Paths must be relative to the active vault.** Passing AIMindVaults root-relative paths directly creates incorrect nested folders inside the vault.
- Issue details: [[20260406_open-notes_path_mismatch_empty_file_creation_issue]]

## Usage Examples

```
/open-notes JissouGame design_doc_A, design_doc_B
/open-notes AIHubVault _STATUS, _WORKSPACE_VERSION
```

## Limitations

- The target vault must be open in Obsidian for REST API access
- API keys differ per vault — the key from the currently open vault must be read
- A 0.3-second delay is required between tab creation and file opening (Obsidian internal processing time)

## Difference from /open-note

| | /open-note | /open-notes |
|---|-----------|------------|
| Method | Advanced URI plugin | local-rest-api plugin |
| Tabs | Single (replaces existing tab) | Multiple (each in a new tab) |
| Use case | Quickly open 1 note | Simultaneously reference multiple related notes |
