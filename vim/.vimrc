""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'jcf/vim-latex'
Plug 'kien/ctrlp.vim'
Plug 'vim-scripts/Align'
Plug 'vim-scripts/ctags.vim'
Plug 'tpope/vim-commentary'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'moll/vim-bbye'
Plug 'mbbill/undotree'
Plug 'jmcantrell/vim-virtualenv'
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/syntastic'
Plug 'digitaltoad/vim-pug'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'lifepillar/vim-solarized8'
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/python-support.nvim'
Plug 'calebeby/ncm-css' "css completion
Plug 'Shougo/neco-vim' "vimscript completion
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'} "js completion

" " All of your Plugins must be added before the following line
call plug#end()              " required
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
let mapleader="\<Space>"
set mouse=a
set shiftwidth=2
set tabstop=2
set gdefault " use global flag by default in s: commands
set ignorecase
set smartcase " don't ignore capitals in searches
set cinkeys-=0# " Indent #pragma lines as you would regular code
set hidden " hides buffers instead of closing them
set background=dark
set relativenumber
set cursorline " add an underline for the line that the cursor is on
set ruler
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" netrw
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" some good info: http://ellengummesson.com/blog/2014/02/22/make-vim-really-behave-like-netrw/
" let g:netrw_liststyle = 1 " Detail View
" let g:netrw_sizestyle = "H" " Human-readable file sizes
let g:netrw_winsize = 15
let g:netrw_browse_split = 4
let g:netrw_altv = 0
let g:netrw_liststyle = 3 "tree style view
nnoremap <Leader>e :Vexplore <enter>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cut and paste from the system clipboard
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>yy "+yy
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" os x likes to make backspace not work for some reason... hopefully this won't
" screw anything else up
set backspace=indent,eol,start
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrl-p
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPBuffer'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_working_path_mode = '0'

"makes ctrl o search for files, not buffers
nmap <C-o> :CtrlP <return>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
let g:airline_powerline_fonts = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" undotree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <S-U> :UndotreeToggle<cr>

command! Resource source ~/.vimrc

let g:syntastic_javascript_checkers = ['eslint']

let g:jsx_ext_required = 0
let g:tern#command = ["tern"]
let g:tern#arguments = ["--persistent"]

let g:UltiSnipsExpandTrigger="<c-e>"
let g:UltiSnipsJumpForwardTrigger="<c-f>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" inoremap <silent><expr> <Tab>
"     \ pumvisible() ? "\<C-n>" : deoplete#manual_complete()
" inoremap <silent><expr> <TAB>
"     \ pumvisible() ? "\<C-n>" :
"     \ <SID>check_back_space() ? "\<TAB>" :
"     \ deoplete#mappings#manual_complete()
" function! s:check_back_space() abort "{{{
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1]  =~ '\s'
" endfunction"}}}

" Close the documentation window when completion is done
"autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

colorscheme solarized8_dark

