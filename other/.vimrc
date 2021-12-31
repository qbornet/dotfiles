syntax on
filetype on
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim


"plugin ------
call vundle#begin()
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'terroo/vim-simple-emoji'
Plugin 'szw/vim-maximizer'
Plugin 'sheerun/vim-polyglot'
Plugin 'joshdick/onedark.vim'
call vundle#end()
"plugin ------


"indent	------
filetype plugin indent on
set shiftwidth=4
set tabstop=4
"indent ------

"visual ------
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
set nu
set	termguicolors
let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=256
let g:airline_theme='onedark'
colorscheme onedark
"visual ------


"map 	------
inoremap jk <ESC>
inoremap {<CR> {<CR>}<C-o>O
nnoremap gb ``
nnoremap t3 :MaximizerToggle<CR>

map <F1>  :Stdheader<CR>
map gm :call cursor(0, virtcol('$')/2)<CR>
"
