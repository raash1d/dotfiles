#! /bin/bash

cd ~
rm -rf .git_aliases .gitconfig .tmux.conf\
    .vim .vimrc .zsh_aliases .zshrc .oh-my-zsh\
    ~/dotfiles/vim/plugged /opt/X11/bin/xclip
cd dotfiles

if [[ $1 == 'c' ]]; then
    source lib/remove meld
    source lib/remove gcc
    source lib/remove g++
    source lib/remove cmake
    source lib/remove clang
    source lib/remove vim-ctrlp
    source lib/remove vim-syntastic
    source lib/remove vim-gnome
    source lib/remove vim-gtk3
    source lib/remove vim-gtk3-py2
    source lib/remove vim-autopep8
    source lib/remove python-dev
    source lib/remove python3-dev
    source lib/remove fonts-powerline
    source lib/remove $(source lib/get_software_name pip)
    source lib/remove curl
    source lib/remove $(source lib/get_software_name xclip)
fi
