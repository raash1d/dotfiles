# general exports used on every machine

RUST_PATH="$HOME/.cargo/bin"
GO_PATH="/usr/local/go/bin"
export DOTFILES="$HOME/dotfiles"

# export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH:$RUST_PATH:$GO_PATH"

if [[ $(uname -o) -eq "Darwin" ]]; then
  HOMEBREW_PATH="/opt/homebrew/bin"
  export PATH="$PATH::$HOMEBREW_PATH"
  export XDG_CONFIG_HOME="$HOME/.config"
fi

# zoxide: Print the matched directory before navigating to it when set to 1
export _ZO_ECHO=1
