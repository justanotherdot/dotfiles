" file: .config/nvim/init.vim | .nvimrc
" author: Ryan James Spencer

call plug#begin('~/.local/share/nvim/plugged')

Plug 'Quramy/tsuquyomi'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'SirVer/ultisnips'
Plug 'airblade/vim-gitgutter'
Plug 'atelierbram/Base2Tone-vim'
Plug 'benjie/neomake-local-eslint.vim'
Plug 'fatih/vim-go'
Plug 'honza/vim-snippets'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'parsonsmatt/intero-neovim'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'wesQ3/vim-windowswap'

call plug#end()

set cmdheight=1
set completeopt=menuone,longest,preview
set expandtab
set grepprg=rg\ --vimgrep
set inccommand=nosplit
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

let g:deoplete#enable_at_startup = 1
inoremap <expr><Tab> pumvisible() ? "\<c-n>" : "\<Tab>"
inoremap <expr><s-Tab> pumvisible() ? "\<c-p>" : "\<Tab>"
set omnifunc=syntaxcomplete#Complete

let g:airline_powerline_fonts = 1

" Don't miss snippets with short names
call deoplete#custom#set('ultisnips', 'matchers', ['matcher_fuzzy'])

colo Base2Tone_PoolDark

let mapleader = ","

nnoremap <leader><leader> :noh<CR>

au FileType gitcommit set tw=72

let g:rustfmt_autosave = 1

"Fix scrolling issues with nvim and gnome-terminal.
let $COLORTERM = "gnome-terminal"

nmap <leader><space> :Files<cr>
nmap <leader>. :Buffers<cr>
nmap <leader>/ :BLines<cr>
nmap <leader>f :Rg<cr>
nmap <leader>s :StripWhitespace<cr>

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

" Workaround for ugly green column in search results.
command! -bang BLines
  \ call fzf#vim#buffer_lines(<q-args>, {'options': '--no-color'}, <bang>0)
command! -bang Ag
  \ call fzf#vim#ag(<q-args>, {'options': '--no-color'}, <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=never '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

au! BufWritePost * Neomake

let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']

let g:netrw_banner = 0

let g:NERDSpaceDelims = 1
inoremap <C-_> <C-o>:call NERDComment(0,"toggle")<CR>
vnoremap <C-_> :call NERDComment(0,"toggle")<CR>
nnoremap <C-_> :call NERDComment(0,"toggle")<CR>

" autocmd FileType haskell set formatprg=hfmt
au FileType haskell setlocal formatprg=stylish-haskell
au FileType javascript setlocal formatprg=prettier\ --single-quote\ --trailing-comma\ all\ --stdin

let g:neoformat_try_formatprg = 1

" Run neoformat on save.
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

autocmd FileType less setlocal expandtab shiftwidth=4 softtabstop=4
autocmd FileType php setlocal expandtab shiftwidth=4 softtabstop=4

" Just use the system clipboard by default
set clipboard=unnamedplus

autocmd BufEnter * EnableStripWhitespaceOnSave

" Make escape work in the Neovim terminal.
tnoremap <leader><Esc> <C-\><C-n>

" Make navigation into and out of Neovim terminal splits nicer.
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" I like relative numbering when in normal mode.
autocmd TermOpen * setlocal conceallevel=0 colorcolumn=0

" Prefer Neovim terminal insert mode to normal mode.
"
autocmd BufEnter term://* startinsert
