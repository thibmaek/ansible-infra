#! /usr/bin/env bash
set -e

if [ ! -d "./backup" ]; then
  mkdir ./backup
fi

if [ ! -d "./backup/uploads" ]; then
  mkdir ./backup/uploads
fi

echo "Backing up SQLite file..."
docker compose cp bar-assistant:/var/www/cocktails/storage/bar-assistant/database.sqlite ./backup/database.sqlite

echo "Backing up SQL data"
docker compose exec bar-assistant sqlite3 /var/www/cocktails/storage/bar-assistant/database.sqlite .dump > ./backup/db_dump.sql

echo "Backing up images"
rm -rf ./backup/uploads
docker compose cp bar-assistant:/var/www/cocktails/storage/bar-assistant/uploads ./backup/uploads
