#!/usr/bin/env bash
set -e

DEFAULT_PLAYLIST_URL=""
DOWNLOAD_DIR=""
ARCHIVE_FILE="$DOWNLOAD_DIR/archive.txt"
PLAYLIST_URL="${1:-$DEFAULT_PLAYLIST_URL}"

if [ -z "$DOWNLOAD_DIR" ]; then
  echo "No download dir set."
  exit 1
fi

if [ ! -d "$DOWNLOAD_DIR" ]; then
  mkdir -p "$DOWNLOAD_DIR"
fi

if command -v ffmpeg > /dev/null; then
  yt-dlp --extract-audio \
    --audio-format m4a \
    --audio-quality 0 \
    --download-archive "$ARCHIVE_FILE" \
    -o "$DOWNLOAD_DIR/%(title)s.%(ext)s" \
    "$PLAYLIST_URL"
else
  echo "You need ffmpeg first"
  exit 1
fi
