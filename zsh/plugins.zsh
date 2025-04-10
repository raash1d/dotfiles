if [ ! -d $HOME/.zsh/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ ! -d $HOME/.zsh/fast-syntax-highlighting ]; then
  git clone https://github.com/zdharma-continuum/fast-syntax-highlighting ~/.zsh/fast-syntax-highlighting
fi
source ~/.zsh/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh

# if [ ! -d $HOME/.zsh/zsh-nvm ]; then
#   git clone https://github.com/lukechilds/zsh-nvm.git ~/.zsh/zsh-nvm
# fi
# source ~/.zsh/zsh-nvm/zsh-nvm.plugin.zsh
