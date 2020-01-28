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

ampsInit() {
  export MBD_TRACE="all"
  export MBD_CONFIG_DIR="$PWD/sample/configuration"

  if [ ! -d "$PWD/reports" ]; then
    echo -n "\"reports\" directory does not exist, creating..."
    mkdir reports
    echo "done."
  fi
  export MBD_REPORT_DIR="$PWD/reports"
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PWD/lib"
}

aSetup() {
  export PATH="$PATH:$PWD/bin/linux-$(uname -i)"
  export AEROLINK_TRACE="all"
  AEROLINK_BASE="$PWD/demo/configurations"
  export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:$PWD/lib/linux-$(uname -i)"
}

aiInit() {
  aSetup
  IEEE="ieee-v3"
  export AEROLINK_CONFIG_DIR="$AEROLINK_BASE/$IEEE/config"
  export AEROLINK_STATE_DIR="$AEROLINK_BASE/$IEEE/state"
}

aeInit() {
  aSetup
  ETSI="etsi"
  export AEROLINK_CONFIG_DIR="$AEROLINK_BASE/$ETSI/config"
  export AEROLINK_STATE_DIR="$AEROLINK_BASE/$ETSI/state"
}
