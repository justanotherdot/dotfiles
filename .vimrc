" VIMRC CONFIG
" Ryan James Spencer

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

call vundle#end()


" Modify font for gtk+ gui
if has("gui_running")
    if has("gui_gtk2")
        set guifont=DejaVu\ Sans\ Mono\ 11
    endif
endif

execute pathogen#infect()
execute pathogen#helptags()


set autochdir

filetype plugin on
filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

let g:airline#extensions#tabline#enabled = 1
set laststatus=2

"disable autocommenting on newlines MUST BE AFTER 'FILETYPE PLUGIN ON'
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
set runtimepath^=~/.vim/bundle/ctrlp.vim
autocmd! BufNewFile,BufRead *.pde setlocal ft=arduino

"Do not close buffers; hide them instead.
set hidden

" The default for 'backspace' is very confusing to new users, so change it to a
" more sensible value.  Add "set backspace&" to your ~/.vimrc to reset it.
set backspace+=indent,eol,start
set whichwrap+=<,>,h,l

" set foldmethod=syntax
" set foldnestmax=1 
" set foldlevelstart=1

set nowrap
set shiftround
set smartcase

set history=1000
set undolevels=1000
set title
set novisualbell
set noerrorbells

" trailing chars for whitespace-centric languages
" set list
" set listchar=tab:>.,trail:.,extends:#,nbsp:.

syntax on

set bg=dark
colorscheme gruvbox

set wildmenu

inoremap jj <esc>

let mapleader = '\'
let g:mapleader = '\'

nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>x :wq!<cr>
nmap <leader>a :wqa<cr>
" r for run
nmap <leader>r :make<cr> 
nmap // :noh<cr>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

set pastetoggle=<leader>p

set tabstop=8
set expandtab
set softtabstop=4
set shiftwidth=4
set shiftround

set number
set ruler

set ignorecase
set smartcase
set incsearch
set magic
set hlsearch
nmap <silent> // :nohlsearch<cr>

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1
