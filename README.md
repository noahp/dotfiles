![awesome](https://img.shields.io/badge/awesome-yes-ff69b4.svg?style=for-the-badge)  ![useful](https://img.shields.io/badge/useful-nope-blue.svg?style=for-the-badge)

# Install
Run
```
./deploy.sh
```
That won't overwrite any existing dotfiles; you'll have to stash them manually before running it if you want to keep them.

*Warning this is NOT GREAT (but usable!), mostly just for reference, I need to clean up the deploy/undeploy to actually [be usable](https://github.com/ansible/ansible)*
# alacritty
https://github.com/jwilm/alacritty
```bash
# install cargo
curl https://sh.rustup.rs -sSf | sh
# install dependencies
sudo apt install cmake libfreetype6-dev libfontconfig1-dev xclip
# install alacritty
cargo install --git https://github.com/jwilm/alacritty
# apply in ubuntu
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'
```

# virtualenv
```bash
sudo apt install python-virtualenv
```

# oh-myzsh
zsh first with `sudo apt install zsh`
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

# gitconfig
Not yet checked in. So:
```bash
git config --global core.editor vim
git config --global merge.tool meld  # sudo apt install meld
git config --global diff.tool meld
git config --global diff.colorMoved default  # requires 2.15+. do the right thing.
```

