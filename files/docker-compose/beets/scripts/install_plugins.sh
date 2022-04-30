#!/usr/bin/env bash
set -e

function install_discogs() {
  pip install python3-discogs-client
}

function install_plugins() {
  install_discogs
}

install_plugins
