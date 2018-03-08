#!/bin/bash

# Installation script for all configuration files
# Author: Raashid Ansari
# Date: Feb 6, 2018

################ Helper functions ################
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
##################################################

# Create backup folder
create_backup_folder() {
    if ! [ -d $HOME/dotfiles.backup ]; then
        mkdir $HOME/dotfiles.backup
    fi
}

############## git specific settings #############
git_steps() {
    # Check/Install git dependencies
    source lib/install meld
    source lib/install git

    # Create git symlinks
    create_file_link git gitconfig
    create_file_link git git_aliases
}
##################################################

############### vim specific steps ###############
vim_steps() {
    # Remove vim-tiny
    source lib/remove vim-tiny

    # Install vim dependencies
    source lib/install gcc
    source lib/install g++
    source lib/install cmake
    source lib/install clang
    source lib/install vim-gnome
    source lib/install vim-gtk3
    source lib/install vim-gtk3-py2
    source lib/install python-dev
    source lib/install python3-dev

    # Backup vim configurations
    backup_file .vimrc
    backup_folder .vim

    # Create symlinks for vim
    create_file_link vim vimrc
    create_folder_link vim 

    # Install vim plugins
    vim +:PlugClean +:PlugInstall +qa

    # Complete YouCompleteMe configuration
    $HOME/.vim/plugged/YouCompleteMe/install.py --clang-completer
}
##################################################

############### zsh specific steps ###############
zsh_steps() {
    # Install zsh dependencies
    source lib/install zsh
    source lib/install fonts-powerline
    source lib/install $(source lib/get_software_name pip) 
    source lib/install curl

    if [[ $(source lib/check_os) == "mac" ]]; then
        "$(sudo port select --set pip pip36)"
    fi

    # Backup zsh configurations
    backup_folder .oh-my-zsh

    cd ~

    # Install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Backup zsh configurations (has to be done here since oh-my-zsh.sh
    # creates one in the previous step.
    backup_file .zshrc

    create_file_link zsh zshrc

    cd ~/dotfiles/zsh
    git submodule update --init --recursive
    cd ~
}
##################################################

############## tmux specific steps ###############
tmux_steps() {
    cd ~/dotfiles
    # Install tmux dependencies
    source lib/install tmux
    source lib/install $(source lib/get_software_name xclip)

    # OS dependent post-processing
    if [[ $(source lib/check_os) == "mac" ]]; then
        sudo ln -s /opt/local/bin/xclipboard /opt/local/bin/xclip
    fi

    # Backup tmux configurations
    backup_file .tmux.conf

    # Create symlinks for tmux
    create_file_link tmux tmux.conf
}
##################################################

############### linux specific steps ###############
linux_steps() {
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts
    curl -fLo "Roboto Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf
    curl -fLo "Roboto Mono Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete%20Mono.ttf
    fc-cache -f -v # rebuild font cache
}
##################################################

############### mac specific steps ###############
mac_steps() {
    sudo scutil --set HostName "raashid-mac.jjj-i.com"
    cd ~/Library/Fonts
    curl -fLo "Roboto Mono Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf
    curl -fLo "Roboto Mono Nerd Font Complete Mono.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete%20Mono.ttf
    fc-cache -f -v # rebuild font cache
}
##################################################

############### steps to perform manually ###############
manual_steps() {
    echo "change your font to Roboto Mono for terminal/iterm2"
}
##################################################

main() {
    create_backup_folder
    git_steps
    vim_steps
    zsh_steps
    tmux_steps
    if [[ $(source lib/check_os) == "mac" ]]; then
        mac_steps
    elif [[ $(source lib/check_os) == "linux" ]]; then
        linux_steps
    fi
    cd ~/dotfiles
    manual_steps
}

main
