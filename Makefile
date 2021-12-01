LOCAL_PLAYBOOK=$(playbook)

lint:
	yamllint playbooks/ && \
		yamllint roles/ && \
		yamllint tasks/
	ansible-lint -p playbooks/ && \
		ansible-lint -p roles/ && \
		ansible-lint -p tasks/

dependencies:
	pip install --upgrade -r requirements.txt
	ansible-galaxy install --force -r requirements.yaml
	pre-commit install
	ansible all -m ping

play_common:
	ansible-playbook -v playbooks/common.yaml

play_upgrade:
	ansible-playbook -v playbooks/upgrades.yaml

play_volumio:
	ansible-playbook --skip-tags=update playbooks/volumio/main.yaml

play_local:
	ansible-playbook -v $(LOCAL_PLAYBOOK) --connection=local --ask-become-pass
