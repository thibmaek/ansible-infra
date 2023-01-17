#!/usr/bin/env bash
set -e

RESTIC_REPO_NAME="sabnzbd"
RESTIC_REPO_PATH="/mnt/nas_data/restic"
RESTIC_REPO="$RESTIC_REPO_PATH/$RESTIC_REPO_NAME"
RESTIC_PASSWORD_FILE="$HOME/.restic/keys/$RESTIC_REPO_NAME.key"

BACKUP_DIR="config"

function backup_restic() {
  echo "$(date) [$RESTIC_REPO_NAME] Starting backup of $BACKUP_DIR"
  restic -r "$RESTIC_REPO" backup "$BACKUP_DIR" \
    --exclude "*.bak" \
    --exclude "logs" \
    --exclude "Downloads" \
    --password-file="$RESTIC_PASSWORD_FILE"
  echo "$(date) [$RESTIC_REPO_NAME] Backup complete"
}

function main() {
  backup_restic
}

main
