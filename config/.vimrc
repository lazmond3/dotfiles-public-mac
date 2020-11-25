set title
set ttimeoutlen=10
set iskeyword-=_

filetype plugin indent on     " required!
filetype indent on
syntax on
syntax enable

set nocompatible

noremap!  
set backspace=indent,eol,start

set fenc=utf-8
set nobackup
set noswapfile
set autoread

set number
set cursorline
set cursorcolumn
set virtualedit=onemore
set smartindent
set showmatch

set laststatus=2
set wildmode=list:longest

" to input TAB for Makefile, Please use \"insertmode: <Ctrl-v><Tab><CR>\"
set expandtab
set tabstop=4
set shiftwidth=2
set ignorecase
set smartcase
set incsearch
set nowrapscan
inoremap <silent> jj <ESC>
inoremap <C-]> <ESC>
nnoremap ; :
nnoremap : ;
nnoremap <silent> 'w :w
nnoremap <silent> 'q :q

"nnoremap Q <nop>

noremap <Space>h g^
noremap <Space>l g$
noremap <Space>n *


""--新規追加分
nnoremap s <Nop>
"nnoremap sj <C-w>j
"nnoremap sk <C-w>k
"nnoremap sl <C-w>l
"nnoremap sh <C-w>h
"nnoremap sJ <C-w>J
"nnoremap sK <C-w>K
"nnoremap sL <C-w>L
"nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
" cannot use
nnoremap so <C-w>_<C-w>|

nnoremap sO <C-w>=
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>

nnoremap st :<C-u>tabnew<CR>

"cannot use no Unite tab plugin
"nnoremap sT :<C-u>Unite tab<CR>

nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
"nnoremap sb :<C-u>Unite buffer_tab -buffer-name=file<CR>
"nnoremap sB :<C-u>Unite buffer -buffer-name=file<CR>


:set clipboard+=unnamed

inoremap <C-]> <C-[>


nnoremap <C-[><C-[> :set hlsearch!<CR>
nnoremap <C-]><C-]> :set hlsearch!<CR>
nnoremap <ESC><ESC> :set hlsearch!<CR>
nnoremap vs :vs<CR><C-w>l
nnoremap ss :sp<CR><C-w>j
nnoremap ; :
nnoremap : ;

nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

noremap Y y$
noremap Y y$

nnoremap <C-n><C-p> :set paste!<CR>




nnoremap <C-w><C-l> 3<C-w>>
nnoremap <C-w><C-h> 3<C-w><
nnoremap <C-w><C-k> 3<C-w>+
nnoremap <C-w><C-j> 3<C-w>-
nnoremap <C-w><C-w> <nop>

nnoremap ;rr :source ~/.vimrc
nnoremap ;ee :e ~/.vimrc

set encoding=utf-8
set fileencodings=iso-2022-jp,euc-jp,sjis,utf-8
set formatoptions-=ro


" nvim の設定を真似する。

call plug#begin('~/.vim/plugged')
" call plug#begin('~/.vim/autoload/plug.vim')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'udalov/kotlin-vim'
Plug 'tomasr/molokai'
Plug 'hdiniz/vim-gradle'
Plug 'chr4/nginx.vim'

" Plug 'rust-lang/rust.vim'
" Plug 'ayu-theme/ayu-vim' " or other package manager
Plug 'itchyny/lightline.vim'
Plug 'tyru/caw.vim'
" Plug 'vim-jp/vimdoc-ja'
Plug 'tyru/caw.vim'
Plug 'vim-jp/vimdoc-ja'
" Plug 'HerringtonDarkholme/yats.vim'
Plug 'leafgarland/typescript-vim'

call plug#end()

nnoremap <silent> <C-]> :call fzf#vim#tags(expand('<cword>'))<CR>
" fzfからファイルにジャンプできるようにする
let g:fzf_buffers_jump = 1

colorscheme molokai

" CAW コメント昨日
nmap <C-k> <Plug>(caw:hatpos:toggle)
vmap <C-k> <Plug>(caw:hatpos:toggle)

" FZF
nnoremap <C-p> :Files<CR>
nnoremap <C-b>b :Buffers<CR>
nnoremap <C-j> :set number!<CR>
nnoremap <Space>sg :Rg
