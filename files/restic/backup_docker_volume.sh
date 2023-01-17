#!/usr/bin/env bash
set -e

RESTIC_REPO_NAME=""
RESTIC_REPO_PATH="/mnt/nas_data/restic"
RESTIC_REPO="$RESTIC_REPO_PATH/$RESTIC_REPO_NAME"
RESTIC_PASSWORD_FILE="$HOME/.restic/keys/repo.key"

DOCKER_VOLUMES_DIR="/var/lib/docker/volumes"
DOCKER_VOLUME=""
BACKUP_DIR="$DOCKER_VOLUMES_DIR/$DOCKER_VOLUME/_data"

function guard() {
  if [[ "$EUID" -ne 0 ]]; then
    echo "Please make sure you're root in order to access volumes in $DOCKER_VOLUMES_DIR"
    exit 1
  fi
}

function backup_restic() {
  echo "$(date) Starting backup of docker volume: $DOCKER_VOLUME"
  restic -r "$RESTIC_REPO" backup "$BACKUP_DIR" --password-file="$RESTIC_PASSWORD_FILE"
  echo "$(date) Backup complete"
}

function main() {
  guard
  backup_restic
}

main
