install:
	pip install --upgrade ansible pre-commit
	ansible-galaxy install -r requirements.yaml
	ansible all -m ping

play_common:
	ansible-playbook -v playbooks/common.yaml
