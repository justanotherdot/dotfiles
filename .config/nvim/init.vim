" file: .config/nvim/init.vim
" author: Ryan James Spencer

call plug#begin('~/.local/share/nvim/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'ajh17/VimCompletesMe'
Plug 'atelierbram/Base2Tone-vim'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'benjie/neomake-local-eslint.vim'
Plug 'fatih/vim-go'
Plug 'godlygeek/tabular'
Plug 'idris-hackers/idris-vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'owickstrom/neovim-ghci'
Plug 'sbdchd/neoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'sheerun/vim-polyglot'
Plug 'shime/vim-livedown'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'

call plug#end()

colo Base2Tone_PoolDark

set clipboard=unnamedplus " System clipboard.
set cmdheight=1
set expandtab
set formatoptions-=o
set grepprg=rg\ --vimgrep
set hidden
set inccommand=nosplit
set mouse=a
set nofoldenable
set nojoinspaces
set nowrap
set ruler
set shiftwidth=2
set softtabstop=2
set tabstop=2
set termguicolors
set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildignorecase
set wildmenu
set wildmode=longest,list,full

let $COLORTERM = 'gnome-terminal' "Fix scrolling issues with nvim and gnome-terminal.
let g:ghci_command = 'stack repl'
let g:ghci_command_line_options = '--ghci-options="-fobject-code"'
let g:NERDSpaceDelims = 1
let g:haskell_indent_disable = 1
let g:airline_powerline_fonts = 1
let g:airline_theme='Base2Tone_PoolDark'
let g:neoformat_try_formatprg = 1
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_jsx_enabled_makers = ['eslint']
let g:netrw_banner = 0
let mapleader = ','
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

command! -nargs=+ -complete=file -bar Rg silent! grep! <args>|cwindow|redraw!
command! -complete=file -bar Date silent! put =strftime('%c')

" Write with sudo trick.
cnoremap w!! w !sudo tee > /dev/null %
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
" nnoremap <A-1> 1gt
" nnoremap <A-2> 2gt
" nnoremap <A-3> 3gt
" nnoremap <A-4> 4gt
nnoremap <A-;> ,
nnoremap ]<space> :bn<CR>
nnoremap [<space> :bp<CR>
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
nnoremap <leader>f :%Neoformat<CR>
nnoremap <leader>m :Neomake<CR>
nnoremap <leader><leader> :noh<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-k> :Buffers<CR>
nnoremap <leader>/ :BLines<CR>
nnoremap <leader>s :StripWhitespace<CR>
nnoremap ga <Plug>(EasyAlign)
xnoremap ga <Plug>(EasyAlign)
" <C-_> is <C-/>
inoremap <C-_> <C-o>:call NERDComment(0,'toggle')<CR>
nnoremap <C-_> :call NERDComment(0,'toggle')<CR>
vnoremap <C-_> :call NERDComment(0,'toggle')<CR>
tnoremap <leader><ESC> <C-\><C-n>

augroup setup
  au BufEnter * EnableStripWhitespaceOnSave
  au FileType gitcommit set tw=72
  au FileType haskell setlocal formatprg=stylish-haskell
  au FileType javascript setlocal formatprg=prettier\ --single-quote\ --trailing-comma\ all
  au TermOpen * setlocal conceallevel=0 colorcolumn=0
  au! BufWritePost * Neomake
  au BufWritePre *.hs Neoformat
  au BufRead,BufNewFile *.md setocal spell
  au FileType gitcommit setlocal spell
  " au BufWritePre *.js,*.py Neoformat
augroup END

" Workaround for ugly green column in search results.
command! -bang BLines
  \ call fzf#vim#buffer_lines(<q-args>, {'options': '--no-color'}, <bang>0)
command! -bang Lines
  \ call fzf#vim#lines(<q-args>, {'options': '--no-color'}, <bang>0)
command! -bang Ag
  \ call fzf#vim#ag(<q-args>, {'options': '--no-color'}, <bang>0)

