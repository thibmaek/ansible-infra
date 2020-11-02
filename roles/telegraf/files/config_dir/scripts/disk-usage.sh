#!/usr/bin/env bash

echo "["
du -ks "$@" | awk '{if (NR!=1) {printf ",\n"};printf "  { \"directory_size_kilobytes\": "$1", \"path\": \""$2"\" }";}'
echo
echo "]"
