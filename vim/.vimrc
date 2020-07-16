" Start plugin section
call plug#begin('~/.vim/plugged')
" vim-go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" deoplete
Plug 'Shougo/deoplete.nvim'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
" ctrlp
Plug 'ctrlpvim/ctrlp.vim'
" NERD tree
Plug 'scrooloose/nerdtree'
" End plugin section
call plug#end()

" Open NERD tree
nmap <C-F> :NERDTreeToggle<CR>

" Enable deoplete
let g:deoplete#enable_at_startup = 1

" Hook vim-go into deoplete
call deoplete#custom#option('omni_patterns', { 'go': '[^. *\t]\.\w*' })

" Use gopls in vim-go
let g:go_def_mode='gopls'
let g:go_info_mode='gopls'

" Disable preview when autocompleting
set completeopt-=preview
" Make Vim more useful
set nocompatible
" Use the OS clipboard by default (on versions compiled with `+clipboard`)
set clipboard=unnamed
" Enhance command-line completion
set wildmenu
" Allow cursor keys in insert mode
set esckeys
" Allow backspace in insert mode
set backspace=indent,eol,start
" Optimize for fast terminal connections
set ttyfast
" Add the g flag to search/replace by default
set gdefault
" Use UTF-8 without BOM
set encoding=utf-8 nobomb
" Don’t add empty newlines at the end of files
set nofixendofline
" Never add an empty newlilne at the end of a SVN commit message
autocmd FileType svn set noendofline

set viminfo+=! " make sure vim history works
map <C-J> <C-W>j<C-W>_ " open and maximize the split below
map <C-K> <C-W>k<C-W>_ " open and maximize the split above
set wmh=0 " reduces splits to a single line

" Enable per-directory .vimrc files and disable unsafe commands in them
set exrc
set secure
" Enable syntax highlighting
syntax on
" Enable autoindent
set autoindent
" Make tabs as wide as two spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" Disable line wrapping
set nowrap
" Enable line numbers
set number
" Highlight searches
set hlsearch
" Ignore case of searches
set ignorecase
" Highlight dynamically as pattern is typed
set incsearch
" Always show status line
set laststatus=2
" Respect modeline in files
set modeline
set modelines=4
" Enable mouse in all modes
set mouse=a
" Disable error bells
set noerrorbells
" Don’t reset cursor to start of line when moving around.
set nostartofline
" Show the cursor position
set ruler
" Don’t show the intro message when starting Vim
set shortmess=atI
" Show the current mode
set showmode
" Show the filename in the window titlebar
set title
" Show the (partial) command as it’s being typed
set showcmd

" Start scrolling three lines before the horizontal window border
set scrolloff=3