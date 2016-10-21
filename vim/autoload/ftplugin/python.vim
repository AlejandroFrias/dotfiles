function! ftplugin#python#GoToDefinition()
    " Grab symbol under cursor
    let symbol = expand("<cword>")
    let search_regex = "^\\s*\\(def \\|class \\)".symbol."(\\|^\\s*".symbol." = "
    exec "Ggrep '".search_regex."'"
endfunction

""""""""""""""""""""
" Counsyl specific "
""""""""""""""""""""

function! ftplugin#python#CounsylPythonPath()
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
function! ftplugin#python#CounsylImport(regname)
    " Create import string for word under cursor
    let import_string = "from ".ftplugin#python#CounsylPythonPath()." import ".expand("<cword>")
    if strchars(import_string) > 79
        let import_string = import_string."  # nopep8"
    endif
    let import_string = import_string."\n"
    call setreg(a:regname, import_string)
    echom import_string
endfunction
function! ftplugin#python#CounsylTestPath(regname)
    " TODO: be smart and recognize being in a TestCase class
    let test_path = ftplugin#python#CounsylPythonPath().":".expand("<cword>")."\n"
    call setreg(a:regname, test_path)
    echom test_path
endfunction
