#!/usr/bin/env zsh
# Above hashbang set for shellcheck. This file should be sourced.

# Zsh profiler
if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block, everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# Some user-specific settings selected before loading the config

# Perform git branch name substitution
P10K_BRANCH_SUBST_STRING=npendleton
P10K_BRANCH_SUBST_REPLACE=👴

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Some extra completion settings. Disabled for now until I test for performance
# impact

# this group from https://github.com/ehynds/dotfiles/blob/master/.zshrc
# zstyle ':completion:*' accept-exact '*(N)'
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path ~/.zsh/cache

# next group from https://unix.stackexchange.com/a/214699
# # Do menu-driven completion.
# zstyle ':completion:*' menu select

# # Color completion for some things.
# # http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# # formatting and messages
# # http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
# zstyle ':completion:*' verbose yes
# zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
# zstyle ':completion:*:messages' format '%d'
# zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
# zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
# zstyle ':completion:*' group-name ''

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Disable checking for insecure completions, to speed up shell load
ZSH_DISABLE_COMPFIX=true

# Load completions
fpath+=~/.zfunc

# Antigen managed plugins
# see https://github.com/zsh-users/antigen/wiki/Commands
source ~/antigen.zsh

antigen use oh-my-zsh

# oh-my-zsh included bundles
antigen bundle rust
antigen bundle colored-man-pages
antigen bundle common-aliases
antigen bundle git
antigen bundle wd

# bundles outside of oh-my-zsh
# antigen only supports specifying tag or branch, not sha. so hope this doesn't
# break >_<
# shas listed just in case i need to manually touch it up
antigen bundle agkozak/zsh-z #99f6ee91187ad6469b2cc3858f5a60c68286a1a5
antigen bundle zsh-users/zsh-autosuggestions #d43c309f888153d6c46d8b6a3a0186f4148680fd
antigen theme romkatv/powerlevel10k #1777bd41a68c99963e009c55a0f500396e485d07

antigen apply

# Autoload Zsh functions. Just enabling zcalc for now, the others may cause
# overreliance on zsh!
# autoload -Uz age
# autoload -Uz zargs
autoload -Uz zcalc
# autoload -Uz zmv

# History configuration
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS          # Do not record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
# setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Do not record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Git aliases
alias gsc='git clean -dxf && git submodule foreach --recursive "git clean -dxf"'
alias gscf='git clean -dxff && git submodule foreach --recursive "git clean -dxff"'
alias gcln='git clean -dxf'
alias gsu='git submodule update --jobs 6 --init --recursive'
alias gsd='git submodule deinit -f .'
alias git-nuke='rm -rf * && git reset --hard HEAD && gsu'
alias gaf='git commit -a --amend --no-edit'
alias glp='git log --pretty=format:"%C(yellow)%h %Cblue%>(12)%ai %Cgreen%<(7)%aN %Cred%D %Creset%s"'
alias dec2hex='printf "%x\n"'
alias hex2dec='printf "%u\n"'
alias gddir='git difftool --dir-diff'
alias gdm='git diff $(git merge-base HEAD origin/master)'
alias gdd='git diff $(git merge-base HEAD origin/develop)'
alias gddm='git difftool --dir-diff $(git merge-base HEAD origin/master)'
alias gddd='git difftool --dir-diff $(git merge-base HEAD origin/develop)'
alias gst='git status -sb'
alias gac='git add -A && git commit -v'
alias gt='git tree' # https://github.com/knugie/git-status-tree#install
alias gdd='git diff @{u}'
alias gddo='git difftool --dir-diff @{u}'
alias gro='git reset @{u}'
alias gnp='git --no-pager'
# 'git reset date'... set date of top commit to current date. use a single variable
# in a subshell to avoid committer/author date not exactly matching
alias grd='(GIT_AUTHOR_DATE="$(date -R)"; GIT_COMMITTER_DATE="$GIT_AUTHOR_DATE"; git commit --amend --date "$GIT_COMMITTER_DATE" --no-edit)'
alias gbn='git rev-parse --abbrev-ref HEAD'
alias gsha='git rev-parse HEAD'
alias gct='git checkout trunk'
alias gcmn='git checkout main'

# Other aliases

