call plug#begin('~/.local/share/nvim/plugged')

Plug 'atelierbram/Base2Tone-vim'
Plug 'neomake/neomake'
Plug 'eagletmt/neco-ghc'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'bitc/vim-hdevtools'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rust-lang/rust.vim'
Plug 'nbouscal/vim-stylish-haskell'
Plug 'neovimhaskell/haskell-vim'

call plug#end()

set ruler
set tabstop=2
set shiftwidth=2
set expandtab 
set nojoinspaces
set nofoldenable
set cmdheight=1
set nowrap
set mouse=a
set completeopt=menuone,menu,longest
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set wildignorecase 
set termguicolors
colorscheme Base2Tone-Evening-dark

let mapleader = ","

nnoremap <leader>, :noh<CR>

autocmd! BufWritePost * Neomake

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/

let g:rustfmt_autosave = 1
