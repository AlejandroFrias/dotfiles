set nocompatible              " be iMproved, required
filetype off                  " required

"""""""""""""""""""""""""""y"
" Packages/Plugins 
""""""""""""""""""""""""""""
" (Vundle Managed) "
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-fugitive'  " Git integration
Plugin 'tpope/vim-obsession'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'dhruvasagar/vim-prosession'
Plugin 'elzr/vim-json'
Plugin 'haya14busa/incsearch.vim'
Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'SirVer/ultisnips'
Plugin 'terryma/vim-expand-region'
Plugin 'vim-scripts/gitignore'
Plugin 'vimwiki/vimwiki'
Plugin 'Yggdroot/indentLine'
Plugin 'python/black'
Plugin 'nvie/vim-flake8'
Plugin 'jvirtanen/vim-octave'

call vundle#end()            " required
filetype plugin indent on    " required

""""""""""""""""""""
" General Settings "
""""""""""""""""""""
let g:black_linelength=99
let g:black_virtualenv="~/.vim_black"

let mapleader=" "
syntax on
set timeoutlen=3000 ttimeoutlen=100

" closetag.vim. <C-_> auto closes html/xml tags
autocmd FileType html,xml,xsl source ~/.vim/scripts/closetag.vim

" I save my tags file (As generated by exuberant ctags) here in the .git
" folder
set tags=.git/ctags

" 4-space tabs
set softtabstop=4
set tabstop=4
set shiftwidth=4
set expandtab

" allow copy/paste to interact with system clipboard
set clipboard=unnamed

