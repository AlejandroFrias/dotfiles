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
noremap ]d /^\s*def <CR>^
noremap [d 0?^\s*def <CR>^

" next/prev if/elif/else block
noremap ]i /^\s*if \\|^\s*elif \\|^\s*else:<CR>^
noremap [i 0?^\s*if \\|^\s*elif \\|^\s*else:<CR>^

" Grep for possible definition declarations of word under cursor
nnoremap <silent> <leader>gd :call ftplugin#python#GoToDefinition()<CR>

""""""""""""""""""""
" Counsyl specific "
""""""""""""""""""""

" Copy import statement to register for word under cursor
nnoremap <silent> <leader>ii :call ftplugin#python#CounsylImport(v:register)<CR>
" Copy test path to register for word under cursor
nnoremap <silent> <leader>it :call ftplugin#python#CounsylTestPath(v:register)<CR>
