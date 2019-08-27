""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-plug
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'jcf/vim-latex'
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
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'leafgarland/typescript-vim'
Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'gruvbox-community/gruvbox'
Plug 'SirVer/UltiSnips'
Plug 'honza/vim-snippets'
Plug 'rbgrouleff/bclose.vim'
Plug 'suan/vim-instant-markdown', {'for': 'markdown'}

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
filetype plugin indent on
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
colorscheme gruvbox
let g:airline_theme='gruvbox'
set relativenumber number
set cursorline " add an underline for the line that the cursor is on
set ruler
inoremap jk <esc>
hi CursorLine cterm=NONE ctermbg=black ctermfg=NONE
if has("persistent_undo")
    set undodir=~/.undodir/
    set undofile
endif
" re-soruce the vimrc to update
command! Resource source ~/.vimrc
autocmd FileType netrw setl bufhidden=wipe

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
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*,*/.git/*     " MacOSX/Linux

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ctrl-p
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" let g:ctrlp_map = '<c-p>'
"let g:ctrlp_cmd = 'CtrlPBuffer'
"let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/](\.(git|hg|svn)|node_modules)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }
"let g:ctrlp_working_path_mode = '0'

""makes ctrl o search for files, not buffers
"nmap <C-o> :CtrlP <return>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Denite 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" call denite#custom#filter('matcher/ignore_globs', 'ignore_globs',
"             \ [ '.git/', '.ropeproject/', '__pycache__/',
"             \ 'venv/', 'images/', '*.min.*', 'img/', 'fonts/',
"             \ 'node_modules/'])

" call denite#custom#var('grep', 'recursive_opts', ['-R', '--exclude-dir={node_modules}'])
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set laststatus=2
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" undotree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <S-U> :UndotreeToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_html_tidy_ignore_errors=[" proprietary attribute " ,"trimming empty \<", "inserting implicit ", "unescaped \&" , "lacks \"action", "lacks value", "lacks \"src", "is not recognized!", "discarding unexpected", "replacing obsolete "]

" use ranger instead of netrw
" let g:ranger_replace_netrw = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" coc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <C-o> :Files<CR>
nmap <C-p> :Buffers<CR>
