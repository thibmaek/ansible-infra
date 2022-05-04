#!/usr/bin/env bash
set -e

if [ -n "$CI" ]; then
  echo "stubbed"
  exit 0
fi

eval "$(op signin)"
op item get "Ansible Vault (ansible-infra)" --fields label=password
