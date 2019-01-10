" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
" source ~/.vimrc

" augroup for plugin (used in dein.toml)
augroup MyAutoCmd
  autocmd!
augroup END


" dein.vim {{{
"  dein install
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:dein_config_dir = s:config_home . '/nvim/dein'
let s:toml_file      = s:dein_config_dir . '/toml/dein.toml'
let s:toml_lazy_file = s:dein_config_dir . '/toml/dein_lazy.toml'
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:toml_file,      {'lazy': 0})
  call dein#load_toml(s:toml_lazy_file, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
"  install lacked plugins
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" [TODO] change file names to the defined variables above
nnoremap <silent> <Space>ed :<C-u>edit ~/.config/nvim/dein/toml/dein.toml<CR>
nnoremap <silent> <Space>el :<C-u>edit ~/.config/nvim/dein/toml/dein_lazy.toml<CR>
" dein.vim }}}


filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double


" SEARCH
set ignorecase
set smartcase
set showmatch
set matchtime=1
set wrapscan
set incsearch
set hlsearch!
nnoremap <silent><F3> :noh<CR>


" EDIT
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start
set wildmenu
set formatoptions+=mM
set wildmode=list:longest
if !has('nvim')
  set clipboard+=autoselect
endif


" ASSIST
set nrformats=hex


" DISPLAY
set number
set ruler
set list
set listchars=tab:>-,extends:<,trail:-,eol:<
set nowrap
set laststatus=2
set cmdheight=2
set showcmd
set title
set cursorline
set cursorcolumn
set virtualedit=onemore
set visualbell
let g:indent_guides_enable_on_vim_startup = 1


" Tab
set list listchars=tab:\>\-
set expandtab
set tabstop=2
set shiftwidth=2


" FILE
set nobackup
set noswapfile
set autoread
set hidden


" remapping
"RE-STANDARDIZED  nnoremap : ;
"RE-STANDARDIZED  nnoremap ; :
nnoremap <C-J> G
nnoremap <C-K> gg
nnoremap <C-H> ^
nnoremap <C-L> $
nnoremap j gj
nnoremap k gk
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap st :<C-u>tabnew<CR>
nnoremap sT :<C-u>Unite tab<CR>
nnoremap sn gt
nnoremap sp gT
nnoremap Y y$
inoremap <silent> jj <ESC>
imap <Nul> <Nop>
let g:mapleader = ',' 

autocmd FileType help nnoremap <buffer> q <C-w>c

" edit vimrc
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC<CR>
augroup editvimrc
  autocmd!
  autocmd editvimrc BufWritePost $MYVIMRC nested source $MYVIMRC
augroup END


" Japanese Help (requires vim-jp/vimdoc-ja)
:set helplang=ja,en


" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>

" Unite
let g:unite_source_history_yank_enable=1
nmap <Space> [unite]
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> [unite]n :<C-u>UniteWithBufferDir file file/new -buffer-name=file<CR>
nnoremap <silent> [unite]f :<C-u>Unite<Space>buffer file_mru<CR>
nnoremap <silent> [unite]d :<C-u>Unite<Space>directory_mru<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
nnoremap <silent> [unite]r :<C-u>Unite<Space>register<CR>
nnoremap <silent> [unite]t :<C-u>Unite<Space>tab<CR>
nnoremap <silent> [unite]h :<C-u>Unite<Space>history/yank<CR>
nnoremap <silent> [unite]o :<C-u>Unite<Space>outline<CR>
nnoremap <silent> [unite]<CR> :<C-u>Unite<Space>file_rec:!<CR>
autocmd FileType unite call s:unite_my_settings()
function! s:unite_my_settings()"{{{
  nmap <buffer> <ESC> <Plug>(unite_exit)
