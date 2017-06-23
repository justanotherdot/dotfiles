" file: .config/nvim/init.vim | .nvimrc
" author: Ryan James Spencer

call plug#begin('~/.local/share/nvim/plugged')

Plug 'Quramy/tsuquyomi'
Plug 'airblade/vim-gitgutter'
Plug 'atelierbram/Base2Tone-vim'
Plug 'benjie/neomake-local-eslint.vim'
Plug 'bitc/vim-hdevtools'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'mhinz/vim-grepper'
Plug 'nbouscal/vim-stylish-haskell'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'wesQ3/vim-windowswap'

call plug#end()

set cmdheight=1
set completeopt=menuone,longest,preview
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
set grepprg=rg\ --vimgrep

let g:grepper = {
    \ 'tools': ['rg']
    \ }

colo Base2Tone_PoolDark

let mapleader = ","

autocmd! BufWritePost * Neomake

nnoremap <leader><leader> :noh<CR>

au FileType gitcommit set tw=72

let g:rustfmt_autosave = 1

nmap <c-p> :Files<cr>
nmap <c-b> :Buffers<cr>
nmap <c-_> :BLines<cr>
nmap <c-f> :Ag<cr>
nmap <leader>s :StripWhitespace<cr>

" Grep for keywords
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Advanced customization using autoload functions
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Make fzf match colorscheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
" autocmd FileType javascript.jsx,javascript set formatprg=prettier\ --single-quote\ --trailing-comma\ all\ --stdin

" Neoformat on save.
" augroup fmt
  " autocmd!
  " autocmd BufWritePre * Neoformat
" augroup END

function! s:fzf_statusline()
  " Override statusline as you like
  highlight fzf1 ctermfg=161 ctermbg=251
  highlight fzf2 ctermfg=23 ctermbg=251
  highlight fzf3 ctermfg=237 ctermbg=251
  setlocal statusline=%#fzf1#\ >\ %#fzf2#fz%#fzf3#f
endfunction

autocmd! User FzfStatusLine call <SID>fzf_statusline()

let g:netrw_banner = 0

let g:NERDSpaceDelims = 1

" Just use the system clipboard by default
set clipboard=unnamedplus

autocmd BufEnter * EnableStripWhitespaceOnSave

set omnifunc=syntaxcomplete#Complete
