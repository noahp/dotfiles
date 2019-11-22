[![awesome](https://img.shields.io/badge/awesome-yes-ff69b4.svg?style=for-the-badge)](https://github.com/twitter/twemoji)  [![useful](https://img.shields.io/badge/useful-nope-blue.svg?style=for-the-badge)](https://badssl.com/)  [![Travis (.com) branch](https://img.shields.io/travis/com/noahp/dotfiles/master.svg?style=for-the-badge)](https://travis-ci.com/noahp/dotfiles)

# Dotfiles

<!-- vim-markdown-toc GFM -->

- [Install dotfiles](#install-dotfiles)
- [Feature highlight](#feature-highlight)
- [Manual steps](#manual-steps)
  - [alacritty](#alacritty)
  - [direnv](#direnv)
    - [direnv git](#direnv-git)
    - [direnv virtualenvs](#direnv-virtualenvs)
  - [fd](#fd)
  - [fzf](#fzf)
  - [ripgrep](#ripgrep)
  - [python virtualenv](#python-virtualenv)
  - [vs code multi cursor](#vs-code-multi-cursor)
  - [ydiff](#ydiff)
- [Reference](#reference)
  - [cyrus-gdb](#cyrus-gdb)

<!-- vim-markdown-toc -->

## Install dotfiles
Run

```bash
# just set up symlinks
./install

# or to also install apt/zsh plugins/vscode extensions
DOTFILES_INSTALL_ALL=y ./install
```

That won't overwrite any existing dotfiles. You'll have to relocate any
collisions manually before running the install script if you want the ones in
this repo (see [`install.conf.yaml`](install.conf.yaml) for which links are
added).

## Feature highlight
This is mostly used for me to sync prompt configuration/plugins and
.gdbinit/vimrc between computers.

Rough list of features (might not be updated):
- oh-my-zsh (zsh plugin framework and lots of aliases)
- powerlevel10k (fast zsh prompt theme)
- cyrus gdb dashboard (featureful gdb dashboard)
- tmux config
- vimrc (I use it with neovim but might work with vim8 no idea)

Probably the most opinionated thing is the powerlevel10k config.. see
(`zsh/.p10k.zsh`)[zsh/.p10k.zsh] for customizing. That theme also has a
customization wizard, see https://github.com/romkatv/powerlevel10k . It also
updates a lot so this might break... definitely make an issue if it fails for
you!

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

## Reference
### cyrus-gdb
[Nice featureful gdb-dashboard](https://github.com/cyrus-and/gdb-dashboard).
Tracked as a submodule in this repo.

**Note!** if debugging shared libraries in gdb that haven't been loaded yet, be
sure to run `set confirm off` to allow setting breakpoints on symbols that
haven't yet loaded.
>https://github.com/cyrus-and/gdb-dashboard
