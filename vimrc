""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'jcf/vim-latex'
Plug 'fholgado/minibufexpl.vim'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/ctags.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'moll/vim-bbye'
Plug 'mbbill/undotree'
Plug 'unblevable/quick-scope'
Plug 'jmcantrell/vim-virtualenv'
Plug 'Valloric/YouCompleteMe'
" " All of your Plugins must be added before the following line
call plug#end()            	 " required
" "
" " Brief help
" " :PlugList          - list configured plugins
" " :PlugInstall(!)    - install (update) plugins
" " :PlugSearch(!) foo - search (or refresh cache first) for foo
" " :PlugClean(!)      - confirm (or auto-approve) removal of unused plugins
" "
" " see :h vundle for more details or wiki for FAQ
" " Put your non-Plugin stuff after this line

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" some general stuff
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set number
syntax on
set autoindent
set mouse=a
set shiftwidth=2
set tabstop=2
set smarttab
set nohlsearch " Don't continue to highlight searched phrases.
set incsearch " But do highlight as you type your search.
set cinkeys-=0# " Indent #pragma lines as you would regular code
set ruler " Always show info along bottom.
set hidden " hides buffers instead of closing them
set background=dark
set relativenumber
set cursorline " add an underline for the line that the cursor is on
filetype plugin indent on
hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE
" switch splits
nnoremap <tab> <C-w>l
nnoremap <S-tab> <C-w>h
" switch buffers with space /bs
nnoremap <Space> :bnext<cr>
nnoremap <Backspace> :bprevious<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Latex (only load if it can find these)
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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
	"imap <C-i> <Plug>Tex_InsertItemOnThisLine

	function! Tex_BM()
		return "\<Left>\\bm{\<Right>}"
	endfunction 

	imap <C-b> <C-r>=Tex_BM()<CR>
catch
endtry

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cpp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.txx set filetype=cpp
au BufNewFile,BufRead CMakeLists.txt set filetype=cmake " recognize cmake files
au BufNewFile,BufRead *.cmake,*.cmake.in set filetype=cmake

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" minibufferexplorer
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" email
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType mail set spell " Spellcheck for emails
autocmd FileType mail set fo+=aw

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vimairline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" undotree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <S-U> :UndotreeToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" QuickScope
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Insert into your .vimrc after quick-scope is loaded.
" Obviously depends on <https://github.com/unblevable/quick-scope> being installed.

" Thanks to @VanLaser for cleaning the code up and expanding capabilities to include e.g. `df`

let g:qs_enable = 0
let g:qs_enable_char_list = [ 'f', 'F', 't', 'T' ]

function! Quick_scope_selective(movement)
    let needs_disabling = 0
    if !g:qs_enable
        QuickScopeToggle
        redraw
        let needs_disabling = 1
    endif
    let letter = nr2char(getchar())
    if needs_disabling
        QuickScopeToggle
    endif
    return a:movement . letter
endfunction

for i in g:qs_enable_char_list
	execute 'noremap <expr> <silent>' . i . " Quick_scope_selective('". i . "')"
endfor


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" python
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79 expandtab autoindent fileformat=unix

highlight BadWhitespace ctermbg=red guibg=darkred
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

set encoding=utf-8
let python_highlight_all=1

au BufNewFile,BufRead *.js, *.html, *.css set tabstop=2 softtabstop=2 shiftwidth=2

let g:ycm_python_binary_path=substitute(system("which python"), "\n$", "", "")

" Add the virtualenv's site-packages to vim path. May be necessary for YCM
if has('python')
py << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	sys.path.insert(0, project_base_dir)
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	execfile(activate_this, dict(__file__=activate_this))
EOF
endif


" Add the virtualenv's site-packages to vim path
if has('python3')
py3 << EOF
import os.path
import sys
import vim
if 'VIRTUAL_ENV' in os.environ:
	project_base_dir = os.environ['VIRTUAL_ENV']
	sys.path.insert(0, project_base_dir)
	activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
	#execfile(activate_this, dict(__file__=activate_this))
	with open(activate_this) as f:
		code = compile(f.read(), activate_this, 'exec')
		exec(code,dict(__file__=activate_this))
EOF
endif
