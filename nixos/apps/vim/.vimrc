"--- indent & visual 
syntax on
filetype on
filetype plugin indent on
set ts=4
set sw=4
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
set nu
set rnu
"--- indent & visual 

"--- map 
let mapleader=" "
inoremap jk <Esc>
inoremap {<CR> {<CR>}<C-o>O
nnoremap gb ``
nnoremap <Leader>f :Ex <CR>
"--- map 

"--- clipboard
set clipboard=unnamedplus
"--- clipboard
