#!/usr/bin/env bash
set -e

MONGO_DB_PATH="/usr/lib/unifi/data/db"
UNIFI_LOG_PATH="/usr/lib/unifi/logs/server.log"

function get_repair_script() {
  echo "Downloading repair script..."
  wget https://help.ui.com/hc/en-us/article_attachments/360008640574/CK_repair.js \
    -O /root/mongodb_repair.js
}

function stop_units() {
  echo "Stopping UniFi Controller and MongoDB..."
  systemctl stop unifi
  systemctl stop mongodb
}

function start_units() {
  echo "Starting UniFi Controller and MongoDB..."
  systemctl start mongodb
  systemctl start unifi
}

function repair_prune() {
  echo "Repairing Mongo database..."
  mongod --dbpath "$MONGO_DB_PATH" --smallfiles --logpath "$UNIFI_LOG_PATH" --repair
  echo "Restarting MongoDB (forked)..."
  mongod --dbpath "$MONGO_DB_PATH" --smallfiles --logpath "$UNIFI_LOG_PATH" --fork
  echo "Pruning 'stat' collections..."
  mongo < /root/mongodb_repair.js
  echo "Shutting down MongoDB (forked)..."
  mongod --dbpath "$MONGO_DB_PATH" --smallfiles --logpath "$UNIFI_LOG_PATH" --shutdown
}

function main() {
  get_repair_script
  stop_units
  repair_prune
  start_units
}