# tar args are too hard to remember, cheat
alias targz="tar -czvf"
# requires pigz, but man is it faster
alias tarpigz="tar -I pigz -cvf"

# always use system clipboard with xclip yolo
alias xclip="xclip -selection c"

# print ansi 256 colors
alias show-colors='for i in {0..255}; do printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i ; if ! (( ($i + 1 ) % 8 )); then echo ; fi ; done'

# emoji picker, uses https://github.com/noahp/emoji-fzf
alias emoj="emoji-fzf preview | fzf --preview 'emoji-fzf get --name {1}' | cut -d \" \" -f 1 | emoji-fzf get | xclip"

# no safe cp for me
unalias rm cp mv

# pipe data to gnuplot
alias gplot='gnuplot -e "set terminal dumb; plot '"'"'-'"'"' notitle"'
alias gplotp='gnuplot -e "plot '"'"'-'"'"' notitle" -persist'

# Custom functions

# Profile zsh startup
function profzsh() {
  shell=${1-$SHELL}
  ZPROF=true $shell -i -c exit
}

# git plot lines-of-code
function git-plot-loc()	{
    # plot the lines of code in a file per commit
    git log --reverse --oneline -- $1 | cut -d " " -f 1 | xargs -I {} sh -c "git show {}:$1 | wc -l" | gplot
}

# git chery-pit (remove commit)
function git-cherry-pit() {
    # remove a commit forever, goodbye (well ok it's still in the reflog if you have regrets)
    git rebase -p --onto $1^ $1
}

# reset timestamps of commits
function git-rebase-time() {
    local datenow="$(date -R)";
    git rebase -x "GIT_AUTHOR_DATE=\"$datenow\" GIT_COMMITTER_DATE=\"$datenow\" \
      git commit --amend --reset-author --no-edit -CHEAD" "$@"
}

# fuzzy search git log
function git-select() {
 git log --oneline "$@" | fzf --preview 'git show $(echo {} | cut -d " " -f 1)' | cut -d " " -f 1
}

# git-size-packed
# from https://stackoverflow.com/a/42544963
function git-size-packed() {
  git rev-list --objects --all \
| git cat-file --batch-check='%(objecttype) %(objectname) %(objectsize) %(rest)' \
| sed -n 's/^blob //p' \
| sort --numeric-sort --key=2 \
| cut -c 1-12,41- \
| numfmt --field=2 --to=iec-i --suffix=B --padding=7 --round=nearest
}

# git lines per person
function git-stats() {
    git ls-files $1 | grep -v "\.csv\|\.bin\|\.so\|\.dll" | xargs -n1 git blame -w | perl -n -e '/^.*?\((.*?)\s+[\d]{4}/; print $1,"\n"' | sort -f | uniq -c | sort -nr
}

# print an svg piechart to stdout
# requires pygal (pip install pygal)
# ex: piechart "My Chart" "cat 1" 1.25 "cat 2" 3.56 "cat 3" 2.34 > /tmp/out.svg && firefox /tmp/out.svg
function piechart() {
  python -c "import sys, pygal; pie_chart = pygal.Pie(); \
  pie_chart.title = sys.argv[1]; \
  slices = zip(*[iter(sys.argv[2:])]*2); \
  map(lambda a: pie_chart.add(a[0],float(a[1])), slices); \
  print pie_chart.render()" "$@"
}

# log_2 distribution of file sizes in cwd
function filesizes() {
  find . -type f -print0 | \
    xargs -0 ls -l | \
    awk '{size[int(log($5)/log(2))]++}END{for (i in size) printf("%10d %3d\n", 2^i, size[i])}' | \
    sort -n
}

# time function
function bash-time() {
  for i in {1..${2:-255}}; do
    bash -c "time $1";
  done 2>&1 | rg "^real"
}

# haste client
# Either set env variable HASTE_SERVER to your server base url, eg:
# HASTE_SERVER=https://hastebin.com
# or
# Put a file ~/.hastebin with the url.
# Returns url of paste. TODO doesn't return non-zero on failure
# Inspired by https://github.com/seejohnrun/haste-client#lightweight-alternative
function hastebin() {
  a=$(cat);
  if [ -z "$HASTE_SERVER" ]; then
    if [ -f ~/.hastebin ]; then
      local HASTE_SERVER=$(cat ~/.hastebin)
    else
      local HASTE_SERVER='https://hastebin.com'
    fi
  fi
  curl -X POST -s -d "$a" $HASTE_SERVER/documents | awk -v HASTE_SERVER=$HASTE_SERVER -F '"' '{print HASTE_SERVER "/" $4}';
}

