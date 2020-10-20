function! ftplugin#python#PythonPath()
    " Get current file path
    let path = expand('%:p')
    " Remove current working directory from path
    let path = substitute(path, getcwd()."/", "", "")
    " Remove everything up to and includeing 'site-packages' for third party
    " stuff.
    let path = substitute(path, "^.*site-packages/", "", "")
    " Remove python file extension (and possibly __init__)
    let path = substitute(path, "\\(/__init__\\)\\?\.py$", "", "")
    return path
endfunction
function! ftplugin#python#ImportPath(regname)
    " Create import string for word under cursor
    let import_string = "from ".substitute(ftplugin#python#PythonPath(), "/", ".", "g")." import ".expand("<cword>")
    let import_string = import_string
    call setreg(a:regname, import_string."\n")
    echom import_string
endfunction
function! ftplugin#python#pyTestPath(regname)
    " TODO: be smart and recognize being in a TestCase class
    let test_path = ftplugin#python#PythonPath().".py::".expand("<cword>")
    call setreg(a:regname, test_path)
    echom test_path
endfunction
