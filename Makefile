# special makefile variables
.DEFAULT_GOAL := help
.RECIPEPREFIX := >

# recursively expanded variables
SHELL = /usr/bin/sh

# targets
HELP = help
SETUP = setup
CLEAN = clean

# executables
PYTHON = python
PIP = pip
NPM = npm
PRE_COMMIT = pre-commit

# simply expanded variables
executables := \
	${PYTHON}\
	${NPM}

_check_executables := $(foreach exec,${executables},$(if $(shell command -v ${exec}),pass,$(error "No ${exec} in PATH")))

.PHONY: ${HELP}
${HELP}:
	# inspired by the makefiles of the Linux kernel and Mercurial
>	@printf '%s\n' 'Common make targets:'
>	@printf '%s\n' '  ${SETUP}                - installs the distro-independent dependencies for this'
>	@printf '%s\n' '                         project'
>	@printf '%s\n' '  ${CLEAN}                - removes files generated from targets'

.PHONY: ${SETUP}
${SETUP}:
>	${NPM} install
>	${PYTHON} -m ${PIP} install --upgrade "${PIP}"
>	${PYTHON} -m ${PIP} install --requirement "./requirements-dev.txt"
>	${PRE_COMMIT} install

.PHONY: ${CLEAN}
${CLEAN}:
>	sudo rm \
		--recursive \
		--force \
		"./deb/dists" \
		"./deb/pool" \
		kubectl_* \
		/etc/apt/sources.list.d/kubectl-*
