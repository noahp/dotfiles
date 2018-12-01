" Should work for neovim and vim8. For neovim, symlink:
" mkdir -p ~/.config/nvim; ln -s ~/.vimrc ~/.config/nvim/init.vim

" ---------------------
" Plug
" ---------------------
" Setting up Plug - A minimalist Vim plugin manager
if has('nvim')
    " Set up for neovim
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
      silent !curl -sfLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
	     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall | source ~/.vimrc
    endif
else
    if empty(glob('~/.vim/autoload/plug.vim'))
      silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs
	     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
      autocmd VimEnter * PlugInstall | source ~/.vimrc
    endif
endif

call plug#begin('~/.vim/plugged')

Plug 'tomasiser/vim-code-dark'                " vim code dark
Plug 'rhysd/vim-clang-format'                 " clang formatter... maybe redundant now
Plug 'tell-k/vim-autopep8'                    " autopep8 for python files... maybe redundant w/ lsp
" https://github.com/junegunn/fzf#as-vim-plugin
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'                " beginning of the end
Plug 'vim-airline/vim-airline-themes'
Plug 'airblade/vim-gitgutter'                 " git status info
Plug 'tpope/vim-fugitive'                     " use git
Plug 'tpope/vim-rhubarb'                      " github links
Plug 'tpope/vim-vinegar'                      " easy netrw open
Plug 'tpope/vim-sleuth'                       " non-insane auto tabs vs spaces
Plug 'tmux-plugins/vim-tmux-focus-events'     " enable focus events in tmux
Plug 'ConradIrwin/vim-bracketed-paste'        " pasting without formatting
Plug 'rust-lang/rust.vim'                     " rusty vim
Plug 'ntpeters/vim-better-whitespace'         " highlight trailing whitespace
Plug 'matze/vim-move'			      " move lines
Plug 'justinmk/vim-sneak'                     " faster search
" LSP
Plug 'w0rp/ale'                               " language client https://github.com/w0rp/ale
call plug#end()

set number    " Show line numbers
" highlight current line
set cursorline
set linebreak    " Break lines at word (requires Wrap lines)
"set showbreak=+++    " Wrap-broken line prefix
set colorcolumn=100 " column marker
set showmatch    " Highlight matching brace
set visualbell    " Use visual bell (no beeping)

set hlsearch    " Highlight all search results
set smartcase    " Enable smart-case search
set ignorecase    " Always case-insensitive
set incsearch    " Searches for strings incrementally

set autoindent    " Auto-indent new lines
set shiftwidth=4    " Number of auto-indent spaces
set smartindent    " Enable smart-indent
set smarttab    " Enable smart-tabs
set softtabstop=4    " Number of spaces per Tab

" syntax highlighting
if has('syntax')
    syntax enable
endif

set background=dark
colorscheme codedark
" let g:solarized_termcolors=256

let g:airline_powerline_fonts = 1

" enable spellcheck
" set spell

set ruler    " Show row and column ruler information

set undolevels=1000    " Number of undo levels
set backspace=indent,eol,start    " Backspace behaviour
" set jj to esc
:imap jj <Esc>

" Use system clipboard
set clipboard^=unnamedplus

" No backup etc
set nobackup
set nowritebackup
set noswapfile

" Automatically update a file if it is changed externally
set autoread
au FocusGained,BufEnter * checktime  " see https://github.com/tmux-plugins/vim-tmux-focus-events

" Set file picker to tree style
let g:netrw_liststyle = 3
let g:netrw_banner = 0

" Use .clang-format file spec for vim-clang-format
let g:clang_format#detect_style_file=1
let g:clang_format#enable_fallback_style='Google'

" Map control-p to :FZF in normal mode
map <C-p> :FZF<CR>

" ALE language server client config
let g:airline#extensions#ale#enabled = 1

" Add language support:
" c: https://github.com/MaskRay/ccls/wiki/Getting-started , sudo ln -s $(realpath Release/ccls) /usr/bin/ccls
" markdown: yarn global add prettier
" python: pip install python-language server
" rust: rustup component add rls-preview rust-analysis rust-src
" vim: pip install vim-vint

" Old autozimu/LanguageClient-neovim config, might need the cquery one to
" auto DB with ale...
" let g:LanguageClient_serverCommands = {
"     \ 'rust': ['rls'],
"     \ 'c': ['cquery', '--init={"cacheDirectory": "/tmp/cquery"}'],
"     \ 'cpp': ['cquery', '--init={"cacheDirectory": "/tmp/cquery"}'],
"     \ 'python': ['pyls'],
"     \ }

" Include local extensions
try
    source ~/.vimrc-extensions
catch
endtry
