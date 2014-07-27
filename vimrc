set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" " alternatively, pass a path where Vundle should install plugins
" "call vundle#begin('~/some/path/here')
"
" " let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
"
" " The following are examples of different formats supported.
"
" " Keep Plugin commands between vundle#begin/end.
" " plugin on GitHub repo
Plugin 'jcf/vim-latex'
"
Plugin 'fholgado/minibufexpl.vim'
"
"Plugin 'Valloric/YouCompleteMe'
"
"Plugin 'scrooloose/syntastic'
" " plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" " Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" " git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" " The sparkup vim script is in a subdirectory of this repo called vim.
" " Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" " Avoid a name conflict with L9
" Plugin 'user/L9', {'name': 'newL9'}
"
" " All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" " To ignore plugin indent changes, instead use:
" "filetype plugin on
" "
" " Brief help
" " :PluginList          - list configured plugins
" " :PluginInstall(!)    - install (update) plugins
" " :PluginSearch(!) foo - search (or refresh cache first) for foo
" " :PluginClean(!)      - confirm (or auto-approve) removal of unused plugins
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

" some general stuff


set number
syntax on
set autoindent
set smartindent
set mouse=a
set shiftwidth=2

"map <ScrollWheelUp> k
"map <ScrollWheelDown> j
map <ScrollWheelUp> 3<C-Y>
map <ScrollWheelDown> 3<C-E>

" Toggle numbers
nnoremap <F3> :set nonumber!<CR>

" Latex (only load if it can find these)
try
	au FileType tex setlocal spell spelllang=en_us
	let g:tex_flavor='latex'
	nmap <F8> :w<CR><leader>ll<leader>lv
	let g:Tex_DefaultTargetFormat='pdf'
	let g:Tex_MultipleCompileFormats='dvi,pdf'
	let g:Tex_ViewRule_pdf='evince'
	let Tex_FoldedSections=""
	let Tex_FoldedEnvironments=""
	let Tex_FoldedMisc=""
	let g:Tex_HotKeyMappings='eqnarray*,eqnarray,bmatrix'
catch
endtry

" map hjkl to move window
nmap <silent> <A-Up> :wincmd k<CR>
nmap <silent> <A-Down> :wincmd j<CR>
nmap <silent> <A-Left> :wincmd h<CR>
nmap <silent> <A-Right> :wincmd l<CR>


" Clang complete options
try
	let g:clang_user_options='|| exit 0'
	let g:clang_complete_auto = 1
	let g:clang_complete_copen = 1
	let g:clang_library_path = "/usr/lib/"
	nmap <C-P> :clang_close-preview<CR>
catch
endtry

" add an underline for the line that the cursor is on
set cursorline
hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE

" minibufferexplorer
try
	let g:miniBufExplModSelTarget = 1
catch
endtry

" os x likes to make backspace not work for some reason... hopefull this won't
" screw anything else up
set backspace=indent,eol,start


