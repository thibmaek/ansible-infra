dependencies:
	pip install --upgrade -r requirements.txt
	asdf reshim python || echo 'asdf not installed'
	ansible-galaxy install --force -r requirements.yaml
	pre-commit install

lint_shell:
	shellcheck files/scripts/*.sh
	shellcheck files/restic/*.sh

lint_yaml:
	yamllint playbooks/ && \
		yamllint roles/ && \
		yamllint tasks/ && \
		yamllint group_vars/ && \
		yamllint files/docker_compose/

lint_ansible:
	ansible-lint ./**/*

lint: lint_yaml lint_shell lint_ansible

export_graph:
	ansible-playbook-grapher --include-role playbooks/init_server.yaml
