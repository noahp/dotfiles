![awesome](https://img.shields.io/badge/awesome-yes-ff69b4.svg?style=for-the-badge)  ![useful](https://img.shields.io/badge/useful-nope-blue.svg?style=for-the-badge)

# Install
Run
```
./deploy.sh
```
That won't overwrite any existing dotfiles; you'll have to stash them manually before running it if you want to keep them.

*Warning this is NOT GREAT (but usable!), mostly just for reference, I need to clean up the deploy/undeploy to be cleaner!*
# alacritty
https://github.com/jwilm/alacritty
```bash
# install cargo
curl https://sh.rustup.rs -sSf | sh
# install alacritty
cargo install --git https://github.com/jwilm/alacritty
# apply in ubuntu
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'
```

# oh-myzsh
https://github.com/robbyrussell/oh-my-zsh

# spaceship theme
https://github.com/denysdovhan/spaceship-zsh-theme

# zsh autosuggestions
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

# nice gdb
https://github.com/cyrus-and/gdb-dashboard

# ripgrep
https://github.com/BurntSushi/ripgrep

# fzf
https://github.com/junegunn/fzf#using-git

# tpm
https://github.com/tmux-plugins/tpm

# vs code multi cursor
`gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "<Super>"`

# urlview
```bash
sudo apt-get install urlview
https://github.com/insanum/dotfiles/blob/master/urlview
```
