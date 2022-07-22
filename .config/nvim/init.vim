set encoding=utf-8
scriptencoding utf-8
set fileencodings=utf-8,euc-jp,iso-2022-jp
set fileformats=dos,unix,mac
language message C

set mouse=a
set number
set title
set showmatch

set tabstop=4
set smartindent
set relativenumber
set noswapfile
set scrolloff=8
set signcolumn=yes
set showmode
set showcmd
set confirm
set autochdir


" wsl clipboard
if system('uname -r') =~ "microsoft"
  augroup Yank
  autocmd!
  autocmd TextYankPost * :call system('~/windir/c/windows/system32/clip.exe ',@")
  augroup END
endif

"search setting
set ignorecase
set smartcase
set wrapscan


set shiftwidth=4
set softtabstop=4
set expandtab

command W w
command Q q

set list
set listchars=tab:^\ ,trail:-

set cursorline
" move from end of line to start of line
set whichwrap=b,s,h,l,<,>,[,],~

inoremap jj <Esc>
nnoremap j gj
nnoremap k gk
nnoremap <down> gj
nnoremap <up> gk
nnoremap <esc><esc> :noh<CR>

" buffer-----
nnoremap <silent> <C-j> :bprev<CR>
nnoremap <silent> <C-k> :bnext<CR>
" save automaticlly when swapping buffer
set hidden

" recognize the filetype
filetype plugin indent on

"--------------------
"terminal setting
"--------------------

"go normal-mode
:tnoremap jj <C-\><C-n>

" :T -> open terminal at the bottom
command! -nargs=* T split | wincmd j | resize 7 | terminal <args>

" go into terminal mode with insert-mode
autocmd TermOpen * startinsert

"------------------------------------------------------
"dein
" -----------------------------------------------------
if &compatible
  set nocompatible
endif
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  let s:toml_dir = expand('~/.config/nvim')
  call dein#load_toml(s:toml_dir . '/dein.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml', {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif


if dein#check_install()
  call dein#install()
endif
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
"-----------------------------
" everforest (colorscheme)
" ----------------------------
syntax on
syntax enable
if has('termguicolors')
  set termguicolors
endif

set background=dark
let g:everforest_background = 'hard'
let g:everforest_better_performence = 1

" できないから取りあえず
colorscheme nightfox


"========================================="
" nerdtree
"========================================="
" when directory, show the full screen tree
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) | NERDTree | q | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>

" fzf ---------------------------------
set rtp+=/usr/local/opt/fzf
nnoremap df :FZF<cr>


" rainbow-------------------------------
let g:rainbow_active = 1

"coc---------------------------------------------
"go :CocConfig to edit configuration

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

"-------------------------------------------------
