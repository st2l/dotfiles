#!/bin/bash

stow data
stow nvim zsh tmux
stow kitty presenterm
stow pwninit

cd ~
git clone https://github.com/romkatv/powerlevel10k.git
