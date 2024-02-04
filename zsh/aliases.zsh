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
change_directory() {
    [ "$#" -eq 0 ] && builtin cd "$HOME" || builtin cd "$1"
    ls
}
alias cd="change_directory"

# use bat instead of cat
read_file() {
    bat "$@"
}
alias cat="bat $@"

# tmux aliases
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'
