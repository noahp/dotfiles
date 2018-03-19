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
Plug 'prabirshrestha/async.vim'               " required by vim-lsp
Plug 'prabirshrestha/vim-lsp'                 " language server protocol
" https://github.com/junegunn/fzf#as-vim-plugin
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'vim-airline/vim-airline'                " beginning of the end
Plug 'tmux-plugins/vim-tmux-focus-events'     " enable focus events in tmux

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

" Use system clipboard
set clipboard^=unnamedplus

" No backup etc
set nobackup
set nowb
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

" Language Server config
" See https://github.com/prabirshrestha/vim-lsp#registering-servers
if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('cquery')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'cquery',
        \ 'cmd': {server_info->['cquery']},
        \ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
        \ 'initialization_options': { 'cacheDirectory': '/path/to/cquery/cache' },
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'nightly', 'rls']},
        \ 'whitelist': ['rust'],
        \ })
endif

