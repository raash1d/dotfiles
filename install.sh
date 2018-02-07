#!/bin/bash

# Installation script for all configuration files
# Author: Raashid Ansari
# Date: Feb 6, 2018

# Helper functions
backup_file() {
    echo -n "backing up file $1 ..."
    if [ -f $HOME/$1 ]; then
        mv $HOME/$1 $HOME/dotfiles.backup/$1.old
    fi
    echo " done."
}

backup_folder() {
    echo -n "backing up folder $1 ..."
    if [ -d $HOME/$1 ]; then
        mv $HOME/$1 $HOME/dotfiles.backup/$1.old
    fi
    echo " done."
}

# usage: create_file_link <folder> <file>
create_file_link() {
    echo -n "creating link for $2 ..."
    if ! [ -f $HOME/.$2 ]; then
        ln -s $HOME/dotfiles/$1/$2 $HOME/.$2
    fi
    echo " done."
}

create_folder_link() {
    echo -n "creating link for folder $1 ..."
    if ! [ -d $HOME/.$1 ]; then
        ln -s $HOME/dotfiles/$1 $HOME/.$1
    fi
    echo " done."
}

# Help/Usage
if [[ $1 == '-h' ]]; then
    echo "Usage:"
    echo "install.sh [OPTIONS]"
    echo "-h show this help text"
    echo "-u update settings by pulling from git repo"
    exit 0
fi

# Update settings by downloading from git
if [[ $1 == '-u' ]]; then
    cd $HOME
    if [ -d dotfiles ]; then
        cd dotfiles
        git pull
        git submodule update --init --recursive
    fi
    exit 0
fi

# Create backup folder
if [ -d $HOME/dotfiles.backup ]; then
    mkdir $HOME/dotfiles.backup
fi

############## git specific settings #############
# Install git dependencies
sudo apt install\
    meld\
    git

# Create git symlinks
create_file_link git gitconfig
create_file_link git git_aliases
##################################################

############### vim specific steps ###############
# Remove vim-tiny
sudo apt remove vim-tiny

# Install vim dependencies
sudo apt install\
    gcc\
    g++\
    cmake\
    clang\
    vim-ctrlp\
    vim-syntastic\
    vim-gnome\
    vim-gtk3\
    vim-gtk3-py2\
    vim-autopep8\
    python-dev\
    python3-dev

# Backup vim configurations
backup_file .vimrc
backup_folder .vim

# Create symlinks for vim
create_file_link vim vimrc
create_folder_link vim 

# Install vim plugins
vim +:PlugClean +:PlugInstall

# Complete YouCompleteMe configuration
$HOME/.vim/plugged/YouCompleteMe/install.sh --clang-completer
##################################################

############### zsh specific steps ###############
# Install zsh dependencies
sudo apt install\
    fonts-powerline\
    curl

# Backup zsh configurations
backup_file .zshrc
backup_folder .oh-my-zsh

cd ~

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

create_file_link zsh zshrc
create_file_link zsh zsh_aliases

cd ~/dotfiles/zsh
git submodule update --init --recursive
cd ~
##################################################

############## tmux specific steps ###############
# Install tmux dependencies
sudo apt install\
    xclip

# Backup tmux configurations
backup_file .tmux.conf

# Create symlinks for tmux
create_file_link tmux tmux.conf
##################################################

