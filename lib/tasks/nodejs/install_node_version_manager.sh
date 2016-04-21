#!/usr/bin/env bash
#
# Node.js functions

export NVM_SYMLINK_CURRENT=true

echo $CONCURRENT_TASK_NAME

install_node_version_manager () {
  # remove nvm, npm, and installed nodes
  rm -rf ~/.nvm ~/.npm

  curl -o- https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
  . ~/.nvm/nvm.sh
}

install_node_version_manager
