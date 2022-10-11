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

if empty($ATHOME)
	syntax on
endif
filetype on
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim


"plugin ------
call vundle#begin()
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'terroo/vim-simple-emoji'
Plugin 'szw/vim-maximizer'
Plugin '42Paris/42header'
Plugin 'tpope/vim-dispatch'
Plugin 'sheerun/vim-polyglot'
Plugin 'wellle/targets.vim'
if !empty($ATHOME)
	Plugin 'ycm-core/YouCompleteMe'
endif
Plugin 'joshdick/onedark.vim'
call vundle#end()
"plugin ------

" YouCompleteMe options
" Honestly this shit is overkill for my usage
" I actually need something looking more like this:
" https://github.com/jackguo380/vim-lsp-cxx-highlight
" The probleme is that most of the other semantic highlighting are not good.
" To me personally, some are pure dogshit no offense, 
" and other are just lacking in general they dont have the little plus that makes it good, 
" so yeah overkill but statisfying :>
"ycm	------
if !empty($ATHOME)
	"set to 1 for sementic highlighting
	let g:ycm_enable_semantic_highlighting = 1
	"set to 0 disable diagnostic ui
	let g:ycm_show_diagnostics_ui = 0
	"set to have the diagnostic text on the right side
	"let g:ycm_echo_current_diagnostic = 'virtual-text'
	"set to '' disable autohover
	let g:ycm_auto_hover=''
	"set to 0 disable AUTO COMPLETE YEEEEEAH
	let g:ycm_auto_trigger = 0
endif

" This is need to customize the color  on specific keyword
" :h group-name are use to highlight the color of specific keyword.
if !empty($ATHOME)
	let MY_YCM_HIGHLIGHT_GROUP = {
		  \   'typeParameter': 'PreProc',
		  \   'parameter': 'Normal',
		  \   'variable': 'Normal',
		  \   'property': 'Normal',
		  \   'enumMember': 'Normal',
		  \   'event': 'Special',
		  \   'member': 'Normal',
		  \   'method': 'Normal',
		  \   'class': 'Function',
		  \   'namespace': 'Constant',
		  \ }

	" Add the above custom colors (colorscheme colors)
	for tokenType in keys( MY_YCM_HIGHLIGHT_GROUP )
	  call prop_type_add( 'YCM_HL_' . tokenType,
						\ { 'highlight': MY_YCM_HIGHLIGHT_GROUP[ tokenType ] } )
	endfor
endif
"ycm	------

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
set hidden

nnoremap <F5> :buffers <CR>
"buffer	------

"ctags	------
autocmd BufWritePost *.c,*.h,*.cpp,*.hpp silent! !ctags . &

nnoremap ta :tnext <CR>
nnoremap tb :tprev <CR>
"ctags	------

"skel   ------
autocmd BufNewFile Makefile 0r ~/.vim/templates/Makefile.template | :normal Gddgg
autocmd BufNewFile main.cpp 0r ~/.vim/templates/main.template.cpp | :normal Gddgg
autocmd BufNewFile .ccls 0r ~/.vim/templates/main.template.cpp | :normal Gddgg
"skel   ------
