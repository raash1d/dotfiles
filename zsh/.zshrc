# Run tmux if exists (https://github.com/Parth/dotfiles/blob/master/zsh/zshrc_manager.sh)
if command -v tmux >/dev/null 2>&1; then
  [ -z $TMUX ] && exec tmux
else
  echo "tmux not installed"
fi

setopt prompt_subst
zstyle ':completion:*' menu select
fpath+=~/.zfunc
autoload bashcompinit && bashcompinit
autoload -Uz compinit
compinit

# For a full list of active aliases, run `alias`.
[ -f "$DOTFILES/zsh/aliases.zsh" ] && source "$DOTFILES/zsh/aliases.zsh" || echo "aliases.zsh not found"
[ -f "$DOTFILES/zsh/plugins.zsh" ] && source "$DOTFILES/zsh/plugins.zsh" || echo "plugins.zsh not found"

# source system specific paths, if exists
[ -e $HOME/.localrc ] && source $HOME/.localrc

# Neovim local options file path (customizable)
export NVIM_LOCAL_OPTIONS="$HOME/silabs-dotfiles/.config/nvim/lua/config/silabs-options.lua"

# fzf fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type f"

# enable vi mode
bindkey -v


if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  echo "starship not installed"
fi
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
else
  echo "zoxide not installed"
fi
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
else
  echo "direnv not installed"
fi
