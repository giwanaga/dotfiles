" augroup for plugin
augroup MyAutoCmd
  autocmd!
augroup END

autocmd FileType help nnoremap <buffer> q <C-w>c

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
let &runtimepath = s:dein_repo_dir . "," . &runtimepath
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
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double
autocmd BufRead,BufNewFile *.java setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.py   setlocal tabstop=4 softtabstop=4 shiftwidth=4
autocmd BufRead,BufNewFile *.js   setlocal tabstop=4 softtabstop=4 shiftwidth=4

" SEARCH
set ignorecase
set smartcase
set showmatch
set matchtime=1
set wrapscan
nnoremap <silent><F3> :noh<CR>

" FORMAT
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start
set wildmenu
set formatoptions+=mM
set wildmode=list:longest
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

" ViM file control
set nobackup
set noswapfile
set autoread
set hidden

" Move and Edit
noremap <C-j> <C-e>
noremap <c-K> <c-y>
noremap <C-h> ^
noremap <C-l> $
nnoremap j gj
nnoremap k gk
nnoremap Y y$
inoremap <silent> jj <ESC
imap <Nul> <Nop>
let g:mapleader = ','

" Window and Tab control
nnoremap <C-W>y :set wrap<CR>
nnoremap <C-W>n :set nowrap<CR>
nnoremap s <Nop>
nnoremap st : <C-u>tabnew<CR>
nnoremap sn gt
nnoremap sp gT

" MISCELLANOUS PLUGIN CONFIGURATION {{{
nnoremap <silent> <C-N> :NERDTreeToggle<CR>
:set helplang=ja,en
" MISCELLANOUS PLUGIN CONFIGURATION }}}

" Denite.nvim {{{
let g:denite_source_history_yank_enable=1
let g:denite_source_file_mru_limit=200

nmap <Space> [denite]
nnoremap <silent> [denite]f : <C-u>Denite -mode=normal -direction=topleft file_mru<CR>
nnoremap <silent> [denite]b : <C-u>Denite -mode=normal -direction=topleft buffer<CR>
nnoremap <silent> [denite]d : <C-u>Denite -mode=normal -direction=topleft directory_rec<CR>
" Denite.nvim }}}

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
map <C-n> <Plug>(edgemotion-j)
map <C-m> <Plug>(edgemotion-k)
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

" Finally
syntax enable
