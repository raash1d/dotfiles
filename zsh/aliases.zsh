if [ -f $DOTFILES/git/git_aliases ]; then
    source $DOTFILES/git/git_aliases
fi

alias ip_addr='ip -c addr' # alias to list ip output in color

# list files & folders after moving to new directory
c() {
    cd $1;
    ls;
}
alias cd="c"       

# tmux aliases
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'
