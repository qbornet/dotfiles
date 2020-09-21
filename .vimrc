set nocompatible
filetype on
set rtp+=~/.vim/bundle/Vundle.vim


call vundle#begin()
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'udalov/kotlin-vim'
Plugin 'mg979/vim-visual-multi'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
call vundle#end()


set cmdheight=2
set nu
set laststatus=2
set noshowmode


syntax on
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
filetype plugin indent on
filetype indent on

inoremap jk <ESC>
inoremap {<CR> {<CR>}<C-o>O

map <F2> :FZF<CR>
