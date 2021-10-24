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
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'larsbs/vimterial_dark'
call vundle#end()
"plugin ------


"indent	------
filetype plugin indent on
set shiftwidth=4
set tabstop=4
"indent ------

"visual ------
set nu
set	termguicolors
set background=dark
let	g:airline_theme='vimterial_dark'
colorscheme vimterial_dark
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
"visual ------

"map 	------
inoremap jk <ESC>
inoremap {<CR> {<CR>}<C-o>O

map <F1>  :Stdheader<CR>
map <F2>  :FZF<CR>
map <F3>  :MaximizerToggle<CR>
map gm :call cursor(0, virtcol('$')/2)<CR>
"map 	------
