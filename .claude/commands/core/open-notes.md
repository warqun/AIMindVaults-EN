---
description: "Open multiple Obsidian notes, each in a new tab"
---

# /open-notes — Open Multiple Notes in New Tabs

## Purpose

Open multiple specified Obsidian notes, each in its own new tab, so they can be referenced side by side.

## Prerequisites

- The `local-rest-api` plug-in must be installed and enabled in the target vault (Core plug-in).
- Obsidian must already have the target vault open.

## Approach

The `obsidian://open` URI replaces the current tab — do not use it.
Use a 2-step REST call against `local-rest-api`: create a new tab, then open the file.

## Procedure

### 1. Resolve the target file list

- If the argument provides note paths / titles / keywords, find paths via Glob.
- If the vault name is unspecified, derive it from the path or confirm with the user.

### 2. Determine the active vault (required)

Check **which vault is currently open** in Obsidian. In a multi-vault environment each vault is opened independently, so the path basis sent to the API differs.

```python
import urllib.request, json, ssl

ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

req = urllib.request.Request('https://localhost:27124/vault/',
    headers={'Authorization': f'Bearer {api_key}', 'Accept': 'application/json'})
resp = urllib.request.urlopen(req, context=ctx)
vault_info = json.loads(resp.read())
# Inspect vault_info to learn the active vault root.
```

### 3. Path conversion (required)

Convert AIMindVaults-root-relative paths into **paths relative to the active vault**.

```python
# Example: an AIMindVaults-root-relative path
full_path = 'Vaults/<category>/<vault>/Contents/Project/02-design/<sub>/file.md'

# If the active vault is <vault>, strip the vault-root prefix:
vault_prefix = 'Vaults/<category>/<vault>/'
vault_relative = full_path.removeprefix(vault_prefix)
# Result: 'Contents/Project/02-design/<sub>/file.md'
```

**Conversion rules:**
- From the target file's disk path, strip the prefix up to the vault root.
- Identify the prefix by matching against the vault paths in the registry (root `CLAUDE.md`).
- If the prefix does not match (= file from a different vault) → tell the user to switch vaults.

### 4. Read the API key

```python
import json
api_key = json.load(open('{vault path}/.obsidian/plugins/obsidian-local-rest-api/data.json'))['apiKey']
```

### 5. File-existence check (required — safety)

**Always verify the file exists before calling `/open/`.** `/open/` auto-creates an empty file when it is missing — calling it without verification creates junk files.

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
        print(f'SKIP: file missing - {filepath}')
        return False
    do_post('/commands/workspace:new-tab')       # 204 = new tab created
    time.sleep(0.3)
    encoded = urllib.parse.quote(filepath, safe='/')
    do_post(f'/open/{encoded}')                   # 200 = open file
    return True
```

### 7. If the vault is not yet open

```bash
start "" "obsidian://open?vault=<vault-name>"
```

Wait 3 seconds, then proceed with the REST API calls.

## Key API Reference

| Endpoint | Method | Response | Purpose |
|----------|--------|----------|---------|
| `/vault/{filepath}` | GET | 200/404 | **File-existence check (required before open)** |
| `/commands/workspace:new-tab` | POST | 204 | Create a new tab |
| `/open/{filepath}` | POST | 200 | Open the file in the active tab |
| `/commands/` | GET | 200 | List available commands |
| `/` | GET | 200 | API health check |

- HTTPS port 27124 (self-signed cert → disable ssl verification).
- HTTP port 27123 (status check only, no auth).
- Non-ASCII paths require `urllib.parse.quote`.
- `curl` has trouble with non-ASCII encoding — Python `urllib` is recommended.

## Warnings

- **`/open/` auto-creates an empty file when missing.** Calling without path verification creates junk files / folders.
- **The path must be relative to the active vault.** Passing an AIMindVaults-root-relative path inserts an incorrect nested folder under the vault.

## Examples

```
/open-notes <vault> <note title 1>, <note title 2>
/open-notes <vault> _STATUS, _WORKSPACE_VERSION
```

## Limitations

- The vault must be open in Obsidian for REST API access.
- The API key is per vault — read the key from the vault that is open.
- A 0.3-second delay is required between tab creation and file open (Obsidian's internal processing).

## vs. `/open-note`

|        | /open-note | /open-notes |
|--------|------------|-------------|
| Method | Advanced URI plug-in | local-rest-api plug-in |
| Tabs   | Single (replaces current) | Multiple (each in a new tab) |
| Use    | Open one note quickly | Reference several related notes side by side |
