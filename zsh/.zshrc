# Run tmux if exists (https://github.com/Parth/dotfiles/blob/master/zsh/zshrc_manager.sh)
if command -v tmux >/dev/null 2>&1; then
  [ -z $TMUX ] && exec tmux
else
  echo "tmux not installed"
fi

# setup starship prompt
eval "$(starship init zsh)"

source "$DOTFILES/zsh/plugins.zsh"

# source system specific paths, if exists
[ -e $HOME/.localrc ] && source $HOME/.localrc

# fzf fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="fd --type f"

# enable vi mode
bindkey -v

autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

eval "$(zoxide init zsh)"
