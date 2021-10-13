syntax on
filetype on
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim


"plugin ------
call vundle#begin()
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'udalov/kotlin-vim'
Plugin 'mg979/vim-visual-multi'
Plugin 'terroo/vim-simple-emoji'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
call vundle#end()
"plugin ------


"indent	------
filetype plugin indent on
set shiftwidth=4
set tabstop=4
"indent ------

"visual ------
set nu
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
"visual ------

"map 	------
inoremap jk <ESC>
inoremap {<CR> {<CR>}<C-o>O

map <F1> :Stdheader<CR>
map <F2> :FZF<CR>
map gm :call cursor(0, virtcol('$')/2)<CR>
"map 	------
