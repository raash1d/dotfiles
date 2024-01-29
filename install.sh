#!/bin/bash

# Installation script for all configuration files
# Author: Raashid Ansari
# Date: Feb 6, 2018
# Update: Mar 11, 2020

SUDO=
if [ "$(whoami)" != root ]; then
    SUDO=$SUDO
fi
export SUDO

font="RobotoMono"
font_path="https://raw.githubusercontent.com/ryanoasis/nerd-fonts/master/patched-fonts/RobotoMono/Regular/complete/Roboto%20Mono%20Nerd%20Font%20Complete.ttf"

################ Helper functions ################
# usage: create_file_link <folder> <file> [link-name]
create_file_link() {
    echo -n "creating link for $2 ..."
    if ! [ -f "$HOME/$2" ]; then
        if [ "$#" -eq 3 ]; then
            ln -s -f "$HOME/dotfiles/$1/$2" "$HOME/$3"
        elif [ "$#" -eq 2 ]; then
            ln -s -f "$HOME/dotfiles/$1/$2" "$HOME/$2"
        fi
    fi
    echo " done."
}

create_folder_link() {
    echo -n "creating link for folder $1 ..."
    if ! [ -d "$HOME/$1" ]; then
        ln -s -f "$HOME/dotfiles/$1" "$HOME/$1"
    fi
    echo " done."
}

############## git specific settings #############
git_steps() {
    # Check/Install git dependencies

    # echo "Installing Meld diff viewer"
    # case "$(uname)" in
    # Darwin)
    # 	brew tap homebrew/cask
    # 	brew cask install meld
    # 	;;
    # Linux)
    # 	# lib/install meld
    # 	;;
    # esac

    echo "Installing Git"
    lib/install git

    # Create git symlinks
    echo "Creating git symlinks"
    cp "$HOME/dotfiles/git/.gitconfig" "$HOME/"

    # echo "Cloning Git submodules"
    # git submodule update --init --recursive
}
##################################################

############### vim specific steps ###############
# vim_steps() {
#     # Remove vim-tiny
#     lib/remove vim-tiny
#
#     echo "Installing Vim"
#     case "$(uname)" in
#     Darwin)
#         brew install macvim
#         ;;
#     Linux)
#         lib/install vim-gnome
#         lib/install vim-gtk3
#         ;;
#     esac
#
#     # Create symlinks for vim
#     create_file_link .vim .vimrc
#     create_folder_link .vim
#
#     echo "Installing plugin manager Vim-Plug"
#     curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
#         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#
#     # Install vim plugins
#     vim +:PlugClean +:PlugInstall +qa
# }
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
    [ -f ~/.zshrc ] && rm .zshrc
    [ -f ~/.zshrc.pre-oh-my-zsh ] && rm ~/.zshrc.pre-oh-my-zsh

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

    echo "Installing tmux clipboard support and creating links to local tmux configs"
    case "$(uname)" in
    Darwin)
        lib/install reattach-to-user-namespace
        create_file_link tmux .tmux.conf.local.macos .tmux.conf.local
        ;;
    Linux)
        lib/install xclip
        create_file_link tmux .tmux.conf.local.linux .tmux.conf.local
        ;;
    esac
}
##################################################

############### linux specific steps ###############
install_fonts() {
    echo "Installing $font from nerd-fonts"
    font_name="Roboto Mono Nerd Font Complete.ttf"
    #(
    #cd /tmp
    # clone nerd-fonts repo
    #if [ ! -d nerd-fonts ]; then
    #git clone https://github.com/ryanoasis/nerd-fonts.git --depth=1
    #fi

    # install
    #cd nerd-fonts
    #./install.sh "$font"
    #)

    case "$(uname)" in
    Linux)
        mkdir -p ~/.local/share/fonts
        curl -fLo "$HOME/.local/share/fonts/$font_name" "$font_path"
        ;;
    Darwin)
        curl -fLo "/Users/$(whoami)/Library/Fonts/$font_name" "$font_path"
        ;;
    esac
    fc-cache -vf
}
##################################################

############### mac specific steps ###############
# mac_steps() {
# $SUDO scutil --set HostName "raashid-mac.jjj-i.com"
# }
##################################################

post_install_steps() {
    echo "Please configure your git:"
    echo "Enter your name: "
    read -r gitusername
    echo "Enter your email: "
    read -r gituseremail

    git config --global user.name "$gitusername"
    git config --global user.email "$gituseremail"

    if [[ "$(uname)" == "Darwin" ]]; then
        # make clang tools available to cli
        ln -s -f "$(brew --prefix llvm)/bin/clang-format" "/usr/local/bin/clang-format"
        ln -s -f "$(brew --prefix llvm)/bin/clang-tidy" "/usr/local/bin/clang-tidy"
    fi
}

