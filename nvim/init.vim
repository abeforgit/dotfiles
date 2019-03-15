syntax on
filetype plugin indent on

set number
set showmatch
set visualbell

set hlsearch
set smartcase
set incsearch

set autoindent
set shiftwidth=4
set smartindent
set expandtab
set smarttab
set softtabstop=4

set ruler
set undolevels=1000
set backspace=indent,eol,start


" PLUGINS

call plug#begin('~/.config/nvim/plugged')
Plug 'Shougo/deoplete.nvim', {'do': 'UpdateRemotePlugins'}
Plug 'Chiel92/vim-autoformat'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug '/usr/share/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'neovimhaskell/haskell-vim', {'for': 'haskell'}
Plug 'alx741/vim-hindent', {'for': 'haskell'}
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'vim-latex/vim-latex', {'for': 'tex'}
Plug 'pangloss/vim-javascript', {'for': 'javascript'}
Plug 'leafgarland/typescript-vim', {'for': 'typescript'}
Plug 'iamcco/markdown-preview.nvim', {'for': 'markdown', 'do': 'cd app & yarn install' }

call plug#end()
" gruvbox things
let g:gruvbox_italic=1
set background=dark
colorscheme gruvbox

" dein things

let g:deoplete#enable_at_startup = 1
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" airline things
let g:airline_powerline_fonts = 1

" syntastic things
let g:syntastic_haskell_checkers = ['hlint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" haskell-vim highlighting thins
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords
" hindent things
let g:hindent_indent_size = 4
" markdown preview things
let g:mkdp_refresh_slow = 1
" Filetype specific things
autocmd FileType haskell setlocal tabstop=8 shiftround

" cool mappings
map ,e :e <C-R>=expand("%:p:h") . "/" <CR>
map ,t :tabe <C-R>=expand("%:p:h") . "/" <CR>
map ,s :split <C-R>=expand("%:p:h") . "/" <CR>

let mapleader = ' '
nmap <Leader>nh :noh<return>
noremap <Leader>af :Autoformat<return>
cmap w!! w !sudo tee >/dev/null %
