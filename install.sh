#!/bin/bash

# Installation script for all configuration files
# Author: Raashid Ansari
# Date: Feb 6, 2018

################ Helper functions ################
# usage: create_file_link <folder> <file>
create_file_link() {
    echo -n "creating link for $2 ..."
    if ! [ -f ~/$2 ]; then
        ln -s ~/dotfiles/$1/$2 ~/$2
    fi
    echo " done."
}

create_folder_link() {
    echo -n "creating link for folder $1 ..."
    if ! [ -d ~/$1 ]; then
        ln -s ~/dotfiles/$1 ~/$1
    fi
    echo " done."
}

############## git specific settings #############
git_steps() {
    # Check/Install git dependencies

    case "$(uname)" in
        Darwin)
            if [ -x "$(command -v brew)" ]; then
                brew tap homebrew/cask
                brew cask install meld
            else
                echo "Only Homebrew is supported on macOS."
            fi
            ;;
        Linux)
            lib/install meld
    esac

    lib/install git

    # Create git symlinks
    (
        cd
        cp ~/dotfiles/git/.gitconfig .
    )
    git submodule update --init --recursive
}
##################################################

############### vim specific steps ###############
vim_steps() {
    # Remove vim-tiny
    lib/remove vim-tiny

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

    # Install plugin manager Vim-Plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    # Install vim plugins
    vim +:PlugClean +:PlugInstall +qa

    # Complete YouCompleteMe configuration
    ~/.vim/plugged/YouCompleteMe/install.py --clang-completer --clangd-completer --go-completer --ts-completer --rust-completer
}
##################################################

############### zsh specific steps ###############
zsh_steps() {
    # Install zsh dependencies
    lib/install zsh

    # Install oh-my-zsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    create_file_link zsh .zshrc

    cd ~/dotfiles/zsh
    cd
}
##################################################

############## tmux specific steps ###############
tmux_steps() {
    cd ~/dotfiles
    # Install tmux dependencies
    lib/install tmux
    
    # Create symlinks for tmux
    (
        cd
        ln -s -f dotfiles/.tmux/.tmux.conf
        ln -s -f dotfiles/tmux/.tmux.conf.local
    )

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
    # Install nerd-fonts
    # clone
    cd /tmp
        git clone https://github.com/ryanoasis/nerd-fonts.git --depth=1
        # install
        cd nerd-fonts
            ./install.sh Inconsolata
        # clean-up a bit
        cd ..
        rm -rf nerd-fonts
    cd
}
##################################################

############### mac specific steps ###############
# mac_steps() {
    # sudo scutil --set HostName "raashid-mac.jjj-i.com"
# }
##################################################

post_install_steps() {
    echo "Please configure your git:"
    echo -n "Enter your name: "
    read gitusername
    echo -n "Enter your email: "
    read gituseremail

    git config --global user.name "$gitusername"
    git config --global user.email "$gituseremail"

    if [[ "$(uname)" -eq "Darwin" ]]; then
        # make clang tools available to cli
        ln -s "$(brew --prefix llvm)/bin/clang-format" "/usr/local/bin/clang-format"
        ln -s "$(brew --prefix llvm)/bin/clang-tidy" "/usr/local/bin/clang-tidy"
    fi
}

pre_install_steps() {
    echo "Answer the following before the automated installation starts."
    echo -n "Enter golang toolchain tarball (.tar.gz) link from https://golang.org/dl: "
    read golangURL

    case "$(uname)" in
    Darwin)
        # install Homebrew on macOS
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
        brew install python
        ;;
    Linux)
        sudo apt install python3 python3-pip -y
        # echo -n "Enter Python toolchain tarball (.tar.xz) link from https://www.python.org/downloads/: "
        # read pythonURL

        # #install python toolchain
        # cd /tmp
            # curl -LO --progress-bar "$pythonURL"
            # py_tarball=${pythonURL##*/} # get tarball name only
            # tar xf "$py_tarball"
            # cd "${py_tarball%.*.*}" # get folder name only
                # ./configure --enable-optimizations
                # sudo make -j2
                # sudo make install
            # cd ..
        # cd ~/dotfiles
        ;;
    esac

    # rust toolchain
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    
    # golang toolchain
    cd /tmp
        curl -LO --progress-bar "$golangURL"
        sudo tar -C /usr/local -xzf "${golangURL##*/}" # get name of tarball only
    cd -

    # tools on linux
    if [[ "$(uname)" -eq "Linux" ]]; then
        if [[ ("$(lsb_release -si)" -eq "elementary") || ("$(lsb_release -si)" -eq "Ubuntu") ]]; then
            sudo apt install -y build-essential software-properties-common clang clang-tools-8 clang-tidy clang-format
            sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100
        fi

        # elementary OS steps
        if [[ "$(lsb_release -si)" -eq "elementary" ]]; then
            sudo add-apt-repository ppa:philip.scott/elementary-tweaks
            sudo apt install elementary-tweaks -y
        fi
    fi

    # C/C++ toolchain
    lib/install llvm
    lib/install cmake
    lib/install uncrustify

    # node/javascript/typescript toolchain
    lib/install npm
    sudo npm install -g typescript

    # generic utilities
    lib/install curl
}

############### steps to perform manually ###############
manual_steps() {
    echo "To complete installation, follow below steps"
    echo "1. Change your font to Inconsolata for your terminal"
    echo "3. Reboot your system to finish installation of meld"
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
        Ubuntu)
            echo "You're on Ubuntu, IT'S SUPPORTED! :)"
            ;;
        elementary)
            echo "You're on elementaryOS, IT'S SUPPORTED! :)"
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

    cd ~/dotfiles
    post_install_steps
    manual_steps
}

main
