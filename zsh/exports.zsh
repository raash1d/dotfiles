# general exports used on every machine

# add rust toolchain to PATH
RUST_PATH="$HOME/.cargo/bin"

# add go toolchain to PATH
GO_PATH="/usr/local/go/bin"

export DOTFILES="$HOME/dotfiles"

# export PATH="$HOME/bin:/usr/local/bin:$PATH"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH:$RUST_PATH:$GO_PATH"

