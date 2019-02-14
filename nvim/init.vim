" augroup for plugin
augroup MyAutoCmd
  autocmd!
augroup END

autocmd MyAutoCmd FileType help nnoremap <buffer> q <C-w>c

" Shortcut for Configuration Files
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC<CR>
augroup EditVimrc
  autocmd!
  autocmd EditVimrc BufwritePost $MYVIMRC nested source $MYVIMRC
augroup END


" dein.vim {{{
"  directory configuration
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:dein_config_dir = s:config_home . '/nvim/dein'
let g:toml_file = s:dein_config_dir . '/toml/dein.toml'
let g:toml_lazy = s:dein_config_dir . '/toml/dein_lazy.toml'
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
"  dein installation
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
"  path
let &runtimepath = s:dein_repo_dir . ',' . &runtimepath
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(g:toml_file, {'lazy': 0})
  call dein#load_toml(g:toml_lazy, {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
"  install new plugins
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
"  edit plugin lists
nnoremap <silent> <Space>ed :<C-u>edit `=g:toml_file`<CR>
nnoremap <silent> <Space>el :<C-u>edit `=g:toml_lazy`<CR>
" dein.vim }}}

" FILE
filetype plugin indent on
set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double
augroup FileTypeIndent
  autocmd!
  autocmd FileType java        setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType python      setlocal tabstop=4 softtabstop=4 shiftwidth=4
  autocmd FileType javascript  setlocal tabstop=4 softtabstop=4 shiftwidth=4
augroup END

" SEARCH
set ignorecase
set smartcase
set showmatch
set matchtime=1
set wrapscan
nnoremap <silent><F3> :<C-u>noh<CR>

" FORMAT
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start
set wildmenu
set formatoptions+=mM
set wildmode=list:longest
set nrformats=hex
nnoremap + <C-a>
nnoremap - <C-x>

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
set vb t_vb=
let g:indent_guides_enable_on_vim_startup = 1

" Tab
set expandtab
set tabstop=2
set shiftwidth=2

" ViM file control
set nobackup
set noswapfile
set autoread
set hidden

" Ctrl-jhkl to scroll by a step
noremap <C-j> <C-e>
noremap <C-k> <C-y>
noremap <C-h> zh
noremap <C-l> zl
" Move
nnoremap j gj
nnoremap k gk
" Edit
nnoremap ZQ <Nop>
nnoremap Y y$
inoremap <silent> jj <ESC>
imap <Nul> <Nop>
let g:mapleader = ','
set inccommand=split

" Window and Tab control
nnoremap <silent><C-W>r :set wrap!<CR>:set wrap?<CR>
nnoremap s <Nop>
nnoremap st : <C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT

" NERDTree {{{
nnoremap <silent> <C-N> :NERDTreeToggle<CR>
" NERDTree }}}

" Denite.nvim {{{
let g:denite_source_history_yank_enable=1
let g:denite_source_file_mru_limit=200

nmap <Space> [denite]
nnoremap <silent> [denite]f :<C-u>Denite -mode=normal -direction=topleft file_mru<CR>
nnoremap <silent> [denite]b :<C-u>Denite -mode=normal -direction=topleft buffer<CR>
nnoremap <silent> [denite]d :<C-u>Denite -mode=normal -direction=topleft directory_rec<CR>

nnoremap <silent> [denite]o :<C-u>Denite outline -direction=topleft -highlight-mode-insert=Search<CR>
" Denite.nvim }}}

" snippet controls {{{
"  neosnippet key-mappings
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)
xmap <C-k> <Plug>(neosnippet_expand_target)
imap <expr><TAB>
  \ pumvisible() ? "\<C-n>" :
  \ neosnippet#expandable_or_jumpable() ?
  \   "\<Plug>(neosnippet_expand_or_jump" : "\<TAB>"
smap <expr><TAB>
  \ pumvisible() neosnippet#expandable_or_jumpable() ?
  \   "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