endfunction"}}}
" ag for Unite
let g:unite_source_grep_command = 'ag'
let g:unite_source_grep_default_opts = '--nocolor --nogroup'
let g:unite_source_grep_max_candidates = 200
let g:unite_source_grep_recursive_opt = ''
vnoremap /g y:Unite grep::-iRn:<C-R>=escape(@", '\\.*$^[]')<CR><CR>



" syntastic
"--------------------
let g:syntastic_enable_signs = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_checkers_haskell=['hlint']

let g:syntastic_check_on_open=0 "don't check on open
let g:syntastic_check_on_save=1 "check on save
let g:syntastic_check_on_wq=0   "don't check on wq
let g:syntastic_auto_loc_list=1 "open location_list when error detected
let g:syntastic_loc_list_height=6 "height of location_list
set statusline+=%#warningmsg#   "format of error message
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'active_filetypes': ['javascript'],
    \ 'passive_filetypes': [],
    \ }



" vim-ref
"--------------------
let g:ref_source_webdict_sites = {
\  'stackage' : { 'url' : 'https://www.stackage.org/lts-10.4/hoogle?q=%s' }
\}
cnoreabbr refst Ref webdict stackage
cnoreabbr refstT tabnew \| Ref webdict stackage




""""""""""""""""""""
" ZENKAKU SPACE
""""""""""""""""""""
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
endfunction

if has('syntax')
augroup ZenkakuSpace
  autocmd!
  autocmd ColorScheme * call ZenkakuSpace()
  autocmd VimEnter,WinEnter,BufRead * let w:ml=matchadd('ZenkakuSpace', '　')
augroup END
call ZenkakuSpace()
endif


function! ShowToge()
  highlight ShowToge ctermfg=magenta guifg=magenta
endfunction
if has('syntax')
  augroup ShowToge
    autocmd!
    autocmd ColorScheme * call ShowToge()
    autocmd VimEnter,WinEnter,BufRead * match ShowToge /[,;=]/
  augroup END
  call ShowToge()
endif


" neosnippet
" neosnippet key-mappings
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
" SuperTab like snippets behavior
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "<Plug>(neosnippet_expand_or_jump)"
      \ : pumvisible() ? "<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
      \ "<Plug>(neosnippet_expand_or_jump)"
      \ : "\<TAB>"
" neosnippet For snippet_complete marker
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" FILETYPE SETTINGS
autocmd BufRead,BufNewFile *.java setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.py   setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.js   setlocal tabstop=4 softtabstop=4 shiftwidth=4




" open-browser.vim
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-searchlet g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search))


" previm
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
cnoreabbr pv PrevimOpen


" quickrun {{{
if has('linux64')
  let g:vimproc_dll_path=  '~/.cache/dein/repos/github.com/Shougo/vimproc.vim/lib/vimproc_linux64.so'
elseif has('unix')
  let g:vimproc_dll_path=  '~/.cache/dein/repos/github.com/Shougo/vimproc.vim/lib/vimproc_linux64.so'
elseif has('mac')
  let g:vimproc_dll_path = $HOME . '/.cache/dein/repos/github.com/Shougo/vimproc.vim/lib/vimproc_mac.so'
endif

let g:quickrun_config = {
  \   "_" : {
  \     'runner' : 'vimproc',
  \     'runner/vimproc/updatetime' : 60,
  \     'outputter' : 'error',
  \     'outputter/error/success' : 'buffer',
  \     'outputter/error/error' : 'quickfix',
  \     'outputter/error/split' : ':rightbelow 8sp',
  \     'outputter/error/close_on_empty' : 1,
  \   },
  \   'haskell' : { 'type' : 'haskell/stack' },
  \   'haskell/stack' : {
  \     'command' : 'stack',
  \     'exec' : '%c %o %s %a',
  \     'cmdopt' : 'runghc',
  \   },
  \ }
let g:quickrun_no_default_key_mappings = 1
nnoremap <leader>q :write<CR>:QuickRun -mode n<CR>
xnoremap <leader>q :<C-U>write<CR>gv:QuickRun -mode v<CR>
nnoremap <expr><silent> <C-c> quickrun#is_running ? quickrun#sweep_sessions() : "\<C-c>"
cnoreabbr qr QuickRun
" quickrun }}}


" beta {{{
nnoremap <leader>wy :set wrap<CR>
nnoremap <leader>wn :set nowrap<CR>
" beta }}}
