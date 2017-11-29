" INITIALIZE 
augroup MyAutoCmd
  autocmd!
augroup END

" BASIC
set nocompatible
syntax enable
filetype plugin indent on


set encoding=utf-8

" SEARCH
set ignorecase
set smartcase
set showmatch
set matchtime=1
set wrapscan
set incsearch
set hlsearch!
nnoremap <F3> :noh<CR>


" EDIT
set tabstop=2
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start
set wildmenu
set formatoptions+=mM
set wildmode=list:longest
set clipboard+=autoselect


" ASSIST
set nrformats=


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


" COLOR
colorscheme badwolf


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
nnoremap : ;
nnoremap ; :
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


autocmd FileType help nnoremap <buffer> q <C-w>c

" edit vimrc
nnoremap <silent> <Space>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <Space>rv :<C-u>source $MYVIMRC<CR>
nnoremap <silent> <Space>ed :<C-u>edit ~/.vim/rc/dein.toml<CR>
augroup MyAutoCmd
autocmd!
augroup END
autocmd MyAutoCmd BufWritePost $MYVIMRC nested source $MYVIMRC


" Plugin
if !&compatible
set nocompatible
endif
augroup MyAutoCmd
autocmd!
augroup END

let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/.vim/dein/repos/github.com/Shougo/dein.vim'

if &runtimepath !~# '/dein.vim'
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

if dein#load_state(s:dein_dir)
call dein#begin(s:dein_dir)

let g:rc_dir    = expand('~/.vim/rc')
let s:toml      = g:rc_dir . '/dein.toml'
let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

call dein#load_toml(s:toml,      {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})

call dein#end()
call dein#save_state()
endif

if dein#check_install()
call dein#install()
endif


" Unite
let g:unite_source_history_yank_enable=1
nmap <Space> [unite]
nnoremap <silent> [unite]a :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
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





