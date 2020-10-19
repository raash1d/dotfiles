if [ -f $DOTFILES/git/git_aliases ]; then
    source $DOTFILES/git/git_aliases
fi

alias ipaddr='ip -c addr' # alias to list ip output in color

# use exa instead of ls
list() {
    exa --icons --all "$@"
}
alias ls="list $@"

# list files & folders after moving to new directory
change_directory() {
    z "$1"
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
