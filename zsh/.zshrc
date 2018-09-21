# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

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
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

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

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions wd common-aliases)

source $ZSH/oh-my-zsh.sh

# User configuration
HISTSIZE=10000000
SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
# setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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
alias gsc='git clean -dxf && git submodule foreach --recursive git clean -xfd'
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
alias gdd='git diff origin/$(git rev-parse --abbrev-ref HEAD)'
alias gddo='git difftool --dir-diff origin/$(git rev-parse --abbrev-ref HEAD)'
alias gro='git reset origin/$(git rev-parse --abbrev-ref HEAD)'
alias gnp='git --no-pager'
# 'git reset date'... set date of top commit to current date. use a single variable
# in a subshell to avoid committer/author date not exactly matching
alias grd='(export GIT_COMMITTER_DATE="$(date -R)" git commit --amend --date "$GIT_COMMITTER_DATE" --no-edit)'

# Other aliases
# always use system clipboard with xclip yolo
alias xclip="xclip -selection c"

# print ansi 256 colors
alias show-colors='for i in {0..255}; do printf "\x1b[38;5;${i}mcolor%-5i\x1b[0m" $i ; if ! (( ($i + 1 ) % 8 )); then echo ; fi ; done'

# emoji picker, uses https://github.com/noahp/emoji-fzf
alias emoj="emoji-fzf preview | fzf --preview 'emoji-fzf get --name {1}' | cut -d \" \" -f 1 | emoji-fzf get | xclip"

# alias vim to nvim
alias vim=nvim
alias v=nvim

# no safe cp for me
unalias rm cp mv
# this gets added somewhere, but I'd rather have https://github.com/sharkdp/fd
unalias fd

# pipe data to gnuplot
alias gplot='gnuplot -e "set terminal dumb; plot '"'"'-'"'"' notitle"'
alias gplotp='gnuplot -e "plot '"'"'-'"'"' notitle" -persist'

# Custom functions
function git-plot-loc()	{
    # plot the lines of code in a file per commit
    git log --reverse --oneline -- $1 | cut -d " " -f 1 | xargs -I {} sh -c "git show {}:$1 | wc -l" | gplot
}
function git-cherry-pit() {
    # remove a commit forever, goodbye (well ok it's still in the reflog if you have regrets)
    git rebase -p --onto $1^ $1
}
# fuzzy search git log
function git-select() {
 git log --oneline "$@" | fzf --preview 'git show $(echo {} | cut -d " " -f 1)' | cut -d " " -f 1
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
    python -c "import sys; sys.stdout.write(sys.argv[1].decode('hex'))" $1
}

# disable python venv before activating tmux
alias tmux='[ -n "$VIRTUAL_ENV" ] && deactivate; tmux'

# cmake path
export PATH=$PATH:~/cmake-3.8.1-Linux-x86_64/bin

# arcanist path
export PATH=$PATH:~/arcinstall/arcanist/bin

# add ccache
export PATH=/usr/lib/ccache:$PATH

# include ~/.local/bin
export PATH=$PATH:~/.local/bin

# add fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Source invoke completion
if [ -f ~/.invoke-completion.zsh ]; then
  source ~/.invoke-completion.zsh
fi

# source spaceship!
SPACESHIP_BATTERY_SHOW=false
source "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# Conda utils
if [ -f ~/miniconda2/etc/profile.d/conda.sh ]; then
  source $HOME/miniconda2/etc/profile.d/conda.sh
fi

# venv launch
if [ -n "$VIRTUAL_ENV" ]; then
  source "$VIRTUAL_ENV/bin/activate"
else
  if [ -f ~/.virtualenvs/default/bin/activate ]; then
    source ~/.virtualenvs/default/bin/activate
  fi
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
