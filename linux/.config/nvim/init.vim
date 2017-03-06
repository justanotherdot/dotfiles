call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'atelierbram/Base2Tone-vim'
Plug 'bitc/vim-hdevtools'
Plug 'eagletmt/neco-ghc'
Plug 'ekalinin/Dockerfile.vim'
Plug 'ervandew/supertab'
Plug 'godlygeek/tabular'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'kamwitsta/flatwhite-vim'
Plug 'martinda/Jenkinsfile-vim-syntax'
Plug 'mileszs/ack.vim'
Plug 'nbouscal/vim-stylish-haskell'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'qpkorr/vim-bufkill'
Plug 'rodjek/vim-puppet'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'

call plug#end()

set cmdheight=1
set completeopt=menuone,menu,longest
set expandtab
set mouse=a
set nofoldenable
set nojoinspaces
set nowrap
set ruler
set shiftwidth=2
set tabstop=2
set termguicolors
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildignorecase
set wildmenu
set wildmode=longest,list,full

colorscheme Base2Tone_EveningDark "Dark theme
" colorscheme flatwhite "Light theme

let mapleader = ","

nnoremap <leader>, :noh<CR>

autocmd! BufWritePost * Neomake

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>

au FileType gitcommit set tw=72

let g:rustfmt_autosave = 1

let g:ackprg = 'ag --nogroup --nocolor --column'

nmap <c-p> :Files<cr>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

let $NVIM_TUI_ENABLE_TRUE_COLOR=1
