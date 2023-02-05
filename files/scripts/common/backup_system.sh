#! /usr/bin/env bash
set -e

SOURCE="/"

if [ -z "$1" ]; then
  echo "Provide the destination to backup to as the first argument"
  echo "e.g. ./backup_system.sh /mnt/drive1"
  exit 1
fi

echo "
[backup_system]

  This will backup the system to an external source or folder.
    Backup: $SOURCE ➡ $1
    Excluded directories: /dev/*, /proc/*, /sys/*, /tmp/*, /run/*, /mnt/*, /media/*, /lost+found

  Terminate this process in 10 seconds if you do not want to proceed.
"

sleep 10

echo "
[backup_system]: Performing backup

"

rsync -aAXPv "$SOURCE" \
  --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} \
  "$1"
