#!/bin/bash

# Installation script for all configuration files
# Author: Raashid Ansari
# Date: Feb 6, 2018
# Update: Mar 11, 2020

font="RobotoMono"

################ Helper functions ################
# usage: create_file_link <folder> <file>
create_file_link() {
    echo -n "creating link for $2 ..."
    if ! [ -f ~/$2 ]; then
        ln -s -f ~/dotfiles/$1/$2 ~/$2
    fi
    echo " done."
}

create_folder_link() {
    echo -n "creating link for folder $1 ..."
    if ! [ -d ~/$1 ]; then
        ln -s -f ~/dotfiles/$1 ~/$1
    fi
    echo " done."
}

############## git specific settings #############
git_steps() {
    # Check/Install git dependencies

    echo "Installing Meld diff viewer"
    case "$(uname)" in
        Darwin)
            brew tap homebrew/cask
            brew cask install meld
            ;;
        Linux)
            lib/install meld
            ;;
    esac

    echo "Installing Git"
    lib/install git

    # Create git symlinks
    echo "Creating git symlinks"
    (
        cd
        cp ~/dotfiles/git/.gitconfig .
    )
    echo "Cloning Git submodules"
    git submodule update --init --recursive
}
##################################################

############### vim specific steps ###############
vim_steps() {
    # Remove vim-tiny
    lib/remove vim-tiny

    echo "Installing Vim"
    case "$(uname)" in
    Darwin)
        brew install macvim
        ;;
    Linux)
        lib/install vim-gnome
        lib/install vim-gtk3
        ;;
    esac

    # Create symlinks for vim
    create_file_link .vim .vimrc
    create_folder_link .vim 

    echo "Installing plugin manager Vim-Plug"
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Install vim plugins
    vim +:PlugClean +:PlugInstall +qa
}
##################################################

############### zsh specific steps ###############
zsh_steps() {
    # Install zsh dependencies
    echo "Installing zsh"
    lib/install zsh

    # Install oh-my-zsh
    echo "Downloading and Installing oh-my-zsh framework"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # clean up previous zsh configs
    echo "Cleaning up previous zsh config files"
    (
        cd
        if [ -f .zshrc ]; then
            rm .zshrc
        fi
        
        if [ -f .zshrc.pre-oh-my-zsh ]; then
            rm .zshrc.pre-oh-my-zsh
        fi
    )
    
    create_file_link zsh .zshrc
}
##################################################

############## tmux specific steps ###############
tmux_steps() {
    # Install tmux dependencies
    echo "Installing tmux"
    lib/install tmux
    
    # Create symlinks for tmux
    create_file_link .tmux .tmux.conf
    create_file_link tmux .tmux.conf.local

    echo "Installing tmux clipboard support"
    case "$(uname)" in
    Darwin)
        lib/install reattach-to-user-namespace
        ;;
    Linux)
        lib/install xclip
        ;;
    esac
}
##################################################

############### linux specific steps ###############
install_fonts() {
    echo "Installing $font from nerd-fonts"
    # Install nerd-fonts
    # clone
    (
        cd /tmp
            if [ ! -d nerd-fonts ]; then
                git clone https://github.com/ryanoasis/nerd-fonts.git --depth=1
            fi

            # install
            cd nerd-fonts
                ./install.sh "$font"
    )
}
##################################################

############### mac specific steps ###############
# mac_steps() {
    # sudo scutil --set HostName "raashid-mac.jjj-i.com"
# }
##################################################

post_install_steps() {
    echo "Please configure your git:"
    echo "Enter your name: "
    read gitusername
    echo "Enter your email: "
    read gituseremail

    git config --global user.name "$gitusername"
    git config --global user.email "$gituseremail"

    if [[ "$(uname)" == "Darwin" ]]; then
        # make clang tools available to cli
        ln -s -f "$(brew --prefix llvm)/bin/clang-format" "/usr/local/bin/clang-format"
        ln -s -f "$(brew --prefix llvm)/bin/clang-tidy" "/usr/local/bin/clang-tidy"
    fi
}

