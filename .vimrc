set encoding=utf-8
set backspace=indent,eol,start
set history=200
set relativenumber number
set wildmenu
set timeout timeoutlen=3000 ttimeoutlen=100
set tabstop=2 shiftwidth=2 expandtab
set scrolloff=5
set linebreak
set noshowmode
set mouse=a
set lazyredraw
set directory=.,~/tmp,/var/tmp,/tmp
set autochdir
set splitbelow splitright

let mapleader = " "
let maplocalleader = ","

filetype plugin indent on

augroup spelling | au!
  "Turns on spellcheck on text files
  au BufEnter * setlocal spell
  au BufEnter *.span setlocal spelllang=es,en_us
  au BufEnter *.zsh setlocal nospell
augroup end

autocmd BufWritePre * %s/\s\+$//e

if has('nvim')
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-W><C-W> <C-\><C-n><C-W><C-W>
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l

  augroup myterm | au!
    au TermOpen * if &buftype ==# 'terminal' | vert resize 75 | endif
    au BufEnter * if &buftype ==# 'terminal' | setlocal nonumber norelativenumber | endif
    au BufEnter * if &buftype ==# 'terminal' | startinsert | endif
    au BufEnter * if &buftype ==# 'terminal' | setlocal nospell | endif
  augroup end
endif


augroup myvimrchooks | au!
  au bufwritepost .vimrc source ~/.vimrc
  au bufwritepost .vimrc AirlineRefresh
augroup END


" Fix j and k moving over long lines
nnoremap j gj
nnoremap k gk

" Move from window to window with CTRL-movement key
inoremap <C-h> <C-\><C-N><C-w>h
inoremap <C-j> <C-\><C-N><C-w>j
inoremap <C-k> <C-\><C-N><C-w>k
inoremap <C-l> <C-\><C-N><C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <ESC><ESC> :update<CR>
inoremap jk <Esc>
inoremap jj <Esc>
inoremap kj <Esc>
inoremap kk <Esc>

"Allow inserting line before/after current
nnoremap <Leader>j :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <Leader>k :set paste<CR>m`O<Esc>``:set nopaste<CR>
"Show wordcound
nnoremap <Leader>w g<C-g>
vnoremap <Leader>w g<C-g>
nnoremap <Leader>s :set spell!<CR>
nnoremap <LocalLeader>S :SSave<CR>
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <Leader>h :set hlsearch!<CR>
"Allow saving of files with sudo when needed
cmap w!! w !sudo tee > /dev/null %

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
"Add my plugins
call plug#begin('~/.vim/bundle')
  Plug 'scrooloose/nerdtree'
  Plug 'vim-syntastic/syntastic'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'easymotion/vim-easymotion'
  Plug 'airblade/vim-gitgutter'
  Plug 'patstockwell/vim-monokai-tasty'
  Plug 'jceb/vim-orgmode'
  Plug 'luochen1990/rainbow'
  Plug 'tpope/vim-surround'
  Plug 'danchoi/ri.vim'
  Plug 'chrisbra/Colorizer'
  Plug 'mboughaba/i3config.vim'
  Plug 'bronson/vim-trailing-whitespace'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'ervandew/supertab'
  Plug 'Valloric/YouCompleteMe'
  Plug 'arzg/vim-corvine'
  Plug 'mhinz/vim-startify'
"  Plug 'roman/golden-ratio'
call plug#end()
runtime! ftplugin/man.vim

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:airline_powerline_fonts = 1
let g:airline_theme=["murmur", "term", "violet", "bubblegum"][system('shuf -i 0-1')]

syntax on
set termguicolors
colorscheme corvine
hi! Normal guibg=NONE ctermbg=NONE
hi! NonText ctermbg=NONE guibg=NONE
