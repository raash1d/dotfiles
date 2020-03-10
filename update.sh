#! /bin/bash

# Update settings by downloading from git
git pull --recurse-submodules
vim +PlugClean +PlugUpdate +qa

