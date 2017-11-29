#!/bin/sh

# deploy dotfiles with stow
./stowsh/stowsh gdb -t ~
./stowsh/stowsh tmux -t ~
./stowsh/stowsh vim -t ~
./stowsh/stowsh zsh -t ~
./stowsh/stowsh urlview -t ~
./stowsh/stowsh vscode -t ~/.config/Code/User
