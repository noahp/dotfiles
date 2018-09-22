[![awesome](https://img.shields.io/badge/awesome-yes-ff69b4.svg?style=for-the-badge)](https://github.com/twitter/twemoji)  [![useful](https://img.shields.io/badge/useful-nope-blue.svg?style=for-the-badge)](https://badssl.com/)  [![Travis (.com) branch](https://img.shields.io/travis/com/noahp/dotfiles/master.svg?style=for-the-badge)](https://travis-ci.com/noahp/dotfiles)

# Install
Run
```bash
./install
```
That won't overwrite any existing dotfiles; you'll have to stash them manually before running it if you want to keep them.
Also run as `./install`

*Note- the below instructions are incomplete + partially incorrect... #4 will fix this up to be more readable! Apologies in the meantime.*

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
git config --global diff.colorMoved dimmed_zebra  # requires 2.15+. do the right thing.
```

# diff-so-fancy
Debatably nicer diff output for git diff.
Installation and config instructions:
https://github.com/so-fancy/diff-so-fancy#usage

# watchman
https://raw.githubusercontent.com/git/git/master/templates/hooks--fsmonitor-watchman.sample
```bash
git clone https://github.com/facebook/watchman.git
cd watchman
git checkout v4.9.0
./autogen.sh && ./configure && make && sudo make install
# because you know it's right
echo 999999 | sudo tee -a /proc/sys/fs/inotify/max_user_watches  && echo 999999 | sudo tee -a  /proc/sys/fs/inotify/max_queued_events && echo 999999 | sudo tee  -a /proc/sys/fs/inotify/max_user_instances

# install the hook to whatever repo
wget https://raw.githubusercontent.com/git/git/master/templates/hooks--fsmonitor-watchman.sample -O .git/hooks/query-watchman && chmod +x .git/hooks/query-watchman
git config core.fsmonitor .git/hooks/query-watchman
```
