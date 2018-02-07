#! /bin/bash

cd ~
rm -rf .git_aliases .gitconfig .tmux.conf .vim .vimrc .zsh_aliases .zshrc .oh-my-zsh

if [[ $1 == 'c' ]]; then
    sudo apt -y remove\
        meld\
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
        python3-dev\
        fonts-powerline\
        python3-pip\
        curl\
        xclip
fi
