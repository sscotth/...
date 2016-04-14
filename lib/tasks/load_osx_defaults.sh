#!/usr/bin/env bash
#
# SUDO: Load OSX defaults

load_osx_defaults () {
  echo "(may require restart)" >&3

  mathiasbynens_osx_edit
  mathiasbynens_osx_load
  personal_osx_load

  my_sleep "${@}"
}

### LOCAL ###

mathiasbynens_osx_edit () {
  echo "remove kill affected applicaitons at end of mathiasbynens .osx script"
  sed '/^# Kill affected applications/,$d' math_dotfiles/.osx > /tmp/.osx_nokill
}

mathiasbynens_osx_load () {
  echo "loading mathiasbynens' sensible hacker defaults"
  cd math_dotfiles
  yes | sh /tmp/.osx_nokill
  cd ..
}

personal_osx_load () {
  echo "loading personal osx preferences"
  sh .osx_supplement
}
