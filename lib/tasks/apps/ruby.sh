#!/usr/bin/env bash

ruby_install () {
  [[ $(command -v ruby-install) == "" ]] && echo "Installing ruby-install" && brew install ruby-install
  [[ $(command -v chruby) == "" ]] && echo "Installing chruby" && brew install chruby

  echo "Uninstall old rubies"
  rm -rf ~/.rubies

  echo "Activate chruby"
  source /usr/local/opt/chruby/share/chruby/chruby.sh

  echo "Install ruby"
  ruby-install ruby

  echo "Activate ruby"
  chruby ruby

  echo "Re-source chruby to detect new version"
  source /usr/local/opt/chruby/share/chruby/chruby.sh

  echo "Install ruby apps"
  gem install rails
  gem install rubocop
  gem install travis
  gem install reek
}

ruby_install
