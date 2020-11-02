#!/usr/bin/env bash
set -e

for file in ./**/*.go; do
  echo "Compiling $file"
  GOOS=linux GOARCH=arm go build -o "${file%.*}_linux_arm" "$file"
  GOOS=linux GOARCH=amd64 go build -o "${file%.*}_linux_amd64" "$file"
done
