function! ftplugin#python#GoToDefinition()
    " Grab symbol under cursor
    let symbol = expand("<cword>")
    let search_regex = "^\\s*\\(def \\|class \\)".symbol."(\\|^\\s*".symbol." = "
    exec "Ggrep '".search_regex."'"
endfunction

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
    " Convert '/' to '.'
    let path = substitute(path, "/", ".", "g")
    return path
endfunction
function! ftplugin#python#ImportPath(regname)
    " Create import string for word under cursor
    let import_string = "from ".ftplugin#python#PythonPath()." import ".expand("<cword>")
    let import_string = import_string
    call setreg(a:regname, import_string."\n")
    echom import_string
endfunction
function! ftplugin#python#TestPath(regname)
    " TODO: be smart and recognize being in a TestCase class
    let test_path = ftplugin#python#PythonPath().":".expand("<cword>")
    call setreg(a:regname, test_path."\n")
    echom test_path
endfunction
function! ftplugin#python#LinePath(regname) range
    " TODO: be smart and recognize being in a TestCase class
    let line_path = ftplugin#python#PythonPath().":".a:firstline."-".a:lastline
    call setreg(a:regname, line_path)
    echom line_path
endfunction
