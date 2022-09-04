" Install vundle if vundle doesn't exist
if empty(glob("~/.vim/bundle/Vundle.vim"))
	silent execute '!mkdir -p ~/.vim/bundle/'
	silent execute '!mkdir -p ~/.vim/bundle/Vundle.vim/'
	silent execute '!mkdir -p ~/.vim/bundle/Vundle.vim/autoload'
	silent execute '!mkdir -p ~/.vim/bundle/Vundle.vim/autoload/vundle'
	execute '!curl -fLo ~/.vim/bundle/Vundle.vim/autoload/vundle.vim https://raw.githubusercontent.com/VundleVim/Vundle.vim/master/autoload/vundle.vim'
	execute '!curl -fLo ~/.vim/bundle/Vundle.vim/autoload/vundle/config.vim https://raw.githubusercontent.com/VundleVim/Vundle.vim/master/autoload/vundle/config.vim'
	execute '!curl -fLo ~/.vim/bundle/Vundle.vim/autoload/vundle/installer.vim https://raw.githubusercontent.com/VundleVim/Vundle.vim/master/autoload/vundle/installer.vim'
	execute '!curl -fLo ~/.vim/bundle/Vundle.vim/autoload/vundle/scripts.vim https://raw.githubusercontent.com/VundleVim/Vundle.vim/master/autoload/vundle/scripts.vim'
endif
" ----------------------------------------

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
Plugin '42Paris/42header'
Plugin 'tpope/vim-dispatch'
Plugin 'joshdick/onedark.vim'
call vundle#end()
"plugin ------


"indent	------
filetype plugin indent on
set shiftwidth=4
set tabstop=4
"indent ------

"line ------
set nu
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu	| endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu					| set nornu	| endif
augroup END
"line ------

"visual ------
autocmd InsertEnter * set cul
autocmd InsertLeave * set nocul
set	termguicolors
set hlsearch
let g:onedark_hide_endofbuffer=1
let g:onedark_termcolors=256
let g:airline_theme='onedark'
colorscheme onedark
"visual ------

"header ------
let g:user42 = 'qbornet'
let g:mail42 = 'qbornet@student.42.fr'
map gm :call cursor(0, virtcol('$')/2)<CR>
"header ------

"map 	------
inoremap jk <ESC>
inoremap {<CR> {<CR>}<C-o>O
nnoremap gb ``
nnoremap t3 :MaximizerToggle<CR>
nnoremap ts :nohlsearch <CR>

map <F1>  :Stdheader<CR>
"map 	------

"qfix	------
nnoremap tc :Make <CR>
nnoremap tp :cprevious <CR>
nnoremap tn :cnext <CR>
"qfix	------

"buffer	------
set	swb=useopen

nnoremap gn :bn <CR>
nnoremap gp :bp <CR>
"buffer	------

"ctags	------
autocmd BufWritePost *.c,*.h silent! !ctags . &
autocmd BufWritePost *.cpp,*.hpp silent! !ctags . &

nnoremap ta :tnext <CR>
nnoremap tb :tprev <CR>
"ctags	------

"skel   ------
autocmd BufNewFile Makefile 0r ~/.vim/templates/Makefile.template | :normal Gddgg
autocmd BufNewFile main.cpp 0r ~/.vim/templates/main.template.cpp | :normal Gddgg
"skel   ------
