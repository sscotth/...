#!/usr/bin/env bash

python_virtualenv () {

  echo "Upgrade pip"
  pip install --upgrade pip
  pip3 install --upgrade pip

  echo "Virtual Environments for Python"
  pip install --upgrade virtualenv
  pip3 install --upgrade virtualenv

  pip install --upgrade virtualenvwrapper
  pip3 install --upgrade virtualenvwrapper

  echo "Setup directories"
  mkdir -p ~/code ~/.virtualenvs
  WORKON_HOME=~/.virtualenvs
  PROJECT_HOME=~/code
  VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
  source /usr/local/bin/virtualenvwrapper_lazy.sh

  echo "Workon Test"
  which workon

  echo "Exec Workon"
  workon || true

}

python_virtualenv
