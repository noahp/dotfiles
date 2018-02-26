" ---------------------
" Plug
" ---------------------
" Setting up Plug - A minimalist Vim plugin manager
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -sfLo ~/.vim/autoload/plug.vim --create-dirs
         \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source ~/.vimrc
endif

call plug#begin('~/.vim/plugged')

Plug 'altercation/vim-colors-solarized'       " solarized color scheme
Plug 'rhysd/vim-clang-format'                 " clang formatter
Plug 'tell-k/vim-autopep8'                    " autopep8 for python files
call plug#end()

set number    " Show line numbers
" highlight current line
set cursorline
set linebreak    " Break lines at word (requires Wrap lines)
set showbreak=+++    " Wrap-broken line prefix
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
if has("syntax")
    syntax enable
endif

set background=dark
" colorscheme solarized
" let g:solarized_termcolors=256

" enable spellcheck
" set spell

set ruler    " Show row and column ruler information

set undolevels=1000    " Number of undo levels
set backspace=indent,eol,start    " Backspace behaviour
" set jj to esc
:imap jj <Esc>

" Use .clang-format file spec for vim-clang-format
let g:clang_format#detect_style_file=1

