install:
	pip install --upgrade ansible pre-commit
	ansible-galaxy install -r requirements.yaml
	ansible all -m ping