# Hex dump to binary python oneliner
# usage: hexdump-to-bin abcd0123 > out.bin
function hexdump-to-bin {
    python -c "import sys; sys.stdout.write(sys.argv[1].decode('hex'))" "$1"
}

# weather, from https://wttr.in/:bash.function
# see also: http://wttr.in/:help
function wttr {
  local request="wttr.in/${1-$1}"
  # if $COLUMNS is less than 125, use the compact form
  [ "$COLUMNS" -lt 125 ] && request+='?n'
  curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}

# gnu build id pretty print from elf section
# note: 'file' command also prints it fwiw
# note: 'readelf' can also dump it with -x .note.gnu.build-id
function gnuid() {
  readelf -n "$1" | grep 'Build ID:' | awk '{ print $3 }'
}

# download urls. optionally append second arg to end of urls.
function get-urls() {
  # echo to split words
  for i in $(echo $1); do curl -J -O $i"$2"; done
}

# check files in the directory tree, printing any with mismatched executable
# flag vs hashbang line
function check-hashbang() {
  # burtally slow with gnu find -_-
  HASHBANG_BUT_NOT_X=$(fd -t f --exec bash -c "if ((head -n1 {} | rg '#!' > /dev/null) && !(test -x {}) ); then echo {}; fi")

  if [ -n "$HASHBANG_BUT_NOT_X" ]; then
    echo "HASHBANG_BUT_NOT_X"
    echo "$HASHBANG_BUT_NOT_X"
  fi

  X_BUT_NOT_HASHBANG=$(fd -t f --exec bash -c "if (test -x {} && !(head -n1 {} | rg '#!' > /dev/null)); then echo {}; fi")

  if [ -n "$X_BUT_NOT_HASHBANG" ]; then
    echo "X_BUT_NOT_HASHBANG"
    echo "$X_BUT_NOT_HASHBANG"
  fi
}

function in-this-house() {
  echo "┏┓
┃┃╱╲ in
┃╱╱╲╲ this
╱╱╭╮╲╲house
▔▏┗┛▕▔ we
╱▔▔▔▔▔▔▔▔▔▔╲"
echo $*
echo "╱╱┏┳┓╭╮┏┳┓ ╲╲
▔▏┗┻┛┃┃┗┻┛▕▔"
}

# disable python venv before activating tmux
alias tmux='[ -n "$VIRTUAL_ENV" ] && deactivate; tmux'

# arcanist path
export PATH=$PATH:~/arcinstall/arcanist/bin

# add ccache
export PATH=/usr/lib/ccache:$PATH

# include ~/.local/bin
export PATH=$PATH:~/.local/bin

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  # alias vim to nvim
  if command -v lvim > /dev/null; then
    export EDITOR='lvim'
  else
    export EDITOR='nvim'
  fi
fi
alias vim=${EDITOR}
alias v=${EDITOR}

# go bins
[ -d ~/go/bin ] && export PATH=$PATH:~/go/bin

# make npm global install to user path
export NPM_CONFIG_PREFIX=~/.npm-global
export PATH=$PATH:$NPM_CONFIG_PREFIX/bin

# enable sccache for rust
if type sccache > /dev/null; then
  export RUSTC_WRAPPER=sccache
fi

# add fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source invoke completion
if [ -f ~/.invoke-completion.zsh ]; then
  source ~/.invoke-completion.zsh
fi

# Direnv stuff
if type direnv > /dev/null; then
  export DIRENV_LOG_FORMAT=  # disable logging
  eval "$(direnv hook zsh)"
fi

# Local config, if present
if [ -f ~/.zshrc_local ]; then
  source ~/.zshrc_local
fi

# venv launch
if [ -f ~/.virtualenvs/default/bin/activate ]; then
  source ~/.virtualenvs/default/bin/activate
fi

if [[ "$ZPROF" = true ]]; then
  zprof
fi
