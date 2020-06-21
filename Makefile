install:
	pip install --upgrade ansible pre-commit yamllint
	pre-commit install
	ansible all -m ping

play_common:
	ansible-playbook -v playbooks/common.yaml
