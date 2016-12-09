"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/Allen/.config/nvim//repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/Users/Allen/.config/nvim/')

" Let dein manage dein
" Required:
call dein#add('Shougo/dein.vim')

" Add or remove your plugins here:
call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
call dein#add('chriskempson/base16-vim')
call dein#add('eagletmt/neco-ghc')
call dein#add('eagletmt/ghcmod-vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('neovimhaskell/nvim-hs')
call dein#add('neovimhaskell/haskell-vim')
call dein#add('atelierbram/Base2Tone-vim')
call dein#add('morhetz/gruvbox')
call dein#add('jnurmine/Zenburn')
call dein#add('baskerville/bubblegum')
call dein#add('othree/yajs.vim')
call dein#add('mhartington/oceanic-next')
call dein#add('nbouscal/vim-stylish-haskell')
call dein#add('neomake/neomake')
call dein#add('tpope/vim-surround')

" Cleanup unused plugins
"call map(dein#check_clean(), "delete(v:val, 'rf')")

" Required:
call dein#end()


" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

set backspace=indent,eol,start

set ruler

set tabstop=2
set shiftwidth=2
set expandtab 

set nowrap

set termguicolors
set background=dark
colorscheme Base2Tone-Evening-dark

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

" Syntastic settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
" 
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
" let g:syntastic_haskell_checkers = ['hlint', 'ghc-mod']