set scrolloff=1
set sidescrolloff=0

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
" unlikely to want to match these
set wildignore+=*.class,*.o,*.pyc,*.git,*/venv/*,*.swp,*/vendor/*,*.gif,*.png

set backspace=2 " make backspace work like most other editors

set hidden
" set autowriteall
set switchbuf=usetab

" Close location list or quickfix when selecting file
autocmd FileType qf nnoremap <buffer> <CR> <CR>:cclose<CR>:lclose<CR>

set shortmess=at

" temporary files get they're own directories
set backupdir=.backup/,~/.backup/,/tmp//
set directory=.swp/,~/.swp/,/tmp//
set undodir=.undo/,~/.undo/,/tmp//

packadd! matchit
""""""""""""""""""
" TOGGLE OPTIONS "
""""""""""""""""""
" Display altering toggle options
nnoremap <silent> <F1> :set hlsearch! \| set hlsearch?<CR>
imap <silent> <F1> <C-O><F1>
nnoremap <silent> <F2> :set wrap! \| set wrap?<CR>
imap <silent> <F2> <C-O><F2>
nnoremap <silent> <F3> :if &list == 0 \| set list \| execute 'IndentLinesEnable' \| else \| set nolist \| execute 'IndentLinesDisable' \| endif<CR>
imap <silent> <F3> <C-O><F3>
nnoremap <silent> <F4> :set relativenumber! \| set relativenumber?<CR>
imap <silent> <F4> <C-O><F4>
nnoremap <silent> <F5> :set cursorline! \| set cursorline?<CR>:set cursorcolumn! \| set cursorcolumn?<CR>
imap <silent> <F5> <C-O><F5>

" Behavior-altering option toggles
nnoremap <silent> <F8> :set ignorecase! \| set ignorecase?<CR>
imap <silent> <F8> <C-O><F8>
nnoremap <silent> <F9> :set scrollbind! \| set scrollbind?<CR>
imap <silent> <F9> <C-O><F9>
nnoremap <silent> <F10> :set spell! \| set spell?<CR>
imap <silent> <F10> <C-O><F10>
nnoremap <silent> <F12> :set paste! \| set paste?<CR>
imap <silent> <F12> <C-O><F12>

" toggle option defaults and settings
set spell
set linebreak
set pastetoggle=<F12>
set listchars=eol:¬,tab:▶\ ,trail:·,extends:>,precedes:<,nbsp:%,space:\ ,conceal:*
set number
set nowrap

set laststatus=2
" filepath [modified] [readonly] [fileformat]       line_number/number_of_lines (%)
set statusline=%F\ %m%r%y%=\ %l/%L

"""""""""""""""""""""""
" indentLine Settings "
"""""""""""""""""""""""
let g:indentLine_color_term = 239
let g:indentLine_bgcolor_term = 235
let g:indentLine_char = '┆'
let g:indentLine_enabled = 0   "don't use indentLine by default

""""""""""""""""""""""
" UltiSnips Settings "
""""""""""""""""""""""
let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
let g:UltiSnipsJumpForwardTrigger="<C-N>"
let g:UltiSnipsJumpBackwardTrigger="<C-P>"
let g:ultisnips_python_style="google"

"""""""""""""""""""""
" NERDTree Settings "
"""""""""""""""""""""
let NERDTreeIgnore=['\.pyc$', '\~$', '\.o$', 'venv[[dir]]', '__pycache__[[dir]]', '\.egg-info[[dir]]']
let NERDTreeQuitOnOpen=1    " Closes NERDTree window after file open
" auto close vim if NERDTree is last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

""""""""""""""""""
" Theme Settings "
""""""""""""""""""
syntax enable     " Use syntax highlighting
set background=dark
let g:solarized_termcolors = 256
colorscheme solarized
highlight Normal ctermfg=LightGray

"""""""""""""""""""
" Ctrl-P Settings "
"""""""""""""""""""
let g:ctrlp_mruf_relative = 1
let g:ctrlp_working_path_mode = "ar"
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'
" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
  " Use Ag over Grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor --ignore={*.png,*.gif,*.jpg,*.pdf} -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

"""""""""""""""""""""""
" Custom Key Mappings "
"""""""""""""""""""""""
" Full screen vim window
nnoremap <C-W>+ <C-W>\|<C-W>_

" Quickfix Shortcuts
nnoremap <silent> <leader>co :copen<CR>
nnoremap <silent> <leader>cq :cclose<CR>
nnoremap <silent> <leader>cf :cfirst<CR>
nnoremap <silent> <leader>cl :clast<CR>
nnoremap <silent> <leader>cn :cnext<CR>
nnoremap <silent> <leader>cp :cprevious<CR>

" Move lines easily
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Exit insert mode
inoremap jk <ESC>

"" BUFFER/WINDOW MADNESS
" List and switch buffers CtrlP-style
nnoremap <leader>b :CtrlPBuffer<CR>

" Easy quit
nnoremap <leader>q :q<CR>
vnoremap <leader>q <ESC>:q<CR>

" Highlight all
nnoremap ga ggVG

" arrow keys for scrolling
noremap <Down> 5<C-E>
noremap <Up> 5<C-Y>
noremap <Left> 10zh
noremap <Right> 10zl

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Common mistakes
map q: :q

" System call, but chomp off newline
function! ChompedSystem( ... )
    return substitute(call('system', a:000), '\n\+$', '', '')
endfunction

function! GitHubURL(regname) range
    let path = expand('%')
    let branch = ChompedSystem("git rev-parse --abbrev-ref HEAD")
    let remote_url = ChompedSystem("git config --get remote.origin.url")
    " extract domain and repo from both ssh and https style remote urls
    let domain = substitute(remote_url, '\(ssh://git@\|git@\|https://\)\([a-z.]*\)\(:\|/\).*', '\2', '')
    let repo = substitute(remote_url, '.*'.domain.'\(:\|/\)\([a-zA-Z0-9/_-]*\)\(\.git\)\?', '\2', '')
    let github_url = "https://".domain."/".repo."/blob/".branch."/".path."#L".a:firstline."-L".a:lastline
    call setreg(a:regname, github_url."\n")
    echom github_url
endfunction
" Copy GitHubURL to register and echo at bottom of screen
nnoremap <silent> <leader>g :call GitHubURL(v:register)<CR>
vnoremap <silent> <leader>g :call GitHubURL(v:register)<CR>

" Change bar's default behavior to go to text width column
function! BarWithDefault(count)
    if a:count > 1
        execute "normal! ".a:count."|"
    elseif &tw
        execute "normal! ".&tw."|"
    else
        execute "|"
    endif
endfunction
nnoremap <silent> <bar> :<C-U>call BarWithDefault(v:count1)<CR>
"""""""""""""""""""""""""
" Vim-Surround Mappings "
"""""""""""""""""""""""""
nmap S ysiw

"""""""""""""""""""
" Tagbar Mappings "
"""""""""""""""""""

nnoremap <leader>t :TagbarOpenAutoClose<CR>

""""""""""""""""""""""""""""""
" IncrementalSearch Mappings "
""""""""""""""""""""""""""""""
map / <Plug>(incsearch-forward)
map ? <Plug>(incsearch-backward)

"""""""""""""""""""""
" NERDTree Mappings "
"""""""""""""""""""""
nnoremap <leader>n :NERDTree<CR>
nnoremap <leader>f :NERDTreeFind<CR>zz

"""""""""""""""""""
" Ctrl-P Mappings "
"""""""""""""""""""
" ctrl-p style search through tags (ctag integration)
nnoremap <leader>. :CtrlPTag<CR>

"""""""""""""""""""""""""""""""""""""""""""
" Source machine specific vimrc overrides "
"""""""""""""""""""""""""""""""""""""""""""
if filereadable(expand("~/.vimrc.local"))
    source ~/.vimrc.local
endif

