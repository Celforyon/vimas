"{{{"""""""""""" Variables """"""""""""""""""""""""""""

let s:vimas_autocmd_createsession = 0

"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{"""""""""""" Functions """"""""""""""""""""""""""""

"{{{
function! vimas#session()
	let l:home = fnamemodify('~', ':p')
	let l:sdir = l:home.'.vim/sessions/'
	call mkdir(l:sdir, 'p')
	return l:sdir.substitute(getcwd(), '/', '%', 'g')
endfunction
"}}}
"{{{
function! vimas#createsession(session)
	let l:session = fnameescape(a:session)
	if exists(':Obsession')
		execute "Obsession ".l:session
	else
		let s:vimas_autocmd_createsession = 1
	endif
endfunction
"}}}
"{{{
function! vimas#rmsession(session)
	if filereadable(a:session)
		if exists(':Obsession')
			Obsession!
		endif
	endif
endfunction
"}}}
"{{{
function! vimas#loadsession(session)
	let l:session = fnameescape(a:session)
	if filereadable(a:session)
		if argv() == []
			silent execute "source ".l:session
			return 1
		else
			call vimas#createsession(a:session)
		endif
	endif

	return 0
endfunction
"}}}
"{{{
function! vimas#vimas(...)
	let l:bang = get(a:, 1, 0)
	let l:session = vimas#session()
	if filereadable(l:session)
		if l:bang
			call vimas#rmsession(l:session)
		else
			return vimas#loadsession(l:session)
		endif
	else
		call vimas#createsession(l:session)
	endif
	return 0
endfunction
"}}}
"{{{
function! vimas#autocmd_createsession()
	if s:vimas_autocmd_createsession
		call vimas#createsession(vimas#session())
	endif
endfunction
"}}}
"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""
