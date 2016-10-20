setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal textwidth=79

nnoremap <bar> 79<bar>

" Add nopep8 to end of line
let @p = "A  # nopep8"

""""""""""""""""""""""""""""""""
" Better code block navigation "
""""""""""""""""""""""""""""""""

" next/prev def block
nnoremap ]d /^\s*def<CR>^
nnoremap [d 0?^\s*def<CR>^

" next/prev if/elif/else block
nnoremap ]i /^\s*if\\|^\s*elif\\|^\s*else<CR>^
nnoremap [i 0?^\s*if\\|^\s*elif\\|^\s*else<CR>^

""""""""""""""""""""
" Counsyl specific "
""""""""""""""""""""

function! CounsylPythonPath()
    " Get current file path
    let path = expand('%:p')
    " Remove everything up to, but not including the first iteration of
    " counsyl.
    let path = substitute(path, ".*\\(counsyl\\)\\@=", "", "")
    " Remove everything up to and includeing 'site-packages' for third party
    " stuff.
    let path = substitute(path, "^.*site-packages/", "", "")
    " Remove python file extension
    let path = substitute(path, "\.py$", "", "")
    " Convert '/' to '.'
    let path = substitute(path, "/", ".", "g")
    return path
endfunction
function! CounsylImport(regname)
    " Create import string for word under cursor
    let import_string = "from ".CounsylPythonPath()." import ".expand("<cword>")
    if strchars(import_string) > 79
        let import_string = import_string."  # nopep8"
    endif
    let import_string = import_string."\n"
    call setreg(a:regname, import_string)
    echom import_string
endfunction
function! CounsylTestPath(regname)
    " TODO: be smart and recognize being in a TestCase class
    let test_path = CounsylPythonPath().":".expand("<cword>")."\n"
    call setreg(a:regname, test_path)
    echom test_path
endfunction
" Copy import statement to register for word under cursor
nnoremap <silent> <leader>ii :call CounsylImport(v:register)<CR>
" Copy test path to register for word under cursor
nnoremap <silent> <leader>it :call CounsylTestPath(v:register)<CR>

"function! GrepForDefinition()
"    let symbol = expand("<cword>")
"endfunction
"nnoremap <leader>gd :call GrepForDefinition()<CR>
