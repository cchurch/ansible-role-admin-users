.PHONY: core-requirements update-pip-requirements requirements syntax-check \
	setup test cleanup tox bump-major bump-minor bump-patch

core-requirements:
	pip install "pip>=9,<9.1" setuptools "pip-tools>=1"

update-pip-requirements: core-requirements
	pip install -U "pip>=9,<9.1" setuptools "pip-tools>=1"
	pip-compile -U requirements.in

requirements: core-requirements
	pip-sync requirements.txt

syntax-check: requirements
	ansible-playbook -i tests/inventory tests/main.yml --syntax-check

setup: requirements
	ANSIBLE_HOST_KEY_CHECKING=0 ansible-playbook -i tests/inventory -vv tests/setup.yml

test: requirements
	ANSIBLE_HOST_KEY_CHECKING=0 ansible-playbook -i tests/inventory -vv tests/main.yml

cleanup: requirements
	ANSIBLE_HOST_KEY_CHECKING=0 ansible-playbook -i tests/inventory -vv tests/cleanup.yml

tox: requirements
	tox

bump-major:
	bumpversion major

bump-minor:
	bumpversion minor

bump-patch:
	bumpversion patch
