#!/usr/bin/env bash
# ^ this only works on ubuntu/debian anyway, so assume bash is available
#
# Options:
# DOTFILE_INSTALL_ALL=y - enable all installation steps. you can still blacklist
#   other steps by setting them to any non-"y" value (eg =n)

set -e

if [ "$VERBOSE" == "1" ]; then
    set -x
fi

# Description of settings below
if [ "$DOTFILES_INSTALL_ALL" == "y" ]; then
    # install extra utilities if uninstalled
    DOTFILES_INSTALL_EXTRA=${DOTFILES_INSTALL_EXTRA:-y}

    # install zsh plugins if uninstall
    DOTFILES_INSTALL_ZSH_PLUGINS=${DOTFILES_INSTALL_ZSH_PLUGINS:-y}

    #install rust and rust based utilities. not available right now.
    DOTFILES_INSTALL_RUSTY_STUFF=${DOTFILES_INSTALL_RUSTY_STUFF:-y}

    #install VSCode extensions
    DOTFILES_INSTALL_VSCODE_EXTS=${DOTFILES_INSTALL_VSCODE_EXTS:-y}
fi

function command_exists() {
    command -v "$@" >/dev/null 2>&1
}

if [ "$DOTFILES_INSTALL_EXTRA" == "y" ]; then
    # only supports os's that use apt, todo #8 !
    # assume a 'sudo apt update' has been run

    # install sudo if it isn't, so on systems with sudo, below commands will
    # work
    command_exists sudo || apt install sudo -y

    command_exists curl || sudo apt install -y curl

    # install latest neovim
    export APPIMAGE_EXTRACT_AND_RUN=1  # since we're in docker, set this
    command_exists nvim || \
        (\
         curl -sL https://github.com/neovim/neovim/releases/latest/download/nvim.appimage > ~/.local/bin/nvim \
         && chmod +x ~/.local/bin/nvim
        )
    export PATH="$HOME/.local/bin:$PATH"
    ln -sf ~/.local/bin/nvim ~/.local/bin/neovim

    command_exists urlview || (sudo apt update && sudo apt install -y urlview)
    command_exists tmux || (sudo apt update && sudo apt install -y tmux)
    command_exists zsh || (sudo apt update && sudo apt install -y zsh)
    command_exists kitty || (curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin)
fi

# conditionally fetch a git plugin
# $1 - path
# $2 - repo url
# [$3] - optionally, branch/ref to checkout after cloning
function conditional_git_install() {
    if [ ! -d "$1" ]; then
        git clone "$2" "$1"
    else
        git -C "$1" fetch
    fi

    if [ $# -eq 3 ]; then
        git -C "$1" checkout "$3"
    fi
}

if [ "$DOTFILES_INSTALL_ZSH_PLUGINS" == "y" ]; then
    # install oh-my-zsh if it's missing. see here for details
    # https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh
    # don't use the normal setup script (it overwrites ~/.zshrc), instead just clone.
    ZSH=${ZSH:-~/.oh-my-zsh}
    if [ ! -d "$ZSH" ]; then
        git clone -c core.eol=lf -c core.autocrlf=false \
            -c fsck.zeroPaddedFilemode=ignore \
            -c fetch.fsck.zeroPaddedFilemode=ignore \
            -c receive.fsck.zeroPaddedFilemode=ignore \
            --depth=1 --branch master https://github.com/robbyrussell/oh-my-zsh.git "$ZSH"
    fi

    # tmux plugin manager
    conditional_git_install \
        ~/.tmux/plugins/tpm \
        https://github.com/tmux-plugins/tpm \
        26d9ace1b47f4591b2afdf333442a498311b6ace
fi

if [ "$DOTFILES_INSTALL_VSCODE_EXTS" == "y" ]; then
    # VSCode extension sync
    # currently this list is manually updated by running:
    # code --list-extensions > ./vscode/extensions.list
    if command_exists code ; then
        xargs -t -L 1 -I % bash -c "code --install-extension % || exit 255" < vscode/extensions.list
    fi
fi

if [ "$DOTFILES_INSTALL_RUSTY_STUFF" == "y" ]; then
    # assumes cargo is installed and on path
    command_exists sccache || cargo install sccache
    command_exists rg || cargo install ripgrep
    command_exists fd || cargo install fd-find
    command_exists dua || cargo install dua-cli
fi
