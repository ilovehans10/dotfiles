"##############################################################################
" General Settings
"##############################################################################

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
" coc.vim
set hidden
set updatetime=300
set shortmess+=c
set signcolumn=yes

let mapleader = ' '
let maplocalleader = ','

filetype plugin indent on

"##############################################################################
" Auto commands
"##############################################################################

" Turn on spellcheck on text files
augroup spelling | au!
  au BufEnter * setlocal spell
  au BufEnter *.span setlocal spelllang=es,en_us
  au BufEnter *.zsh setlocal nospell
augroup end

" Remove trailing whitespace
augroup trailingwhitespace | au!
  autocmd BufWritePre * %s/\s\+$//e
augroup end

" Create parent directory if needed
function s:MkNonExDir(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup bwcreatedir | au!
  au BufWritePre * :call s:MkNonExDir(expand('<afile>'), +expand('<abuf>'))
augroup END

" Source vimrc when it is saved
augroup myvimrchooks | au!
  au bufwritepost .vimrc source ~/.vimrc
  au bufwritepost .vimrc AirlineRefresh
augroup END

" Put help on the right
augroup helpbuf | au!
  autocmd BufEnter *.txt if &buftype == 'help' | wincmd L | endif
augroup END

"##############################################################################
" Nvim Specific
"##############################################################################

if has('nvim')
" Fix escape behavior and movement for terminal windows
  tnoremap <Esc> <C-\><C-n>
  tnoremap <C-W><C-W> <C-\><C-n><C-W><C-W>
  tnoremap <C-h> <C-\><C-N><C-w>h
  tnoremap <C-j> <C-\><C-N><C-w>j
  tnoremap <C-k> <C-\><C-N><C-w>k
  tnoremap <C-l> <C-\><C-N><C-w>l

" Fix the look of terminal windows
  augroup myterm | au!
    au TermOpen * if &buftype ==# 'terminal' | vert resize 75 | endif
    au BufEnter * if &buftype ==# 'terminal' | setlocal nonumber norelativenumber | endif
    au BufEnter * if &buftype ==# 'terminal' | startinsert | endif
    au BufEnter * if &buftype ==# 'terminal' | setlocal nospell | endif
  augroup end
endif

"##############################################################################
" Mappings
"##############################################################################

" Fix joining empty lines
function! J()
    if getline(line('.')+1)=='' | exe 'normal gJ' | else | join | endif
endfunction
noremap J :call J()<cr>

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
nnoremap <leader>j :set paste<CR>m`o<Esc>``:set nopaste<CR>
nnoremap <leader>k :set paste<CR>m`O<Esc>``:set nopaste<CR>
"Show wordcound
nnoremap <leader>w g<C-g>
vnoremap <leader>w g<C-g>
nnoremap <leader>s :set spell!<CR>
nnoremap <Localleader>S :SSave<CR>
nnoremap <leader>ev :vsplit ~/.vimrc<cr>
nnoremap <leader>h :set hlsearch!<CR>
"Allow saving of files with sudo when needed
cmap w!! w !sudo tee > /dev/null %

"##############################################################################
" Plugins
"##############################################################################

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
  Plug 'ilovehans10/vim-corvine'
  Plug 'scrooloose/nerdtree'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  Plug 'easymotion/vim-easymotion'
  Plug 'airblade/vim-gitgutter'
  Plug 'jceb/vim-orgmode'
  Plug 'tpope/vim-surround'
  Plug 'danchoi/ri.vim'
"  Plug 'chrisbra/Colorizer'
  Plug 'mhinz/vim-startify'
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

let g:airline_powerline_fonts = 1
let g:airline_theme=['murmur', 'term', 'violet', 'bubblegum'][system('shuf -i 0-3')]

"##############################################################################
" Colorscheme
"##############################################################################

syntax on
set termguicolors
colorscheme corvine
hi! Normal guibg=NONE ctermbg=NONE
hi! NonText ctermbg=NONE guibg=NONE

"##############################################################################
" Coc.vim
"##############################################################################

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <TAB> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