pre_install_steps() {
    echo "Answer the following before the automated installation starts."
    echo "Enter golang toolchain tarball (.tar.gz) link from https://golang.org/dl: "
    read golangURL

    case "$(uname)" in
    Darwin)
        # install Homebrew on macOS
        if [ -x "$(command -v brew)" ]; then
            echo "Homebrew already installed"
        else
            echo "Installing Homebrew"
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        fi

        echo "Installing Python toolchain"
        lib/install python
        ;;
    Linux)
        echo "Installing Python toolchain"
        sudo apt install python3 python3-pip -y
        # echo "Enter Python toolchain tarball (.tar.xz) link from https://www.python.org/downloads/: "
        # read pythonURL

        # #install python toolchain
        # cd /tmp
            # echo "Downloading Python toolchain"
            # curl -LO --progress-bar "$pythonURL"
            # py_tarball=${pythonURL##*/} # get tarball name only
            # echo "Extracting Python toolchain"
            # tar xf "$py_tarball"
            # cd "${py_tarball%.*.*}" # get folder name only
                # echo "Installing Python toolchain"
                # ./configure --enable-optimizations
                # sudo make -j2
                # sudo make install
            # cd ..
        # cd ~/dotfiles
        ;;
    esac

    # rust toolchain
    if [ -x "$(command -v rustc)" ]; then
        echo "Rust toolchain already installed"
    else
        echo "Installing Rust toolchain"
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    fi
    
    # golang toolchain
    if [ -x "$(command -v go)" ]; then
        echo "Go toolchain already installed"
    else
        (
            cd /tmp
                echo "Downloading Go toolchain"
                curl -LO --progress-bar "$golangURL"
                echo "Installing Go toolchain"
                sudo tar -C /usr/local -xzf "${golangURL##*/}" # get name of tarball only
        )
    
        # Temporarily export go path in PATH
        export PATH="$PATH:/usr/local/go/bin"
    fi

    # tools on linux
    if [[ "$(uname)" == "Linux" ]]; then
        if [[ ("$(lsb_release -si)" == "elementary") || ("$(lsb_release -si)" == "Ubuntu") ]]; then
            echo "Installing Linux tools"
            lib/install build-essential
            lib/install software-properties-common
            lib/install clang
            lib/install clang-tools-8
            lib/install clang-tidy
            lib/install clang-format
            echo "Updating clangd alternatives"
            sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100
        fi

        # elementary OS steps
        if [[ "$(lsb_release -si)" == "elementary" ]]; then
            echo "Adding elementary-tweaks ppa"
            sudo add-apt-repository ppa:philip.scott/elementary-tweaks -y
            lib/install elementary-tweaks
        fi
    fi

    # C/C++ toolchain
    echo "Installing C/C++ toolchain"
    lib/install llvm
    lib/install cmake
    lib/install uncrustify

    # node/javascript/typescript toolchain
    echo "Installing Node/JavaScript/TypeScript toolchain"
    lib/install npm
    sudo npm install -g typescript

    # generic utilities
    echo "Install cURL utility"
    lib/install curl
}

############### steps to perform manually ###############
manual_steps() {
    step="
        To complete installation, follow below steps
        1. Change your font to $font for your terminal
        2. Reboot your system to finish installation of meld
        "
    echo "$step"
}
##################################################

main() {
    # check if OS is supported
    case "$(uname)" in
    Darwin)
        echo "You're on macOS, IT'S SUPPORTED! :)"
        ;;
    Linux)
        case "$(lsb_release -si)" in
        Ubuntu | elementary)
            echo "You're on an Ubuntu-based distro, IT'S SUPPORTED! :)"
            ;;
        *)
            echo "Unfortunately your linux distro is not supported yet. :("
            exit
            ;;
        esac
        ;;
    *)
        echo "Unfortunately your OS is not supported yet. :("
        exit
        ;;
    esac

    pre_install_steps
    git_steps
    vim_steps
    zsh_steps
    tmux_steps
    install_fonts
    post_install_steps
    manual_steps
}

main
