set nocompatible              " be iMproved, required
filetype off                  " required

""""""""""""""""""""""
" Syntastic Settings "
""""""""""""""""""""""
let g:syntastic_python_checkers = ['pep8','pylint','flake8']
let g:syntastic_css_checkers = ['csslint']
let g:syntastic_coffeescript_checkers = ['coffeelint']
let g:syntastic_json_checkers = ['jsonlint']
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
let g:syntastic_python_checkers_args="--ignore=E731"
let g:syntastic_check_on_wq = 0
let g:syntastic_enable_balloons = 0
let g:syntastic_check_on_open = 1

"""""""""""""""""""""""""""y"
" Plugins (Vundle Managed) "
""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'davidhalter/jedi-vim'
Plugin 'dhruvasagar/vim-prosession'
Plugin 'easymotion/vim-easymotion'
Plugin 'ervandew/supertab'
Plugin 'haya14busa/incsearch-fuzzy.vim'
Plugin 'haya14busa/incsearch.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'SirVer/ultisnips'
Plugin 'terryma/vim-expand-region'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/gitignore'

call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""
" General Settings "
""""""""""""""""""""
" my preferred settings for text files, should be overridden if vim picks up
" the filetype
set tabstop=4
set shiftwidth=4
set expandtab

syntax on

" Allow us to use Ctrl-s and Ctrl-q as keybinds
silent !stty -ixon
" Restore default behaviour when leaving Vim.
autocmd VimLeave * silent !stty ixon

" set the leader to <space>
let mapleader=" "

" allow copy/paste to interact with system clipboard
set clipboard=unnamed

set scrolloff=1
set sidescrolloff=0

set timeoutlen=3000 ttimeoutlen=100

set autoread

" persistent undo!
" Assumes Unix system.
set undofile                  
set undodir=$HOME/.vim/undo
if empty(&undodir)
    call mkdir(&undodir, "p")
endif

set wildmenu                            " get wild
set wildmode=longest:full               " prefix matching for wildmenu
set completeopt+=longest                " insert up to the matched prefix
set wildignore+=*.class,*.o,*.pyc,*.git,*/venv/*,*.swp " unlikely to want to match these

set backspace=2 " make backspace work like most other apps

set confirm  " prompt a confirm message when switching from a modified buffer
set nowrap
""""""""""""""""""""
" SuperTab Settings "
"""""""""""""""""""""
let g:SuperTabCrMapping = 1

""""""""""""""""""""
" Airline Settings "
""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
set encoding=utf-8
let g:airline_powerline_fonts = 1
let g:airline_exclude_preview = 0
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

"""""""""""""""""""""""""
" Vim-Surround Settings "
"""""""""""""""""""""""""
nmap S ysiw

""""""""""""""""""""""
" GitGutter Settings "
""""""""""""""""""""""
let g:gitgutter_map_keys = 0

"""""""""""""""""""""""
" EasyMotion Settings "
"""""""""""""""""""""""
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" EasyMotion regex searching
map  // <Plug>(easymotion-sn)
omap // <Plug>(easymotion-tn)

" next and previous that keep highlighting
map <C-N> <Plug>(easymotion-next)
map <C-B> <Plug>(easymotion-prev)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Easy Line motions
let g:EasyMotion_startofline = 0
map gj <Plug>(easymotion-j)
map gk <Plug>(easymotion-k)
map gl <Plug>(easymotion-sol-bd-jk)

" <leader>f {char} to move to {char}
" map <leader>f <Plug>(easymotion-bd-f)

" Move to word in line
map <leader>w <Plug>(easymotion-bd-W)

""""""""""""""""""""""""""""""
" IncrementalSearch Settings "
""""""""""""""""""""""""""""""
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
map z/ <Plug>(incsearch-fuzzy-/)
map z? <Plug>(incsearch-fuzzy-?)

""""""""""""""""""""""""""
" Expand Region Settings "
""""""""""""""""""""""""""
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

""""""""""""""""""""""
" UltiSnips Settings "
""""""""""""""""""""""
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsJumpForwardTrigger="<C-J>"
let g:UltiSnipsJumpBackwardTrigger="<C-K>"

"""""""""""""""""""""
" NERDTree Settings "
"""""""""""""""""""""
nnoremap <leader>t :NERDTree<CR>
nnoremap <leader>f :NERDTreeFind<CR>zz
let NERDTreeIgnore=['\.pyc$', '\~$', '\.o$', 'website/vendor[[dir]]', 'venv[[dir]]']

let NERDTreeQuitOnOpen=1    " Closes NERDTree window after file open

