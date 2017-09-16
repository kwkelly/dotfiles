""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" cpp
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
au BufNewFile,BufRead *.txx set filetype=cpp
au BufNewFile,BufRead CMakeLists.txt set filetype=cmake " recognize cmake files
au BufNewFile,BufRead *.cmake,*.cmake.in set filetype=cmake
