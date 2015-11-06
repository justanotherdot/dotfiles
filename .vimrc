" System vimrc file for 
" Ryan James Spencer

"optimal width and height
"set lines=50 
"set columns=120

"Set the font depending on the version running
"Change to terminus
"set guifont=/usr/share/fonts/truetype/ttf-gohu/GohuFont-Medium.ttf

set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" Bundle 'syntastic'
Plugin 'christoomey/vim-tmux-navigator'

execut pathogen#infect()

set runtimepath^=/.vim/bundle/ctrlp.vim
set autochdir

filetype plugin indent on

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

" The default for 'backspace' is very confusing to new users, so change it to a
" more sensible value.  Add "set backspace&" to your ~/.vimrc to reset it.
set backspace+=indent,eol,start
set whichwrap+=<,>,h,l

" Disable localized menus for now since only some items are translated (e.g.
" the entire MacVim menu is set up in a nib file which currently only is
" translated to English).
set langmenu=none
set nowrap
set foldmethod=syntax
set foldnestmax=1
set foldlevelstart=1

set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set runtimepath^=~/.vim/bundle/ctrlp.vim

map <silent> <Leader>e :Errors<CR>
map <Leader>s :SyntasticToggleMode<CR>

syntax on
colorscheme gruvbox
set bg=dark

"Enhance command-line completions
set wildmenu

"Character encoding
"set encoding=utf8

" easy escape
inoremap jj <esc>

"Remap the leader
let mapleader = '\'
let g:mapleader = '\'
"Fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :q<cr>
nmap <leader>a :wqa<cr>
nmap <leader>m :make<cr>

" 4 char space smart indent
"set autoindent 
"set smartindent
set tabstop=4
set shiftwidth=4
set expandtab

" set pastetoggle=<F2> (or in this case, <leader>p)
set pastetoggle=<leader>p

"line numbers
set number

"current cursor position
set ruler

set ignorecase
set smartcase
set incsearch
set magic
" highlight search
" set hlsearch
" <Ctrl-l> redraws the screen and removes any search highlighting.
" nnoremap <silent> <C-l> :nohl<CR><C-l>

au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

nnoremap <leader>. :CtrlPTag<cr>

set guitablabel=%t

"autocmd Filetype gitcommit setlocal spell textwidth=72
