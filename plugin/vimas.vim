" vimas.vim
" Maintainer: Alexis Pereda
" Version: 1

if exists('g:loaded_vimas')
	finish
endif
if !exists(':Obsession')
	echom '[vimas] error: missing tpope-obsession'
	finish
endif
let g:loaded_vimas = 1

"{{{"""""""""""" Variables """"""""""""""""""""""""""""
"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{"""""""""""" Highlights """""""""""""""""""""""""""
"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{"""""""""""" Functions """"""""""""""""""""""""""""

function! VimASCreate()
	call vimas#createsession(vimas#session())
endfunction
function! VimASRemove()
	call vimas#rmsession(vimas#session())
endfunction
function! VimASLoad()
	call vimas#loadsession(vimas#session())
endfunction
function! VimAS(...)
	call vimas#vimas(get(a:, 1, 0))
endfunction

"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{"""""""""""" Commands """""""""""""""""""""""""""""

command! -bang AS :call VimAS(<bang>0)
command! AScreate :call VimASCreate()
command! ASremove :call VimASRemove()
command! ASload :call VimASLoad()

"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{"""""""""""" Autocmd """"""""""""""""""""""""""""""

augroup vimas
	autocmd VimEnter * :call vimas#autocmd_createsession()
augroup end

"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""
