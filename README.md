# Ansible Playbooks

## Getting started

__Make sure SSH configs are set up according to inventory.yaml!__

```shell
# Setup this repo
$ make install

# Perform a play
$ ansible-playbook -v playbooks/init.yaml

# Performa a play on a specific host
$ ansible-playbook -v playbooks/common.yaml -l rpi_node_tresor
```