" auto close vim if NERDTree is last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""""""""""""""""""
" Theme Settings "
""""""""""""""""""
set number        " Show line numbers
syntax enable     " Use syntax highlighting
set background=dark
let g:solarized_termcolors = 256
colorscheme solarized

"""""""""""""""""""
" Ctrl-P Settings "
"""""""""""""""""""
let g:ctrlp_working_path_mode = 0
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
if executable('ag')
      let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

"""""""""""""""""""""""
" Custom Key Mappings "
"""""""""""""""""""""""
" Map key to toggle opt
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

" Toggle spell check
MapToggle <leader>sp spell

" Quick exit insert and undo
inoremap <C-Z> <ESC>u

" Zoom on vim windows.
let g:zoomed = 0
function! ToggleWindowZoom()
    if !exists('w:zoomed')
        let w:zoomed = g:zoomed
    endif
    if w:zoomed == 0
        let w:zoomed = 1
        execute "normal! \<C-W>\<bar>\<C-W>_"
    else
        let w:zoomed = 0
        execute "normal! \<C-W>="
    endif
endfunction
nnoremap <silent> <leader>z :call ToggleWindowZoom()<CR>

" Duplicates line
nnoremap yp Yp
vnoremap yp y`]p
" yank selection without delay (suggest yp is flawed)
vnoremap yy y

" Source vimrc
nnoremap <leader>so :so ~/.vimrc<CR>

" Undo-able insert mode shortcuts
inoremap <c-w> <c-g>u<c-w>
inoremap <c-u> <c-g>u<c-u>

" Quickfix shortcuts
nnoremap <silent> <leader>co :copen<CR>
nnoremap <silent> <leader>cq :cclose<CR>
nnoremap <silent> <leader>cb :colder<CR>
nnoremap <silent> <leader>cf :cnewer<CR>
nnoremap <silent> <leader>cn :cnext<CR>
nnoremap <silent> <leader>cp :cprevious<CR>
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>

" Marks
nnoremap <leader>m :marks 'qwertyuiopasdfghjklzxcvbnm0123456789\"[]^.<CR>:normal `
nnoremap <leader>M :marks QWERTYUIOPASDFGHJKLZXCVBNM<CR>:normal `

" Easier movement to end of line
noremap - $
vnoremap - $h

" quick access to yank buffer (for easy pasting from or deleting into
" yank buffer) at price of slower go to beginning of line
noremap 0 "0
noremap 00 0

" Quicker line jumps
nnoremap <CR> G
vnoremap <CR> G
nnoremap <BS> gg
vnoremap <BS> gg
autocmd CmdwinEnter * nnoremap <CR> <CR>
autocmd BufReadPost quickfix noremap <CR> G

" Insert a single character
function! RepeatChar(char, count)
    return repeat(a:char, a:count)
endfunction
nnoremap s :<C-U>exec "normal! i".RepeatChar(nr2char(getchar()), v:count1)<CR>

" Move lines easily
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Insert lines above and below cursor
nnoremap <leader>o mqo<ESC>`qj
nnoremap <leader>O mqO<ESC>`q

" Delete lines above and below cursor
nnoremap <leader>do mqjdd`q
nnoremap <leader>DO mqkdd`q

" Save easily
nnoremap <C-S> :w<CR>
vnoremap <C-S> <ESC>:w<CR>
inoremap <C-S> <ESC>:w<CR>

" Exit insert mode
inoremap jk <ESC>
inoremap kj <ESC>
inoremap kk <ESC>
inoremap jj <ESC>
inoremap hh <ESC>
inoremap lll <ESC>

" Undo but stay in insert mode
inoremap <C-U> <C-O>u

"" BUFFER/WINDOW MADNESS
" Split window
nnoremap <leader>sv <C-W>v
nnoremap <leader>ss <C-W>s
" Quick movement between windows
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
" List and switch buffers
nnoremap <leader>bb :ls<CR>:b<space>
" Close current buffer and open next
nnoremap <leader>bq :bnext <BAR> bd #<CR>
" Go to next/previous buffer
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bn :bnext<CR>
" Sqitch to last used buffer
nnoremap <leader>bl :e#<CR>

" Paste from registers
nnoremap <silent> <leader>p :registers poiuylkjhgfdsamnbvcxz0123456789<CR>:silent put<space>
nnoremap <silent> <leader>P :registers poiuylkjhgfdsamnbvcxz0123456789<CR>:silent put!<space>

" Display registers when using them
nnoremap <leader>" :registers poiuylkjhgfdsamnbvcxz<CR>:normal! "
vnoremap <leader>" <ESC>:registers poiuylkjhgfdsamnbvcxz<CR>:normal! gv"

" Easy quit
nnoremap <leader>q :q<CR>
vnoremap <leader>q <ESC>:q<CR>

" arrow keys for scrolling
noremap <Down> <C-E>
noremap <Up> <C-Y>
noremap <Left> zh
noremap <Right> zl

" Stop that stupid window from popping up
map q: :q

" Line indent/dedent
nnoremap > V>
nnoremap < V<
vnoremap > >gv
vnoremap < <gv

" macro for the ubiquitious n. pattern
let @n = "n."

function! LoadQuickfixFileList(filename)
    set errorformat+=%f
    execute "cfile" . a:filename
    set errorformat-=%f
endfunction

function! WriteBufferToQuickFixFileList(filename)
    call writefile(getbufline(bufnr(bufname("%")), 0, "$"), a:filename)
endfunction

function! GitDiffNameOnly(treeish)
    execute "new"
    execute "read ! git diff --name-only ".a:treeish
    execute "normal! ggdd"
    call WriteBufferToQuickFixFileList("/tmp/quickfix.txt")
    call LoadQuickfixFileList("/tmp/quickfix.txt")
endfunction

nnoremap <silent> <leader>cgd :call GitDiffNameOnly("master")<CR>
vnoremap <silent> <leader>cgd "ty:call GitDiffNameOnly(getreg("t"))<CR>
nnoremap <silent> <leader>cw :call WriteBufferToQuickFixFileList("/tmp/quickfix.txt")<CR>
nnoremap <silent> <leader>cf :call LoadQuickfixFileList("/tmp/quickfix.txt")<CR>

""""""""""""""""""""
" Counsyl specific "
""""""""""""""""""""

set wildignore+=*/website/vendor/*
