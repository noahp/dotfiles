[![awesome](https://img.shields.io/badge/awesome-yes-ff69b4.svg?style=for-the-badge)](https://github.com/twitter/twemoji)  [![useful](https://img.shields.io/badge/useful-nope-blue.svg?style=for-the-badge)](https://badssl.com/)  [![Travis (.com) branch](https://img.shields.io/travis/com/noahp/dotfiles/master.svg?style=for-the-badge)](https://travis-ci.com/noahp/dotfiles)

# Install dotfiles
Run

```bash
./install
```

That won't overwrite any existing dotfiles; you'll have to stash them manually before running it if you want to keep them.
Also run as `./install`

# Manual steps
*Note- at the moment deploying this config requires a few manual steps.
TODO #5 to make this automatic.*

## alacritty
Fast gpu-accelerated terminal emulator written in rust.

>https://github.com/jwilm/alacritty
```bash
# install cargo
curl https://sh.rustup.rs -sSf | sh
# install dependencies
sudo apt install cmake libfreetype6-dev libfontconfig1-dev xclip
# install alacritty
cargo install --git https://github.com/jwilm/alacritty
# apply in ubuntu
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

# to also start tmux when starting alacritty:
gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty -e tmux'
```

## fd
Fast find replacement that honors .gitignore and hidden files by default. Way
more user-friendly.
> https://github.com/sharkdp/fd

```bash
cargo install fd-find
```

## fzf
Neat fuzzy searcher for terminal history and path searching.
>https://github.com/junegunn/fzf#using-git

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## oh-myzsh
Fancy schmancy zsh customization and theme management framework.
>https://github.com/robbyrussell/oh-my-zsh

```bash
# install zsh first
sudo apt install zsh
# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

## ripgrep
Vastly faster grep replacement written in rust.
>https://github.com/BurntSushi/ripgrep
```bash
cargo install ripgrep
```

## spaceship theme
Featurefull oh-my-zsh theme, install oh-my-zsh first!
>https://github.com/denysdovhan/spaceship-zsh-theme

For async (speeds up git-status by loading it after populating the prompt),
follow these instructions:
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

## tpm
tmux plugin manager (used in the .tmux.conf in this repo)
>https://github.com/tmux-plugins/tpm

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## urlview
Quickly open urls in tmux with /prefix/-u

```bash
sudo apt-get install urlview
https://github.com/insanum/dotfiles/blob/master/urlview
```

## python virtualenv
Somewhat tidier python environment management to avoid polluting system python
with all those rando pypi packages you love so much.
```bash
sudo apt install python-virtualenv
# set up default env for our ~/.zshrc to activate on new shells
virtualenv --clear ~/.virtualenvs/default
```

## vs code multi cursor
`gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "<Super>"`

## ydiff
Somewhat nicer diffs, eg `diff -du <file1> <file2> | ydiff`
```bash
pip install ydiff
```

## zsh-autosuggestions
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
```

## zsh-syntax-highlighting
https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md#oh-my-zsh

```bash
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

___
___

## watchman
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

# Reference
## nice gdb
Nice featureful gdb-dashboard. Already checked in to this repo in the `.gdbinit`
file.

**Note!** if debugging shared libraries in gdb that haven't been loaded yet, be sure
to run `set confirm off` to allow setting breakpoints on symbols that haven't
yet loaded.
>https://github.com/cyrus-and/gdb-dashboard
