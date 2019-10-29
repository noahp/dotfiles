[![awesome](https://img.shields.io/badge/awesome-yes-ff69b4.svg?style=for-the-badge)](https://github.com/twitter/twemoji)  [![useful](https://img.shields.io/badge/useful-nope-blue.svg?style=for-the-badge)](https://badssl.com/)  [![Travis (.com) branch](https://img.shields.io/travis/com/noahp/dotfiles/master.svg?style=for-the-badge)](https://travis-ci.com/noahp/dotfiles)

# Dotfiles

<!-- vim-markdown-toc GFM -->

- [Install dotfiles](#install-dotfiles)
- [Manual steps](#manual-steps)
  - [alacritty](#alacritty)
  - [direnv](#direnv)
    - [direnv git](#direnv-git)
    - [direnv virtualenvs](#direnv-virtualenvs)
  - [fd](#fd)
  - [fzf](#fzf)
  - [oh-myzsh](#oh-myzsh)
  - [ripgrep](#ripgrep)
  - [python virtualenv](#python-virtualenv)
  - [vs code multi cursor](#vs-code-multi-cursor)
  - [ydiff](#ydiff)
  - [watchman](#watchman)
- [Reference](#reference)
  - [nice gdb](#nice-gdb)

<!-- vim-markdown-toc -->

## Install dotfiles
Run

```bash
# just set up symlinks
./install

# or to also install apt/zsh plugins/vscode extensions
DOTFILES_INSTALL_ALL=y ./install
```

That won't overwrite any existing dotfiles; you'll have to stash them manually
before running it if you want to keep them. Also run as `./install`

## Manual steps
*Note- at the moment deploying this config requires a few manual steps.
TODO #2 to make this more automatic.*

### alacritty
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

### direnv
Set your environment when entering a directory, by placing a `.envrc` file into
that directory.
>https://github.com/direnv/direnv#setup

#### direnv git
I find it useful for controlling the git author name + email for a set of
projects, vs. setting each one individually, or setting a global one.

I have this structure:
```bash
~/dev
├── github  # github projects
│   └── .envrc
└── work  # work projects
    └── .envrc
```

And the contents of the `.envrc` files:
```bash
➜ cat ~/dev/github/.envrc
export GIT_AUTHOR_NAME="Noah Pendleton"
export GIT_AUTHOR_EMAIL=noahp@users.noreply.github.com
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"

➜ cat ~/dev/work/.envrc
export GIT_AUTHOR_NAME="Noah Pendleton"
export GIT_AUTHOR_EMAIL=npendleton@work.com
export GIT_COMMITTER_NAME="$GIT_AUTHOR_NAME"
export GIT_COMMITTER_EMAIL="$GIT_AUTHOR_EMAIL"
```

Related, for selecting the correct ssh keys for a host, set up `~/.ssh/config`:
```bash
# use a non-default ssh key pair for github (id_rsa.github + id_rsa.github.pub)
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_rsa.github
  IdentitiesOnly yes
```

#### direnv virtualenvs
`direnv` can also be used to select a python virtualenv based on directory
location, which can be useful if you have projects that benefit from a little
isolation, or require different python interpreters; it can save some
typing/confusion to have dedicated virtualenvs.

I put my virtualenvs in a folder `~/.virtualenvs`, so this wrapper is useful:
> https://github.com/direnv/direnv/wiki/Python#virtualenvwrapper

In the individual `.envrc` files, to enter a virtualenv:
```bash
# select ~/.virtualenvs/python3
layout virtualenvwrapper python3
```

### fd
Fast find replacement that honors .gitignore and hidden files by default. Way
more user-friendly.
> https://github.com/sharkdp/fd

```bash
cargo install fd-find
```

### fzf
Neat fuzzy searcher for terminal history and path searching.
>https://github.com/junegunn/fzf#using-git

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### oh-myzsh
Fancy schmancy zsh customization and theme management framework.
>https://github.com/robbyrussell/oh-my-zsh

This is installed as part of `./install` if the appropriate variable is set, see
[`install-extras.sh`](install-extras.sh).

That will also set up the [powerlevel10k](https://github.com/romkatv/powerlevel10k) theme, which is a nice fast theme for
zsh.


### ripgrep
Vastly faster grep replacement written in rust.
>https://github.com/BurntSushi/ripgrep
```bash
cargo install ripgrep
```

### python virtualenv
Somewhat tidier python environment management to avoid polluting system python
with all those rando pypi packages you love so much.
```bash
sudo apt install python-pip

# this adds the virtualenv command to ~/.local/bin . using pip will get the
# normal virtualenv utility, not the weird debian patched one
pip install --user virtualenv

# set up default env for our ~/.zshrc to activate on new shells
virtualenv --clear ~/.virtualenvs/default
```

### vs code multi cursor
`gsettings set org.gnome.desktop.wm.preferences mouse-button-modifier "<Super>"`

### ydiff
Somewhat nicer diffs, eg `diff -du <file1> <file2> | ydiff`
```bash
pip install ydiff
```
___
___

### watchman
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

## Reference
### nice gdb
Nice featureful gdb-dashboard. Tracked as a submodule in this repo.

**Note!** if debugging shared libraries in gdb that haven't been loaded yet, be sure
to run `set confirm off` to allow setting breakpoints on symbols that haven't
yet loaded.
>https://github.com/cyrus-and/gdb-dashboard
