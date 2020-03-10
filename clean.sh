#! /bin/bash

cd
rm -rf .gitconfig .tmux.conf\
    .vim .vimrc .aliases .zshrc .oh-my-zsh\
    ~/dotfiles/vim/plugged /opt/X11/bin/xclip
cd dotfiles

if [[ $1 == "more" ]]; then
    source lib/remove meld
    source lib/remove gcc
    source lib/remove g++
    source lib/remove cmake
    source lib/remove clang
    source lib/remove vim-gnome
    source lib/remove vim-gtk3
    source lib/remove vim-gtk3-py2
    source lib/remove python-dev
    source lib/remove python3-dev
    source lib/remove fonts-powerline
    source lib/remove pip
    source lib/remove curl
    source lib/remove xclip
fi
