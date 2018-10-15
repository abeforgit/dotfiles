set number
set showmatch
set visualbell

set hlsearch
set smartcase
set incsearch

set autoindent
set shiftwidth=4
set smartindent
set smarttab
set softtabstop=4

set ruler
set undolevels=1000
set backspace=indent,eol,start


" PLUGINS

call plug#begin('~/.config/nvim/plugged')

call plug#end()


" Filetype specific things
autocmd FileType haskell setlocal tabstop=8 shiftround

let mapleader = ' '
nmap <Leader>nh :noh<return>
