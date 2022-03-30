#!/usr/bin/env bash

source /opt/gruntwork/bash-commons/bootstrap.sh
source /opt/gruntwork/bash-commons/log.sh
source /opt/gruntwork/bash-commons/assert.sh
source /opt/gruntwork/bash-commons/os.sh

function install_poetry() {
  if ! os_command_is_installed poetry; then
    echo "Installing poetry..."
    curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
  else
    echo "Poetry already installed."
  fi
}

install_poetry
poetry config virtualenvs.in-project true