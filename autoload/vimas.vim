"{{{"""""""""""" Variables """"""""""""""""""""""""""""

let s:vimas_autocmd_createsession = 0
let s:vimas_sessions_dir = g:vimas_sessions_dir

let g:vimas_blacklist_dirs = [
	\ '~',
	\ '/',
	\ '/bin/.*',
	\ '/boot/.*',
	\ '/dev/.*',
	\ '/etc/.*',
	\ '/lib/.*',
	\ '/lib32/.*',
	\ '/lib64/.*',
	\ '/libx32/.*',
	\ '/lost+found/.*',
	\ '/media/.*',
	\ '/mnt/.*',
	\ '/proc/.*',
	\ '/run/.*',
	\ '/sbin/.*',
	\ '/srv/.*',
	\ '/sys/.*',
	\ '/tmp/.*',
	\ '/usr/.*',
	\ '/var/.*'
	\ ]

"}}}"""""""""""""""""""""""""""""""""""""""""""""""""""
"{{{"""""""""""" Functions """"""""""""""""""""""""""""

"{{{
function! vimas#mksessionname(f)
	let l:session = s:vimas_sessions_dir.substitute(a:f, '/', '%', 'g')
	return substitute(l:session, '%$', '', '')
endfunction
"}}}
"{{{
function! vimas#session()
	return vimas#mksessionname(getcwd())
endfunction
"}}}
"{{{
function! vimas#blacklisted(session)
	for l:dir in g:vimas_blacklist_dirs
		let l:fdir = vimas#mksessionname(fnamemodify(l:dir, ':p'))
		if match(a:session.'%', '^'.l:fdir.'$') != -1
			return 1
		endif
	endfor
	return 0
endfunction
"}}}
"{{{
function! vimas#createsession(session)
	if vimas#blacklisted(a:session)
		return
	endif

	let l:session = fnameescape(a:session)

	if exists(':Obsession')
		silent execute "Obsession ".l:session
		echom "session: ".a:session
	else
		let s:vimas_autocmd_createsession = 1
	endif
endfunction
"}}}
"{{{
function! vimas#rmsession(session)
	if filereadable(a:session)
		if exists(':Obsession')
			silent Obsession!
			echom "session deleted"
		endif
	endif
endfunction
"}}}
"{{{
function! vimas#loadsession(session)
	if vimas#blacklisted(a:session)
		return 0
	endif

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
