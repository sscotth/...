#!/usr/bin/env bash

set -Eeox pipefail
# Cant use -u: /usr/local/opt/chruby/share/chruby/chruby.sh: line 4: PREFIX: unbound variable

source ./lib/utilities.sh

ruby_install () {
  boxecho "Get latest versions"
  echo "(Get latest versions)" >&3
  local latest_ruby=$(ruby-install --latest | grep -B 1 "jruby:" | head -1 | awk '{$1=$1};1')

  boxecho "Activate chruby"
  echo "(activate)" >&3
  source /usr/local/opt/chruby/share/chruby/chruby.sh

  if ruby -v | grep "${latest_ruby}p"; then
    boxecho "Latest version: $(ruby -v) already installed"
    echo "($(ruby -v))" >&3
  else
    boxecho "Uninstall old rubies"
    echo "(uninstall)" >&3
    rm -rf ~/.rubies

    boxecho "Install ruby"
    echo "(installing...)" >&3
    ruby-install ruby

    boxecho "Re-source chruby to detect new version"
    echo "(source)" >&3
    source /usr/local/opt/chruby/share/chruby/chruby.sh

    boxecho "Activate ruby"
    echo "(activate)" >&3
    chruby ruby
  fi

  boxecho "Install ruby apps"

  echo "(rails)" >&3
  gem install rails

  echo "(rubocop)" >&3
  gem install rubocop

  echo "(travis)" >&3
  gem install travis

  echo "(reek)" >&3
  gem install reek

  echo "(done)" >&3
}

ruby_install
