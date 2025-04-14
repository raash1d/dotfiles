[ -f $DOTFILES/git/git_aliases ] && source $DOTFILES/git/git_aliases

# alias to list ip output in color
alias ip="ip -c $@"

# use eza instead of ls, if eza is available
GIVE_EZA_WARNING=true
list() {
  if [ -x "$(command -v eza)" ]; then
    eza --icons --all "$@"
  else
    if "$GIVE_EZA_WARNING"; then
      echo "eza is not installed, using ls instead"
      GIVE_EZA_WARNING=false
    fi
    ls -a $@
  fi
}
alias ls="list $@"

# list files & folders after moving to new directory
# if zoxide is installed, use that instead of cd
GIVE_ZOXIDE_WARNING=true
change_directory() {
    if [ -x "$(command -v zoxide)" ]; then
      [ "$#" -eq 0 ] && z || z "$1"
    else
      if "$GIVE_EZA_WARNING"; then
        echo "zoxide is not installed, using builtin cd instead"
        GIVE_ZOXIDE_WARNING=false
      fi
      [ "$#" -eq 0 ] && builtin cd "$HOME" || builtin cd "$1"
    fi
    ls
}
alias cd="change_directory"

# use bat instead of cat, if bat is available
GIVE_BAT_WARNING=true
read_file() {
  if [ -x "$(command -v bat)" ]; then
    bat "$@"
  else
    if "$GIVE_BAT_WARNING"; then
      echo "bat is not installed, using cat instead"
      GIVE_BAT_WARNING=false
    fi
    cat "$@"
  fi
}
alias cat="read_file $@"

