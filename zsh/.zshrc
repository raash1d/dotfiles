source $HOME/dotfiles/zsh/paths.zsh
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

#ZSH_THEME="raash1d"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/dotfiles/zsh/themes

# Which plugins would you like to load? (plugins can be found in $HOME/.oh-my-zsh/plugins/*)
# Custom plugins may be added to $HOME/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
        git
        vi-mode
        sudo
        tmux
)

source $ZSH/oh-my-zsh.sh

# For a full list of active aliases, run `alias`.
source $DOTFILES/zsh/aliases.zsh

# For custom scripts
source $DOTFILES/zsh/scripts.zsh

# Run tmux if exists (https://github.com/Parth/dotfiles/blob/master/zsh/zshrc_manager.sh)
if command -v tmux >/dev/null; then
        [ -z $TMUX ] && exec tmux
else
        echo "tmux not installed"
fi

setopt extended_glob

source $DOTFILES/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $DOTFILES/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
