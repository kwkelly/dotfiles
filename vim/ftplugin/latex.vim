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


