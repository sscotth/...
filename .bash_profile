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
