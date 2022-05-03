#!/usr/bin/env bash
set -e

# Keychain query fields.
# LABEL is the value you put for "Keychain Item Name" in Keychain.app.
LABEL="ansible-vault-password"
ACCOUNT_NAME="$(whoami)"

function set_password() {
  /usr/bin/security add-generic-password -a "$ACCOUNT_NAME" -s "$LABEL" -w
}

function get_password() {
  /usr/bin/security find-generic-password -w -a "$ACCOUNT_NAME" -l "$LABEL"
}

"${@:-get_password}"
