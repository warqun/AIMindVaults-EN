---
description: Video note script extraction and markdown conversion process
---
# Video Note Extraction Workflow (create-video-note)

**Purpose**: A standard procedure for extracting metadata and auto-generated subtitle scripts from YouTube videos (etc.) using `yt-dlp`, then generating a markdown note based on that content at a designated vault location (Contents directory).
**Key Mandatory Rule**: Running `yt-dlp` and any temporary parsing scripts must never leave traces in the main vault path (CWD) being worked on. Only the system temp folder (`$env:TEMP`) may be used, and it must be immediately cleaned up afterward.

## Step-by-Step Instructions

### Step 1: Create Temporary Working Folder
- To prevent leftover files in the main system, always create a random working folder under `%TEMP%` (on Windows: `$env:TEMP`).
- Use `mkdir` or similar to create a unique temp folder (`$env:TEMP\aimind_vid_extract_{timestamp}`).

### Step 2: Run `yt-dlp` Inside the Temporary Folder
- Move to (or specify the CWD as) the temporary folder created in Step 1, then run the `yt-dlp` command.
- Use options like `--dump-json --write-auto-sub --sub-lang ko --skip-download` to ensure metadata and scripts are saved only **inside the temporary folder**.
- If the video title contains special characters or encoding issues, simplify the output file prefix/format as a precaution.

### Step 3: Parse Script and Create Target Note
- Read the downloaded metadata (json) and subtitle (vtt, etc.) files from the temporary folder. (Any parsing scripts like Python must also run within this temp folder.)
- Based on the extracted text and title, compose a **markdown note** enriched with the video's key content and frontmatter.
- Save the completed markdown note file directly to the final location in the user-specified target vault (`Contents/Domain` or `Contents/Project` subdirectory, etc.).

### Step 4: Force Delete Temporary Folder
- Once the note is written and saved to the target location, **completely force-delete** the `$env:TEMP\aimind_vid_extract_{timestamp}` directory and all its contents using `Remove-Item -Force -Recurse` or equivalent.
- Always verify cleanup before process termination to prevent leftover file leaks.

### Step 5: Final Report
- Notify the user that temporary folder cleanup is fully complete.
- Report the final location (`path/filename`) of the generated video note in the target vault so the user can immediately verify it.
