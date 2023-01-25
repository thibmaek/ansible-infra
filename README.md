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

## Order of running plays (Debian)

![Mermaid](https://mermaid.ink/img/pako:eNpdj9EKgzAMRX9F8qz7gA725L5geyyM0EYts63UVBjivy9OHWP3IST3HkIyg4mWQEGbcOiKe33WoRC54PgxUpooVdVlJM7DPm75ryOAid7HsEVbL6aN5nnwX1Oq45hcaP-C00dQgqfk0Vm5aV4RDdyRJw1KWksN5p416LAImgeLTFe7bgTVYD9SCZg53l7BgOKU6YBqh_Ki36nlDXsqU-I)

## Styleguide

This follows:

- [Ansible Best Practices](https://docs.ansible.com/ansible/latest/user_guide/playbooks_best_practices.html)
- [Whitecloud Ansible Styleguide](https://github.com/whitecloud/ansible-styleguide)

## Performing common plays

Common plays (like common.yaml and upgrades.yaml) are available with make:

- `make play_common`
- `make play_upgrade`

## Encrypting secrets (via vault)

```console
$ ansible-vault encrypt_string 'secret' --name 'var_name'
```
