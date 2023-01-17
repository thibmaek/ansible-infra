#!/usr/bin/env bash
set -e

RESTIC_REPO_NAME=""
RESTIC_REPO_PATH="/mnt/nas_data/restic"
RESTIC_REPO="$RESTIC_REPO_PATH/$RESTIC_REPO_NAME"
RESTIC_PASSWORD_FILE="$HOME/.restic/repo.key"

echo "$(date) Pruning old restic backups"
restic -r "$RESTIC_REPO" forget --keep-last 2 --prune --password-file="$RESTIC_PASSWORD_FILE"
