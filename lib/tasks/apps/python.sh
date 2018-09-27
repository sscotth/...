#!/usr/bin/env bash

set -Eeox pipefail

source ./lib/utilities.sh

# Cant use -u: /usr/local/bin/virtualenvwrapper_lazy.sh: line 4: _VIRTUALENVWRAPPER_API: unbound variable

python_virtualenv () {
  boxecho "Upgrade pip"
  echo "(pip)" >&3
  pip install --upgrade pip
  pip2 install --upgrade pip
  pip3 install --upgrade pip

  boxecho "Virtual Environments for Python"
  echo "(virtualenv)" >&3
  pip install --upgrade virtualenv
  pip2 install --upgrade virtualenv
  pip3 install --upgrade virtualenv

  echo "(virtualenvwrapper)" >&3
  pip install --upgrade virtualenvwrapper
  pip2 install --upgrade virtualenvwrapper
  pip3 install --upgrade virtualenvwrapper

  boxecho "Setup directories"
  echo "(directories)" >&3
  mkdir -p $HOME/code/.virtualenvs
  export WORKON_HOME=$HOME/code/.virtualenvs
  export PROJECT_HOME=$HOME/code
  export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
  export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
  export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
  export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
  source /usr/local/bin/virtualenvwrapper.sh

  boxecho "Workon Test"
  echo "(workon)" >&3
  which workon || true

  boxecho "Exec Workon"
  workon || true

  echo "(done)" >&3
}

python_virtualenv
