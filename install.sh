#!/bin/bash

# Installation script for all configuration files
# Author: Raashid Ansari
# Date: Feb 6, 2018
# Update: Mar 11, 2020

SUDO=
if [ "$(whoami)" != root ]; then
  SUDO="sudo"
else
  read -n 1 -p "Do you really want to run as root? (y/[n]): " really_root
  if [[ "$really_root" != y ]]; then
    exit 0
  fi
fi
export SUDO

font="RobotoMono"
font_path="https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/RobotoMono/Regular/RobotoMonoNerdFont-Regular.ttf"
font_recursive_cmd="curl -fsSL 'https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Recursive.tar.xz' | tar x 'RecMonoCasualNerdFont-Regular.ttf'"

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
#         lib/install vim-gnome vim-gtk3
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
  echo "Installing zsh"
  lib/install zsh

  echo "Cleaning up previous zsh config files"
  [ -f ~/.zprofile ] && rm ~/.zprofile
  [ -f ~/.zshrc ] && rm ~/.zshrc

  create_file_link zsh .zprofile
  create_file_link zsh .zshrc

  echo "Setup zsh as default shell"
  chsh -s "$(command -v zsh)"
}
##################################################

############## tmux specific steps ###############
tmux_steps() {
  # TODO:Install tmux dependencies
  # libevent-dev libncurses-dev yacc
  # TODO: Use the following link to install latest
  # https://github.com/tmux/tmux/releases
  # TODO: make this installable cross-platform
  echo "Installing tmux"
  lib/install tmux

  # Create symlinks for tmux
  create_file_link tmux tmux.conf .tmux.conf

  echo "Installing tmux clipboard support and creating links to local tmux configs"
  case "$(uname)" in
  Darwin)
    lib/install reattach-to-user-namespace
    ;;
  Linux)
    lib/install xsel
    ;;
  esac

  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
  tmux source ~/.tmux.conf
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
    (
      cd "$HOME/.local/share/fonts"
      eval "$font_recursive_cmd"
    )
    ;;
  Darwin)
    curl -fLo "/Users/$(whoami)/Library/Fonts/$font_name" "$font_path"
    (
      cd "/Users/$(whoami)/Library/Fonts"
      eval "$font_recursive_cmd"
    )
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
  echo "Answer the following before the automated installation starts."

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

  # tools on linux
  if [[ "$(uname)" == "Linux" ]]; then
    if [[ ("$(lsb_release -si)" == "elementary") || ("$(lsb_release -si)" == "Ubuntu") || ("$(lsb_release -si)" == "Debian") ]]; then
      echo "Installing Linux tools"
      lib/install build-essential # software-properties-common clang clang-tools-8 clang-tidy clang-format
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
  # lib/install llvm cmake uncrustify

  # node/javascript/typescript toolchain
  # echo "Installing Node/JavaScript/TypeScript toolchain"
  # lib/install libssl1.0-dev nodejs-dev node-gyp npm
  # $SUDO npm install -g typescript

  # generic utilities
  lib/install curl shellcheck direnv
}

fzf_steps() {
  #install fzf (fuzzy file finder)
  if [ -x "$(command -v fzf)" ]; then
    echo "fzf already installed"
  else
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
  fi
}

shfmt_steps() {
  echo "Install shellformat (shfmt)"
  case "$(uname)" in
  Darwin)
    lib/install shfmt
    ;;
  Linux)
    case $(lsb_release -si) in
    Ubuntu | elementary | Debian)
      echo "Enter link to download shfmt (shellformat) util (https://github.com/mvdan/sh/releases):"
      read -r shfmtURL
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
      ;;
    *)
      echo "This linux distro is not supported yet."
      ;;
    esac
    ;;
  *)
    echo "Your OS is not supported yet."
    ;;
  esac
}

golang_steps() {
  echo "Enter golang toolchain tarball (.tar.gz) link (https://golang.org/dl): "
  read -r golangURL

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
}

rust_steps() {
  # rust toolchain
  PATH="$PATH:/$(whoami)/.cargo/bin"
  export PATH
  if [ -x "$(command -v rustc)" ]; then
    echo "Rust toolchain already installed"
  else
    echo "Installing Rust toolchain"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  fi
}

rust_tools_steps() {
  if [ ! -x "$(command -v rustc)" ]; then
    echo "Rust toolchain is not installed, hence Rust-based tools cannot be installed"
    return
  fi

  # install rust-based utilities
  cargo install starship bat eza fd-find ripgrep tealdeer zoxide git-delta --locked
  echo "Loading tldr cache"
  tldr --update
  ln -sf "$HOME/dotfiles/starship/starship.toml" "$HOME/.config/"
}

