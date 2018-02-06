#!/bin/bash

# Installation script for my vim settings
# Author: Mohammad Raashid Ansari
# Date: Aug 21, 2017

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
    if [ -d .vim ]; then
        cd .vim
        git pull
    fi
    exit 0
fi

# Install essential vim plugins and dependencies
sudo apt install meld\
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

# Make vim directory in home folder
#git clone https://github.com/raash1d/vim-settings $HOME/.vim
if ! [ -f $HOME/.vimrc ]; then
    ln -s $HOME/.vim/vimrc $HOME/.vimrc
fi
if ! [ -f $HOME/.gitconfig ]; then
    ln -s $HOME/.vim/gitconfig $HOME/.gitconfig
fi
vim +:PlugClean +:PlugInstall
$HOME/.vim/plugged/YouCompleteMe/install.sh --clang-completer
