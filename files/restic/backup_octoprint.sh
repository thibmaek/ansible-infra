#!/usr/bin/env bash
set -e

RESTIC_REPO_NAME="octoprint"
RESTIC_REPO_PATH="/mnt/nas_data/restic"
RESTIC_REPO="$RESTIC_REPO_PATH/$RESTIC_REPO_NAME"
RESTIC_PASSWORD_FILE="$HOME/.restic/repo.key"

BACKUP_DIR="$HOME/.octoprint/data/backup"

function clean() {
  echo "Cleaning previous backups"
  rm -rf "$BACKUP_DIR/*.zip"
}

function backup_octoprint() {
  echo "Creating Octoprint backup"
  /home/pi/oprint/bin/octoprint plugins backup:backup
}

function backup_restic() {
  echo "Backing up Octoprint to restic"
  restic -r "$RESTIC_REPO" backup "$BACKUP_DIR" --password-file="$RESTIC_PASSWORD_FILE"
}

function main() {
  echo "$(date) Starting backup"
  clean
  backup_octoprint && backup_restic
  echo "$(date) Backup complete"
}

main