imap <expr><CR>
  \ (pumvisible() && neosnippet#expandable()) ?
  \   "\<Plug>(neosnippet_expand_or_jump)" : "\<CR>"
"  neosnippet for snippet_complete marker
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
let g:neosnippet#snippets_directory = s:cache_home . "/dein/repos/github.com/Shougo/neosnippet-snippets/neosnippets"
" snippet controls }}}

" deoplete.nvim {{{
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
" deoplete.nvim }}}

" incsearch.vim {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

set hlsearch
let g:incsearch#auto_nohlsearch=1
map n  <Plug>(incsearch-nohl-n)
map N  <Plug>(incsearch-nohl-N)
map *  <Plug>(incsearch-nohl-*)
map #  <Plug>(incsearch-nohl-#)
map g* <Plug>(incsearch-nohl-g*)
map g# <Plug>(incsearch-nohl-g#)
" incsearch.vim }}}

" vim-easymotion {{{
"  <Leader>f{char} to move to {char}
let g:EasyMotion_do_mapping = 0
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
"  m{char}{char} to move to {char}{char}
nmap m <Plug>(easymotion-overwin-f2)
vmap m <Plug>(easymotion-bd-f2)
"  Move to line
map  <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
"  Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" vim-easymotion }}}

" edgemotion {{{
map {{ <Plug>(edgemotion-k)
map }} <Plug>(edgemotion-j)
" edgemotion }}}

" syntastic {{{
let g:syntastic_enable_signs=1
let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_loc_list_height=6
let g:syntastic_javascript_checkers=['eslint']

let g:syntastic_check_on_open=0  " don't check on open
let g:syntastic_check_on_save=0  " check on save
let g:syntastic_check_on_wq=0    " don't check on wq
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_mode_map = {
    \ 'mode': 'active',
    \ 'active_filetypes': ['javascript'],
    \ 'passive_filetypes': [],
    \ }
" syntastic }}}

" markdown preview {{{
let g:netrw_nogx=1
nmap gx <Plug>(openbrowser-smart-search)
augroup PrevimSettings
  autocmd!
  autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END
cnoreabbr pv PrevimOpen
" markdown preview }}}

" quickrun {{{
if has('unix')
  let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
  let g:vimproc_dll_path= s:cache_home . '/dein/repos/github.com/Shougo/vimproc.vim/lib/vimproc_linux64.so'
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
  \ }
let g:quickrun_no_default_key_mappings = 1
nnoremap <Leader>q :<C-u>write<CR>:QuickRun -mode n<CR>
xnoremap <Leader>q :<C-u>write<CR>gv:QuickRun -mode v<CR>
nnoremap <expr><silent> <C-c> quickrun#is_running ? quickrun#sweep_sessions() : "\<C-c>"
" quickrun }}}


" OWN FUNC
" Zenkaku Space {{{
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
" Zenkaku Space }}}
" ShowToge {{{
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
" ShowToge }}}

" help
:set helplang=ja,en
set keywordprg=:help
cnoreabbr hv tab help usr_41.txt
cnoreabbr he tab help eval.txt


" vim-airline {{{
" let g:airline_mode_map = {
"   \ '  ' : '-',
"   \ 'n'  : 'N',
"   \ 'i'  : 'I',
"   \ 'R'  : 'R',
"   \ 'c'  : 'C',
"   \ 'v'  : 'V',
"   \ 'V'  : 'V',
"   \ 's'  : 'S',
"   \ 'S'  : 'S',
"   \ ''   : 'S',
"   \ }
let g:airline_powerline_fonts = 1
let g:airline_theme = 'badwolf'
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
" vim-airline }}}

" fugitive {{{
nmap [fugitive] <Nop>
map <Leader>g [fugitive]
nnoremap <silent> [fugitive]s :<C-u>Gstatus<CR>
set diffopt+=vertical
nnoremap <silent> [fugitive]d :<C-u>Gdiff<CR>
nnoremap <silent> [fugitive]b :<C-u>Gblame<CR>
nnoremap <silent> [fugitive]l :<C-u>Glog<CR>
" fugitive }}}

" Finally
syntax enable
