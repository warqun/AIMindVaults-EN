"""
YouTube URL -> Obsidian markdown note generator
Usage: python yt_to_note.py "https://youtube.com/..."
"""
import sys
import re
import os
import json
import subprocess
import tempfile
from datetime import datetime

VAULT_PATH = "C:/Dev_Game/Obsidian/GameDesign/Projects_VamSurLike"
OUTPUT_DIR = os.path.join(VAULT_PATH, "References/YouTube")

def get_video_info(url):
    result = subprocess.run(
        ["python", "-m", "yt_dlp", "--dump-json", "--no-playlist", url],
        capture_output=True, text=True, encoding="utf-8"
    )
    if result.returncode != 0:
        print(f"Failed to fetch video info: {result.stderr}")
        sys.exit(1)
    return json.loads(result.stdout)

def download_subtitle(url, tmpdir):
    # Prefer English, fall back to Korean
    for lang in ["en", "ko"]:
        result = subprocess.run(
            ["python", "-m", "yt_dlp",
             "--write-auto-sub", "--sub-lang", lang,
             "--skip-download", "--sub-format", "vtt",
             "-o", os.path.join(tmpdir, "sub"), url],
            capture_output=True, text=True, encoding="utf-8"
        )
        vtt_files = [f for f in os.listdir(tmpdir) if f.endswith(".vtt")]
        if vtt_files:
            return os.path.join(tmpdir, vtt_files[0])
    return None

def vtt_to_text(vtt_path):
    with open(vtt_path, "r", encoding="utf-8") as f:
        content = f.read()

    lines = content.split("\n")
    text_lines = []
    for line in lines:
        line = line.strip()
        if not line:
            continue
        if line == "WEBVTT":
            continue
        if re.match(r"^\d{2}:\d{2}", line):  # timestamp
            continue
        if line.startswith("NOTE") or line.startswith("align:") or line.startswith("position:"):
            continue
        # Strip HTML tags
        line = re.sub(r"<[^>]+>", "", line)
        line = re.sub(r"&amp;", "&", line)
        line = re.sub(r"&lt;", "<", line)
        line = re.sub(r"&gt;", ">", line)
        line = line.strip()
        if line:
            text_lines.append(line)

    # Remove consecutive duplicates
    deduped = []
    for line in text_lines:
        if not deduped or deduped[-1] != line:
            deduped.append(line)

    # Join short lines into a paragraph
    return " ".join(deduped)

def safe_filename(title):
    safe = re.sub(r'[\\/:*?"<>|]', "-", title)
    return safe[:80].strip()

def create_note(url):
    print(f"Fetching video info...")
    info = get_video_info(url)
    title = info.get("title", "Unknown")
    channel = info.get("channel", "")
    upload_date = info.get("upload_date", "")

    if upload_date:
        upload_date_str = f"{upload_date[:4]}-{upload_date[4:6]}-{upload_date[6:]}"
    else:
        upload_date_str = datetime.now().strftime("%Y-%m-%d")

    print(f"Downloading subtitles: {title}")
    with tempfile.TemporaryDirectory() as tmpdir:
        vtt_path = download_subtitle(url, tmpdir)
        if not vtt_path:
            print("No subtitles found.")
            sys.exit(1)
        transcript = vtt_to_text(vtt_path)

    today = datetime.now().strftime("%Y-%m-%d")
    content = f"""---
tags:
  - youtube
  - transcript
url: "{url}"
channel: "{channel}"
upload_date: {upload_date_str}
created: {today}
---

# {title}

> [!info]
> - Channel: {channel}
> - Uploaded: {upload_date_str}
> - Source: {url}

## Transcript

{transcript}
"""

    os.makedirs(OUTPUT_DIR, exist_ok=True)
    filename = safe_filename(title) + ".md"
    output_path = os.path.join(OUTPUT_DIR, filename)

    with open(output_path, "w", encoding="utf-8") as f:
        f.write(content)

    print(f"Note created: References/YouTube/{filename}")
    return output_path

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python yt_to_note.py <YouTube URL>")
        sys.exit(1)
    url = sys.argv[1].strip()
    create_note(url)
