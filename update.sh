# Update settings by downloading from git
git pull
git submodule update --init --recursive
vim +PlugClean +PlugUpdate

