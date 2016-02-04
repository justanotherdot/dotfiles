"
" .vimrc
"
" Ryan James Spencer

"optimal width and height
"set lines=50
"set columns=120

set nocompatible
filetype off
"set rtp+=~/.vim/bundle/vundle/
"call vundle#rc()

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugin 'syntastic'
Plugin 'VundleVim/Vundle.vim'
Plugin 'morhetz/gruvbox'
Plugin 'godlygeek/tabular'
" Plugin 'plasticboy/vim-markdown'
Plugin 'luochen1990/rainbow'
Plugin 'chriskempson/base16-vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'bling/vim-airline'
Plugin 'Twinside/vim-hoogle'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
" Plugin 'tpope/vim-repeat'
" Plugin 'tpope/vim-eunuch'
" Plugin 'tpope/vim-sleuth'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdcommenter'
" Plugin 'scrooloose/nerdtree'
" Plugin 'dag/vim2hs'
" Plugin 'bitc/vim-hdevtools'
" Plugin 'majutsushi/tagbar' " Don't know about this one just yet
Plugin 'jimenezrick/vimerl'
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
"Plugin 'garbas/vim-snipmate'
"Plugin 'honza/vim-snippets'
"Plugin 'mattn/emmet-vim'
" Plugin 'tpope/vim-fireplace'
" Plugin 'tpope/vim-classpath'
"Plugin 'guns/vim-clojure-static'
" Plugin 'kovisoft/slimv'
" Plugin 'maxbrunsfeld/vim-yankstack'

call vundle#end()

" Modify font for gtk+ gui
if has("gui_running")
    if has("gui_gtk2")
        set guifont=DejaVu\ Sans\ Mono\ 11
    endif
endif

execute pathogen#infect()
execute pathogen#helptags()


filetype plugin indent on
set omnifunc=syntaxcomplete#Complete

"disable autocommenting on newlines MUST BE AFTER 'FILETYPE PLUGIN ON'
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set nocompatible

if has("multi_byte")
    if &termencoding == ""
        let &termencoding = &encoding
    endif
    set encoding=utf-8                     " better default than latin1
    setglobal fileencoding=utf-8           " change default file encoding when writing new files
endif

"Do not close buffers; hide them instead.
set hidden

" The default for 'backspace' is very confusing to new users, so change it to a
" more sensible value.  Add "set backspace&" to your ~/.vimrc to reset it.
set backspace+=indent,eol,start
set whichwrap+=<,>,h,l

" Disable localized menus for now since only some items are translated (e.g.
" the entire MacVim menu is set up in a nib file which currently only is
" translated to English).
set langmenu=none
set nowrap
set nofoldenable " There was a time I liked code folding.
" set foldmethod=syntax
" set foldnestmax=1
" set foldlevelstart=1

set history=1000
set undolevels=1000
"set title
"set novisualbell
"set noerrorbells

set autochdir

set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set runtimepath^=~/.vim/bundle/ctrlp.vim

map <silent> <Leader>e :Errors<CR>
map <Leader>y :SyntasticToggleMode<CR>

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" trailing chars for whitespace-centric languages
" set list
" set listchar=tab:>.,trail:.,extends:#,nbsp:.

syntax on
colorscheme gruvbox
set bg=dark

"Enhance command-line completions
set wildmenu

" easy escape
inoremap jk <esc>

"Remap the leader
let mapleader = '\'
let g:mapleader = '\'
"Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>a :wqa<cr>
nmap <leader>s :StripWhitespace<cr>
" r for run
nmap <leader>r :make<cr>
nmap // :noh<cr>

map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" 4 char space smart indent
"set autoindent
"set smartindent
set tabstop=4
set shiftwidth=4
set shiftround
set softtabstop=4
set expandtab
set nowrap

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" set pastetoggle=<F2> (or in this case, <leader>p)
set pastetoggle=<leader>p

"line numbers
"set number
"current cursor position
set ruler

set ignorecase
set smartcase
set incsearch
set magic

" Need to figure out how to disable this for haskell syntax
" let g:rainbow_active = 1
" au FileType haskell :RainbowToggle

nnoremap <leader>. :CtrlPTag<cr>

set guitablabel=%t

"autocmd Filetype gitcommit setlocal spell textwidth=72

let g:vim_markdown_folding_disabled=1
let g:vim_markdown_no_default_key_mappings=1

let base16colorspace=256

highlight ExtraWhitespace ctermbg=white

" let g:slimv_swank_cmd = '! clisp ~/.vim/bundle/slimv/slime/start-swank.lisp &'

nmap <Alt+p> <Plug>yankstack_substitute_older_paste
nmap <Alt+P> <Plug>yankstack_substitute_newer_paste
