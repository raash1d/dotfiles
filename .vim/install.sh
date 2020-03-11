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
    cd
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
#git clone https://github.com/raash1d/vim-settings ~/.vim
if ! [ -f ~/.vimrc ]; then
    ln -s ~/.vim/vimrc ~/.vimrc
fi
if ! [ -f ~/.gitconfig ]; then
    ln -s ~/.vim/gitconfig ~/.gitconfig
fi
vim +:PlugClean +:PlugInstall
~/.vim/plugged/YouCompleteMe/install.sh --clang-completer
