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

# fzf
https://github.com/junegunn/fzf#using-git

# nice gdb
https://github.com/cyrus-and/gdb-dashboard

# oh-myzsh
zsh first with `sudo apt install zsh`
https://github.com/robbyrussell/oh-my-zsh

# ripgrep
https://github.com/BurntSushi/ripgrep

# spaceship theme
Featurefull oh-my-zsh theme.
>https://github.com/denysdovhan/spaceship-zsh-theme

For async, these instructions:
```bash
# first get spaceship
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
# now switch to the async fork
cd "$ZSH_CUSTOM/themes/spaceship-prompt"
git remote add async git@github.com:maximbaz/spaceship-prompt.git
git fetch async
git checkout async/master

# next, install zsh-async
# get zplug first
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# reload the shell, run:
zplug install
```

# tpm
https://github.com/tmux-plugins/tpm

# urlview
```bash
sudo apt-get install urlview
https://github.com/insanum/dotfiles/blob/master/urlview
```

# virtualenv
```bash
sudo apt install python-virtualenv
```

# vs code multi cursor
`gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "<Super>"`

# ydiff
Somewhat nicer diffs, eg `diff -du <file1> <file2> | ydiff`
```bash
pip install ydiff
```

# zsh autosuggestions
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

___
___

# watchman
*Not using this anymore, but here's the instructions*

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
