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
Plugin 'kien/ctrlp.vim'

if has('nvim')
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'scrooloose/syntastic'
endif

Plugin 'vim-scripts/Align'

Plugin 'scrooloose/nerdcommenter'

Plugin 'bling/vim-airline'

Plugin 'tpope/vim-fugitive'

Plugin 'flazz/vim-colorschemes'

Plugin 'chriskempson/base16-vim'

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
set tabstop=2
set smarttab
set nohlsearch " Don't continue to highlight searched phrases.
set incsearch " But do highlight as you type your search.
set cinkeys-=0# " Indent #pragma lines as you would regular code
set ruler " Always show info along bottom.
au BufNewFile,BufRead *.txx set filetype=cpp

" Toggle numbers
nnoremap <F3> :set nonumber!<CR>

" Latex (only load if it can find these)
try
	au FileType tex setlocal spell spelllang=en_us
	let g:tex_flavor='latex'
	nmap <F8> :w<CR><leader>ll<leader>lv
	let g:Tex_DefaultTargetFormat='pdf'
	let g:Tex_MultipleCompileFormats='dvi,pdf'
	if has('unix')
		let s:uname = system('uname -s')
		if s:uname == "Darwin\n"
			let g:Tex_ViewRule_pdf='open -a Preview'
		else
			let g:Tex_ViewRule_pdf='evince'
			"let g:Tex_ViewRule_pdf='open -a Preview'
		endif
	endif
	let Tex_FoldedSections=""
	let Tex_FoldedEnvironments=""
	let Tex_FoldedMisc=""
	let g:Tex_HotKeyMappings='eqnarray*,eqnarray,bmatrix'

	" remap the alt macros to ctrl macros
	" imap <C-b> <Plug>Tex_MathBF
	imap <C-c> <Plug>Tex_MathCal
	imap <C-l> <Plug>Tex_LeftRight
	imap <C-i> <Plug>Tex_InsertItemOnThisLine

	function! Tex_BM()
		return "\<Left>\\bm{\<Right>}"
	endfunction 

	imap <C-b> <C-r>=Tex_BM()<CR>
catch
endtry

nnoremap <tab> <C-w>l
nnoremap <S-tab> <C-w>h

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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

" Ctrl-P options
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux


set background=dark
" hi Constant ctermfg=Yellow
" hi Statement ctermfg=Green
" hi LineNr ctermfg=LightYellow
" 
" hi Visual ctermbg=Black ctermfg=NONE

" Spellcheck for emails
autocmd FileType mail set spell
autocmd FileType mail set fo+=aw

" ctrl-l/n for next last buffer
"nmap <C-L> :bp<CR>
"nmap <C-N> :bn<CR>

" for vimairline
set laststatus=2

if has("gui_running")
	colorscheme jellybeans
	set relativenumber
	set transparency=5
	set macmeta
endif

let g:syntastic_cpp_compiler = 'g++-4.9'
