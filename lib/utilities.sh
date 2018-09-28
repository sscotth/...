#!/usr/bin/env bash
#
# utility functions
#

source ./.functions

mas_cli_signin () {
  echo "Sorry, mas-cli signin is not working. Please login to the app store..."
  echo "https://github.com/mas-cli/mas/issues/107"
  open -a "/Applications/App Store.app"

  # if command_exists mas; then
  #   if mas account; then
  #     echo
  #     echo "You have the mac app store command line interface and are signed in"
  #     echo
  #   else
  #     echo
  #     echo "You have the mac app store command line interface and are NOT signed in"
  #     echo
  #     echo
  #     read -p "Apple ID Email: " APPLE_ID_EMAIL
  #     mas signin --dialog $APPLE_ID_EMAIL
  #     mas_cli_signin
  #   fi
  # else
  #   if command_exists brew; then
  #     echo
  #     echo "You need the mac app store command line interface"
  #     echo
  #     brew install mas
  #     mas_cli_signin
  #   else
  #     echo "You need the mac app store command line interface. Install homebrew first"
  #     exit 1
  #   fi
  # fi
}

git_clone_or_pull () {
  if [ -z ${2:-} ]; then
    local dir=$(basename $1 .git)
  else
    local dir=$2
  fi

  if [ -d $dir ]; then
    echo "(Pull)" >&3
    git -C $dir reset --hard
    git -C $dir pull origin master
  else
    echo "(Clone)" >&3
    GIT_TRACE=2 GIT_CURL_VERBOSE=2 GIT_TRACE_PERFORMANCE=2 GIT_TRACE_PACK_ACCESS=2 GIT_TRACE_PACKET=2 GIT_TRACE_PACKFILE=2 GIT_TRACE_SETUP=2 GIT_TRACE_SHALLOW=2 git clone $1 $dir ${@:3}
  fi
}

brew_install_or_upgrade () {
  if brew ls --versions "$1" >/dev/null; then
      HOMEBREW_NO_AUTO_UPDATE=1 brew upgrade "$1" || true
  else
      HOMEBREW_NO_AUTO_UPDATE=1 brew install "$1"
  fi
}

boxecho () {
  msg="# $* #"
  edge=$(echo "$msg" | sed 's/./#/g')

  if command_exists lolcat; then
    echo -e "\n$edge\n$msg\n$edge\n" | lolcat
  else
    echo -e "\n$edge\n$msg\n$edge\n"
  fi
}

# Retries a command on failure
# Based on http://fahdshariff.blogspot.com/2014/02/retrying-commands-in-shell-scripts.html
# TODO: Accept optional MAX_ATTEMPTS and DELAY arguments
retry_command () {
    local -r -i MAX_ATTEMPTS=3
    local -r -i DELAY=10
    local -i index=1
    echo "==> RETRY_COMMAND <=="

    until $@; do
      local exit_status=$?
      echo "Exit code: $exit_status"

        if [[ $exit_status -eq 72 ]]; then
            echo Unrecoverable Error 72
            return 72
        elif (( index == MAX_ATTEMPTS )); then
            echo "Attempt $index failed and there are no more attempts left!"
            # echo "(Attempt $index failed!)" >&3
            return 1
        else
            echo "Attempt $index failed! Trying again in $(( DELAY * index )) seconds..."
            # echo "(Attempt $index failed. Waiting $(( DELAY * index )) seconds...)" >&3
            sleep $(( DELAY * index++ ))
        fi
    done
}

# Caches the sudo password as a variable for scripts.
# Some scripts cannot be as sudo like homebrew, but requires a password during certain tasks.
# Use psudo for those scripts.
cached_psudo () {
  if [ -z ${SUDOPASS+x} ]; then
    read -s -p "SUDO Password:" SUDOPASS
    export SUDOPASS=$SUDOPASS
    echo ''
  fi

  base64_cmd=$(echo $@ | base64 | tr -d '\n')

  /usr/bin/expect <<EOD
    set timeout -1
    spawn ./lib/base64_eval.sh $base64_cmd
    expect {
      "*?assword:*" { send "$SUDOPASS\n"; exp_continue }
      eof
    }
    catch wait result
    exit [lindex \$result 3]
EOD
}

cached_sudo () {
  if [ -z ${SUDOPASS+x} ]; then
    read -s -p "SUDO Password:" SUDOPASS
    export SUDOPASS=$SUDOPASS
    echo ''
  fi

  base64_cmd=$(echo sudo $@ | base64 | tr -d '\n')
  echo "base64_cmd: $base64_cmd"

  /usr/bin/expect <<EOD
    set timeout -1
    spawn ./lib/base64_eval.sh $base64_cmd
    expect {
      "*?assword:*" { send "$SUDOPASS\n"; exp_continue }
      eof
    }
    catch wait result
    exit [lindex \$result 3]
EOD
}

# cached_sudo () {
#   request_password_and_cache
#
#   base64_cmd=$(echo sudo $@ | base64 | tr -d '\n')
#   echo
#   echo "base64_cmd: $base64_cmd"
#   echo
#   expect_use_cached_password
# }
#
# cached_psudo () {
#   request_password_and_cache
#
#   base64_cmd=$(echo $@ | base64 | tr -d '\n')
#   echo
#   echo "base64_cmd: $base64_cmd"
#   echo
#   expect_use_cached_password
# }
#
# request_password_and_cache () {
#   if [ -z ${SUDOPASS+x} ]; then
#     read -s -p "SUDO Password:" SUDOPASS
#     SUDOPASS=$SUDOPASS
#     echo
#   fi
# }
#
# expect_use_cached_password () {
#   /usr/bin/expect <<EOD
#     set timeout -1
#     spawn ./lib/base64_eval.sh $base64_cmd
#     expect {
#       "*?assword:*" { send "$SUDOPASS\n"; exp_continue }
#       eof
#     }
#
#     catch wait result
#     exit [lindex \$result 3]
# EOD
# }

# Loads nvm into the current shell
load_nvm () {
  echo "LOADING nvm.sh"

  export NVM_DIR="$HOME/.nvm"
  . "/usr/local/opt/nvm/nvm.sh"

  echo "Loaded nvm v$(nvm --version)"
}