pre_install_steps() {
    # echo "Answer the following before the automated installation starts."
    # echo "Enter golang toolchain tarball (.tar.gz) link (https://golang.org/dl): "
    # read -r golangURL

    if [[ "$(uname)" == "Linux" ]]; then
        if [[ ("$(lsb_release -si)" == "elementary") || ("$(lsb_release -si)" == "Ubuntu") ]]; then
            echo "Enter link to download shfmt (shellformat) util (https://github.com/mvdan/sh/releases):"
            read -r shfmtURL
        fi
    fi

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
        $SUDO apt install python3 python3-pip -y
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
        # $SUDO make -j2
        # $SUDO make install
        # cd ..
        # cd ~/dotfiles
        ;;
    esac

    # rust toolchain
    PATH="$PATH:/$(whoami)/.cargo/bin"
    export PATH
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
            cd /tmp || return
            echo "Downloading Go toolchain"
            curl -LO --progress-bar "$golangURL"
            echo "Installing Go toolchain"
            $SUDO tar -C /usr/local -xzf "${golangURL##*/}" # get name of tarball only
        )

        # Temporarily export go path in PATH
        export PATH="$PATH:/usr/local/go/bin"
    fi

    # tools on linux
    if [[ "$(uname)" == "Linux" ]]; then
        if [[ ("$(lsb_release -si)" == "elementary") || ("$(lsb_release -si)" == "Ubuntu") ]]; then
            echo "Installing Linux tools"
            lib/install build-essential
            # lib/install software-properties-common
            # lib/install clang
            # lib/install clang-tools-8
            # lib/install clang-tidy
            # lib/install clang-format
            # echo "Updating clangd alternatives"
            # $SUDO update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100
        fi

        # elementary OS steps
        if [[ "$(lsb_release -si)" == "elementary" ]]; then
            echo "Adding elementary-tweaks ppa"
            $SUDO add-apt-repository ppa:philip.scott/elementary-tweaks -y
            lib/install elementary-tweaks
        fi
    fi

    # C/C++ toolchain
    # echo "Installing C/C++ toolchain"
    # lib/install llvm
    # lib/install cmake
    # lib/install uncrustify

    # node/javascript/typescript toolchain
    # echo "Installing Node/JavaScript/TypeScript toolchain"
    # lib/install libssl1.0-dev
    # lib/install nodejs-dev
    # lib/install node-gyp
    # lib/install npm
    # $SUDO npm install -g typescript

    # generic utilities
    echo "Install cURL utility"
    lib/install curl
    echo "Install shellcheck"
    lib/install shellcheck
    echo "Install shellformat (shfmt)"
    if [[ "$(uname)" == "Darwin" ]]; then
        lib/install shfmt
    elif [[ "$(uname)" == "Linux" ]]; then
        if [[ ("$(lsb_release -si)" == "elementary") || ("$(lsb_release -si)" == "Ubuntu") ]]; then
            if [ -x "$(command -v shfmt)" ]; then
                echo "shfmt already installed"
            else
                (
                    cd /tmp || return
                    echo "Downloading shfmt utility"
                    curl -L --progress-bar -o shfmt "$shfmtURL"
                    chmod +x shfmt
                    echo "Installing shfmt"
                    $SUDO mv shfmt /usr/local/bin/
                )
            fi
        fi
    fi

    # install rust-based utilities
    # dependency for alacritty
    lib/install libfontconfig1-dev
    cargo install starship bat eza fd-find ripgrep tealdeer alacritty
    echo "Loading tldr cache"
    tldr --update
    ln -sf "$HOME/dotfiles/alacritty" "$HOME/.config/"

    #install fzf (fuzzy file finder)
    if [ -x "$(command -v fzf)" ]; then
        echo "fzf already installed"
    else
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install
    fi
}

docker_steps() {
    if [[ "$(uname)" == "Linux" ]]; then
        if [[ ("$(lsb_release -si)" == "elementary") || ("$(lsb_release -si)" == "Ubuntu") ]]; then
            if [ -x "$(command -v docker)" ]; then
                echo "docker already installed"
            else
                echo "Installing docker"
                $SUDO apt install \
                    apt-transport-https \
                    ca-certificates \
                    curl \
                    gnupg-agent \
                    software-properties-common -y
                curl -fsSL https://download.docker.com/linux/ubuntu/gpg | $SUDO apt-key add -
                $SUDO apt-key fingerprint 0EBFCD88
                $SUDO add-apt-repository \
                    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
                    $(lsb_release -csu) \
                    stable"
                $SUDO apt update -y
                $SUDO apt install docker-ce docker-ce-cli containerd.io -y
                $SUDO groupadd docker
                $SUDO usermod -aG docker "$USER"
                newgrp docker # restart system otherwise
            fi
        fi
    fi
}

############### steps to perform manually ###############
manual_steps() {
    step="
        To complete installation, follow below steps
        1. Change your font to $font for your terminal"
    if [[ "$(uname)" == "Darwin" ]]; then
        step=$step"
        3. After installing VSCode, run \"defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false\""
    fi

    echo "$step"
}
##################################################

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
# vim_steps
zsh_steps
tmux_steps
# docker_steps
install_fonts
post_install_steps
manual_steps
