#!/usr/bin/env bash
set -e

eval "$(op signin)"
op item get "Ansible Vault (ansible-infra)" --fields label=password
