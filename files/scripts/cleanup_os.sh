#!/usr/bin/env bash
set -e

# Check if sudo
if [[ "$EUID" -ne 0 ]]; then
  echo "[WARN]: Please run this script as root"
  exit 1
fi

function list_large_dirs() {
  echo "Found the following 10 largest directories for $1"
  du -h "$1" --max-depth=1 | sort -n -r | head -n 10
}

# Cleanup apt registry
apt autoremove

# Remove old systemd collected logs
journalctl --vacuum-time=30d

# Remove unused Docker images
if command -v docker > /dev/null; then
  docker image prune -a -f
fi

# List large root directories
list_large_dirs /
