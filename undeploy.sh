#!/bin/sh

# undeploy dotfiles with stow
./stowsh/stowsh -D gdb -t ~
./stowsh/stowsh -D tmux -t ~
./stowsh/stowsh -D vim -t ~
./stowsh/stowsh -D zsh -t ~

