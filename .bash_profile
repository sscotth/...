load_mathiasbynens_bash_dotfiles () {
  local file;

  for file in $HOME/.dotfiles/math_dotfiles/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r $file ] && [ -f $file ] && source $file;
  done;
}

load_own_bash_dotfiles () {
  local file;

  for file in $HOME/.{path,bash_prompt,exports,aliases,functions,extra}; do
    [ -r $file ] && [ -f $file ] && source $file;
  done;
}

load_mathiasbynens_bash_dotfiles
load_own_bash_dotfiles

# iTerm2 v3 Shell Integration
# https://iterm2.com/shell_integration.html
test -e ${HOME}/.iterm2_shell_integration.bash && source ${HOME}/.iterm2_shell_integration.bash

# [z - jump around](https://github.com/rupa/z)
. `brew --prefix`/etc/profile.d/z.sh
