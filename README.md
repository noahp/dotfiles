*warning this is NOT GREAT, just for reference, until I clean it up and stow!*
# alacritty
https://github.com/jwilm/alacritty#manual-installation
`sudo cp ~/alacritty/target/alacritty /usr/bin`
`gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'`

# oh-myzsh
https://github.com/robbyrussell/oh-my-zsh

# spaceship theme
https://github.com/denysdovhan/spaceship-zsh-theme

# nice gdb
https://github.com/cyrus-and/gdb-dashboard

# ripgrep
https://github.com/BurntSushi/ripgrep

# fzf
https://github.com/junegunn/fzf#using-git

# tpm
https://github.com/tmux-plugins/tpm

# tmux-yank
https://github.com/tmux-plugins/tmux-yank

# vs code multi cursor
`gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "<Super>"`

# urlview
```
sudo apt-get install urlview
https://github.com/insanum/dotfiles/blob/master/urlview

# add to ~/.urlview
REGEXP (((http|https|ftp|file|gopher)|mailto)[.:]//[^ >"\t]*|www\.[-a-z0-9.]+)[^ .,;\t>">\):]
COMMAND google-chrome %s
```
