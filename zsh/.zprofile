[ -f "$HOME/dotfiles/zsh/exports.zsh" ] && source "$HOME/dotfiles/zsh/exports.zsh" || echo "exports.zsh not found"
[ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env" || echo "$HOME/.cargo/env not found"
# export nvim as default editor if it is installed
[ -x "$(command -v nvim)" ] && export EDITOR="nvim" || echo "nvim not found, using default editor"
