LOCAL_PLAYBOOK=$(playbook)

lint:
	yamllint playbooks/
	yamllint tasks/

dependencies:
	pip install --upgrade ansible ansible-lint pre-commit yamllint
	ansible-galaxy install -r requirements.yaml
	pre-commit install
	ansible all -m ping

play_common:
	ansible-playbook -v playbooks/common.yaml

play_upgrade:
	ansible-playbook -v playbooks/upgrades.yaml

play_local:
	ansible-playbook -v $(LOCAL_PLAYBOOK) --connection=local --ask-become-pass
