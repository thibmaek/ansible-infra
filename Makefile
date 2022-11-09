dependencies:
	pip install --upgrade -r requirements.txt
	asdf reshim python || echo 'asdf not installed'
	ansible-galaxy install --force -r requirements.yaml
	pre-commit install

lint_yaml:
	yamllint playbooks/ && \
		yamllint roles/ && \
		yamllint tasks/

lint_ansible:
	ansible-lint ./**/*

lint: lint_yaml lint_ansible

export_graph:
	ansible-playbook-grapher --include-role playbooks/init_server.yaml
