call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'rust-lang/rust.vim'

call plug#end()

colorscheme gruvbox
set bg=dark

let g:rustfmt_autosave=1
