#!/usr/bin/env bash
set -e

RESTIC_REPO_NAME="radarr"
RESTIC_REPO_PATH="/mnt/nas_data/restic"
RESTIC_REPO="$RESTIC_REPO_PATH/$RESTIC_REPO_NAME"
RESTIC_PASSWORD_FILE="$HOME/.restic/keys/$RESTIC_REPO_NAME.key"

BACKUP_DIR="config/Backups/scheduled"

function backup_restic() {
  echo "$(date) [$RESTIC_REPO_NAME] Starting backup of $BACKUP_DIR"
  restic -r "$RESTIC_REPO" backup "$BACKUP_DIR" --password-file="$RESTIC_PASSWORD_FILE"
  echo "$(date) [$RESTIC_REPO_NAME] Backup complete"
}

function main() {
  backup_restic
}

main
