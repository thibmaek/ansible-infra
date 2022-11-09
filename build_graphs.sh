#!/usr/bin/env bash

for playbook in ./playbooks/*.yaml; do
  ansible-playbook-grapher "$playbook" --output-file-name "docs/$playbook" --ask-vault-pass
done
