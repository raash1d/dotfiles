# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

export DOTFILES=$HOME/dotfiles

# source system specific paths, if exists
if [ -e $HOME/.localrc ]; then
    source ~/.localrc
fi

