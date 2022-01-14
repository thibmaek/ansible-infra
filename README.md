# Ansible Playbooks

## Getting started

__Make sure SSH configs are set up according to inventory.yaml!__

```shell
# Setup this repo:
$ make install

# Perform a play:
$ ansible-playbook -v playbooks/init_server.yaml

# Performa a play on a specific host:
$ ansible-playbook -v playbooks/common.yaml -l rpi_node_tresor

# Perform a play directly on current host:
$ make play_local playbook=playbooks/local/macos.yaml
```

## Styleguide

This follows:

- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
- [Whitecloud Ansible Styleguide](https://github.com/whitecloud/ansible-styleguide)

## Performing common plays

Common plays (like common.yaml and upgrades.yaml) are available with make:

- `make play_common`
- `make play_upgrade`
