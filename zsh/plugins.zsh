_zsh_plugin_usage() {
  echo "Usage:"
  echo "zsh_plugin <command> <plugin>"
  echo "Parameters:"
  echo "command: install, remove, _source"
  echo "plugin: e.g., lukechilds/zsh-nvm"
  echo ""
  echo "Examples:"
  echo "zsh_plugin install lukechilds/zsh-nvm"
  echo "zsh_plugin remove lukechilds/zsh-nvm"
}

zsh_plugin() {
  if [[ $# -gt 2 ]]; then
    _zsh_plugin_usage
  fi

  local cmd="$1"
  local plugin="$2"

  case "$cmd" in
    "install")
      _install_zsh_plugin $plugin
      ;;
    "remove")
      _remove_zsh_plugin $plugin
      ;;
    "_source")
      _source_zsh_plugin $plugin
      ;;
    *) echo default
      echo "Invalid arguments"
      _zsh_plugin_usage
      ;;
  esac
}

INSTALL_DIR="$DOTFILES/zsh/plugins"

_install_zsh_plugin() {
  local plugin_dir="$INSTALL_DIR/$1"
  if [ ! -d "$plugin_dir/.git" ]; then
    git clone "https://github.com/$1.git" "$plugin_dir"
  fi
  _source_zsh_plugin "$1"
}

_source_zsh_plugin() {
  local plugin_dir="$INSTALL_DIR/$1"
  for file in $plugin_dir/*.plugin.zsh; do
    [ -f "$file" ] && source "$file"
  done
}

_remove_zsh_plugin() {
  local plugin_dir="$INSTALL_DIR/$1"
  if [ -d "$plugin_dir/.git" ]; then
    rm -rf "$plugin_dir"
    echo "removed $1 plugin"
  fi
}

zsh_plugin install zsh-users/zsh-autosuggestions
zsh_plugin install zsh-users/zsh-syntax-highlighting
zsh_plugin install MichaelAquilina/zsh-you-should-use
zsh_plugin install lukechilds/zsh-nvm
export NVM_LAZY_LOAD=true # lazy loads the zsh-nvm plugin, this speeds up shell startup
export NVM_LAZY_LOAD_EXTRA_COMMANDS=('nvim' 'nvim*') # trigger zsh-nvm lazy loading for nvim

zsh_plugin _source ohmyzsh/git
if [ ! -x "$(command -v node)" ]; then
  nvm install --lts
fi
