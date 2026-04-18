---
description: "Open multiple Obsidian notes, each in a new tab"
---

# /open-notes — Open Multiple Notes in New Tabs

## Purpose

Open several Obsidian notes, each in its own tab, so you can reference them side by side.

## Prerequisites

- The `local-rest-api` plugin must be installed and enabled in the target vault (core plugin).
- Obsidian must have the target vault open.

## Approach

`obsidian://open` URI replaces the current tab, so we don't use it.
Use two local-rest-api REST calls: create a new tab, then open the file.

## Procedure

### 1. Resolve the target file list

- If arguments supply paths/titles/keywords, Glob to resolve the paths.
- If the vault name isn't specified, extract from the path or ask the user.

### 2. Detect the active vault (required)

Determine which vault Obsidian **currently has open**. In a multi-vault setup each vault is opened independently, so the path base that the API expects differs per vault.

```python
import urllib.request, json, ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

req = urllib.request.Request('https://localhost:27124/vault/',
    headers={'Authorization': f'Bearer {api_key}', 'Accept': 'application/json'})
resp = urllib.request.urlopen(req, context=ctx)
vault_info = json.loads(resp.read())
# Confirm the currently-open vault root from vault_info
```

### 3. Path conversion (required)

Convert a path relative to the AIMindVaults root into a path **relative to the active vault root**.

```python
# Example: relative to the AIMindVaults root
full_path = 'Vaults/Projects_<area>/<YourProject>/Contents/Project/02-design/entity/file.md'

# If the active vault is <YourProject> → strip the vault-path prefix
vault_prefix = 'Vaults/Projects_<area>/<YourProject>/'
vault_relative = full_path.removeprefix(vault_prefix)
# Result: 'Contents/Project/02-design/entity/file.md'
```

**Rules:**
- Strip the vault-root prefix from the target file's disk path.
- Use the vault path in the vault registry (root `CLAUDE.md`) to identify the prefix.
- If the prefix doesn't match (= file belongs to a different vault) → tell the user to switch vaults.

### 4. Read the API key

```python
import json
api_key = json.load(open('{vault-path}/.obsidian/plugins/obsidian-local-rest-api/data.json'))['apiKey']
```

### 5. Verify the file exists (required — safety gate)

**Always verify existence before calling `/open/`.** `/open/` auto-creates an empty file when the target is missing, so calling without a check leaves garbage files behind.

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

### 6. Open each note in a new tab (Python)

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
        print(f'SKIP: file not found - {filepath}')
        return False
    do_post('/commands/workspace:new-tab')       # 204 = new tab created
    time.sleep(0.3)
    encoded = urllib.parse.quote(filepath, safe='/')
    do_post(f'/open/{encoded}')                   # 200 = file opened
    return True
```

### 7. If the vault isn't open yet

```bash
start "" "obsidian://open?vault=VaultName"
```

Wait 3 seconds, then call the REST API.

## Key API Reference

| Endpoint | Method | Response | Purpose |
|----------|--------|----------|---------|
| `/vault/{filepath}` | GET | 200/404 | **File existence check (required before open)** |
| `/commands/workspace:new-tab` | POST | 204 | Create a new tab |
| `/open/{filepath}` | POST | 200 | Open the file in the current active tab |
| `/commands/` | GET | 200 | List available commands |
| `/` | GET | 200 | Check API status |

- HTTPS port 27124 (self-signed cert → disable SSL verify).
- HTTP port 27123 (no auth — status check only).
- URL-encode non-ASCII paths (`urllib.parse.quote`).
- curl mis-encodes non-ASCII; prefer Python urllib.

## Warnings

- **`/open/` auto-creates an empty file if missing.** Calling without path verification produces garbage files/folders.
- **Paths MUST be relative to the active vault.** Passing an AIMindVaults-root-relative path creates incorrectly nested folders inside the vault.

## Examples

```
/open-notes AIHubVault _STATUS, _WORKSPACE_VERSION
/open-notes <YourVault> note_a, note_b
```

## Limitations

- The target vault must be open in Obsidian for the REST API to be reachable.
- The API key is per-vault — read the key from the currently-open vault.
- A 0.3 s delay is needed between tab creation and file open (Obsidian internal timing).

## vs. /open-note

| | /open-note | /open-notes |
|---|-----------|------------|
| Mechanism | Advanced URI plugin | local-rest-api plugin |
| Tabs | Single (replaces current) | Multiple (each in a new tab) |
| Use case | Quickly open one note | Reference several related notes at once |
