#!/usr/bin/env bash
set -eo pipefail

SQL_CONTAINERS=$(docker ps --format "{{.Names}}:{{.Image}}" | grep "mysql\|mariadb" | cut -d ":" -f1)
echo "Found SQL containers: $SQL_CONTAINERS"

DATABASE=""
CONTAINER=""
MYSQL_PASSWORD=""

docker exec -e MYSQL_PASSWORD="$MYSQL_PASSWORD" \
  "$CONTAINER" \
  /usr/bin/mysqldump -u root "$DATABASE" \
  | gzip > "$CONTAINER-$DATABASE-$(date +"%y-%m-%d_%H-%M").sql.gz"
