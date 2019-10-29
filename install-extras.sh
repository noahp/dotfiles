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
    command_exists nvim || (sudo apt install -y neovim && nvim +PlugUpdate +qall)
    command_exists urlview || sudo apt install -y urlview
    command_exists tmux || sudo apt install -y tmux
    command_exists zsh || sudo apt install -y zsh
fi

# conditionally fetch a git plugin
# $1 - path
# $2 - repo url
function conditional_git_install() {
    if [ ! -d "$1" ]; then
        git clone "$2" "$1"
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

    # oh-my-zsh plugins; hard-coded to $ZSH install location
    conditional_git_install "$ZSH/plugins/zsh-z" https://github.com/agkozak/zsh-z
    conditional_git_install "$ZSH/themes/powerlevel10k" https://github.com/romkatv/powerlevel10k.git
    conditional_git_install "$ZSH/custom/plugins/zsh-autosuggestions" https://github.com/zsh-users/zsh-autosuggestions

    # tmux plugin manager
    conditional_git_install ~/.tmux/plugins/tpm https://github.com/tmux-plugins/tpm
fi

if [ "$DOTFILES_INSTALL_VSCODE_EXTS" == "y" ]; then
    # VSCode extension sync
    # currently this list is manually updated by running:
    # code --list-extensions > ./vscode/extensions.list
    xargs -t -L 1 bash -c "code --install-extension || exit 255" < vscode/extensions.list
fi

if [ "$DOTFILES_INSTALL_RUSTY_STUFF" == "y" ]; then
    echo "DOTFILES_INSTALL_RUSTY_STUFF disabled for now"
    # TODO below command doesn't work as-is?
    # command_exists cargo || bash <(curl https://sh.rustup.rs -sSf) -y

    # TODO disable rust utils install... takes forever!
    # command_exists alacritty || (sudo apt install -y cmake libfreetype6-dev libfontconfig1-dev xclip && cargo install --git https://github.com/jwilm/alacritty)
    # command_exists rg || cargo install --git https://github.com/BurntSushi/ripgrep
    # command_exists fd || cargo install --git https://github.com/sharkdp/fd
    # command_exists bat || cargo install --git https://github.com/sharkdp/bat
fi
