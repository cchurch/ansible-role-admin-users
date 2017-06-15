.PHONY: core-requirements update-pip-requirements requirements \
	galaxy-requirementssyntax-check setup test cleanup clean-tox tox \
	bump-major bump-minor bump-patch

core-requirements:
	pip install "pip>=9,<9.1" setuptools "pip-tools>=1"

update-pip-requirements: core-requirements
	pip install -U "pip>=9,<9.1" setuptools "pip-tools>=1"
	pip-compile -U requirements.in

requirements: core-requirements
	pip-sync requirements.txt

galaxy-requirements: requirements
	ansible-galaxy install -f -p tests/roles chrismeyersfsu.provision_docker

syntax-check: requirements galaxy-requirements
	ansible-playbook -i tests/inventory tests/main.yml --syntax-check

setup: requirements galaxy-requirements
	ANSIBLE_HOST_KEY_CHECKING=0 ansible-playbook -i tests/inventory -vv tests/setup.yml

test: requirements galaxy-requirements
	ANSIBLE_HOST_KEY_CHECKING=0 ansible-playbook -i tests/inventory -vv tests/main.yml

cleanup: requirements galaxy-requirements
	ANSIBLE_HOST_KEY_CHECKING=0 ansible-playbook -i tests/inventory -vv tests/cleanup.yml

clean-tox:
	rm -rf .tox

tox: requirements galaxy-requirements
	tox

bump-major: requirements
	bumpversion major

bump-minor: requirements
	bumpversion minor

bump-patch: requirements
	bumpversion patch
