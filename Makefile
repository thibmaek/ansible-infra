lint:
	yamllint playbooks/ && \
		yamllint roles/ && \
		yamllint tasks/
	ansible-lint -p playbooks/ && \
		ansible-lint -p roles/ && \
		ansible-lint -p tasks/

dependencies:
	pip install --upgrade -r requirements.txt
	asdf reshim python || echo 'asdf not installed'
	ansible-galaxy install --force -r requirements.yaml
	pre-commit install