lazygit_steps() {
  echo "Enter lazygit tarball (.tar.gz) link (https://github.com/jesseduffield/lazygit/releases): "
  read -r lazygitURL

  if [ -x "$(command -v lazygit)" ]; then
    echo "lazygit already installed"
  else
    (
      cd /tmp || return
      echo "Downloading lazygit"
      curl -LO --progress-bar "$lazygitURL"
      echo "Installing lazygit"
      [ ! -d "/usr/local/bin" ] && $SUDO mkdir -p "/usr/local/bin"
      $SUDO tar -C /usr/local/bin -xzf "${lazygitURL##*/}" # get name of tarball only
    )
  fi

  ln -sf "$HOME/dotfiles/lazygit" "$HOME/.config/"
}

docker_steps() {
  if [[ "$(uname)" == "Linux" ]]; then
    if [ -x "$(command -v docker)" ]; then
      echo "docker already installed"
    else
      echo "Install docker using instructions at https://docs.docker.com/engine/install/"
    fi
  fi
}

############### neovim specific steps ###############
neovim_steps() {
  echo "Installing Neovim"

  if [ -x "$(command -v nvim)" ]; then
    echo "Neovim already installed"
  else
    case "$(uname)" in
    Darwin)
      # Install via Homebrew on macOS
      lib/install neovim
      ;;
    Linux)
      # Check distribution and install accordingly
      case "$(lsb_release -si)" in
      Ubuntu | elementary | Debian)
        # Download and install latest Neovim from GitHub releases
        echo "Downloading latest Neovim for $(lsb_release -si)"
        (
          cd /tmp || return
          curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
          $SUDO rm -rf /opt/nvim
          $SUDO tar -C /opt -xzf nvim-linux-x86_64.tar.gz
          $SUDO ln -sf /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
        )
        # Install latest Python support via pip
        $SUDO apt update
        $SUDO apt install python3-pip -y
        pip3 install --user pynvim
        ;;
      *)
        echo "Unsupported Linux distribution for Neovim installation"
        echo "Please install Neovim manually for your distribution"
        ;;
      esac
      ;;
    *)
      echo "Unsupported OS for automated Neovim installation"
      echo "Please install Neovim manually for your platform"
      ;;
    esac
  fi

  # Create neovim config symlink
  echo "Creating Neovim config symlink"
  mkdir -p "$HOME/.config"
  ln -sf "$HOME/dotfiles/nvim" "$HOME/.config/"
}
##################################################

wezterm_steps() {
  echo "Installing WezTerm"

  if [ -x "$(command -v wezterm)" ]; then
    echo "WezTerm already installed"
  else
    case "$(uname)" in
    Darwin)
      brew install --cask wezterm
      ;;
    Linux)
      # Check distribution and install accordingly
      case "$(lsb_release -si)" in
      Ubuntu | elementary | Debian)
        echo "Downloading latest WezTerm for $(lsb_release -si)"
        curl -fsSL https://apt.fury.io/wez/gpg.key | $SUDO gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
        echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | $SUDO tee /etc/apt/sources.list.d/wezterm.list
        $SUDO chmod 644 /usr/share/keyrings/wezterm-fury.gpg
        $SUDO apt update
        $SUDO apt install wezterm
        ;;
      *)
        echo "Unsupported Linux distribution for WezTerm installation"
        echo "Please install WezTerm manually for your distribution"
        ;;
      esac
      ;;
    *)
      echo "Unsupported OS for automated WezTerm installation"
      echo "Please install WezTerm manually for your platform"
      ;;
    esac
  fi

  # Create wezterm config symlink
  echo "Creating WezTerm config symlink"
  mkdir -p "$HOME/.config"
  ln -sf "$HOME/dotfiles/wezterm" "$HOME/.config/"
}
##################################################

############### opencode specific steps ###############
opencode_steps() {
  echo "Installing opencode"

  if [ -x "$(command -v opencode)" ]; then
    echo "opencode already installed"
  else
    echo "Installing opencode via universal install script"
    curl -fsSL https://opencode.ai/install | bash
  fi

  # Create opencode config symlink
  echo "Creating opencode config symlink"
  mkdir -p "$HOME/.config"
  ln -sf "$HOME/dotfiles/opencode" "$HOME/.config/"
}
##################################################

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
  Ubuntu | elementary | Debian)
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
fzf_steps
shfmt_steps
golang_steps
rust_steps
rust_tools_steps
lazygit_steps
git_steps
# vim_steps
neovim_steps
wezterm_steps
zsh_steps
tmux_steps
opencode_steps
# docker_steps
install_fonts
post_install_steps
manual_steps
