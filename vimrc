set nocompatible

" Setup vim-plug plugins
if filereadable(expand('~/.vim/autoload/plug.vim'))
  let g:plug_home=expand('~/.vim/plugged')
  if has('win32unix') && executable('cygpath')
    " Use mixed path on Cygwin so that Windows git works
    let g:plug_home = split(system('cygpath -m ' . g:plug_home), "\r*\n")[0]
  endif

  call plug#begin()

   " Plugins
  Plug 'inkarkat/vim-ingo-library'
  Plug 'inkarkat/vim-mark'
  Plug 'luochen1990/rainbow'
  let g:rainbow_active = 1
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-repeat'
"  Plug 'tpope/vim-sleuth'
  Plug 'Raimondi/yaifa'
  let g:yaifa_max_lines = 6*1024
  let g:yaifa_shiftwidth = 2
  let g:yaifa_tabstop = 2
  let g:yaifa_expandtab = 1
  Plug 'unblevable/quick-scope'
  Plug 'svermeulen/vim-yoink'
  Plug 'kien/ctrlp.vim'
  let g:ctrlp_map = '<leader>p'
  Plug 'psliwka/vim-smoothie'

  call plug#end()
 endif

" Setup Vundle plugins
if 0 && isdirectory(expand('~/.vim/bundle/Vundle.vim'))
  filetype off

  set rtp+=expand('~/.vim/bundle/Vundle.vim')
  let vimdir = '~/.vim/bundle'
  if has('win32unix')
    " Use mixed path on Cygwin so that Windows git works
    let vimdir = substitute(system('cygpath -m ' . vimdir), '\n\+$', '', '')
  endif

  call vundle#begin(vimdir)

  Plugin 'VundleVim/Vundle.vim'

  " Plugins
  Plugin 'git://github.com/inkarkat/vim-ingo-library'
  Plugin 'git://github.com/inkarkat/vim-mark'
  Plugin 'git://github.com/luochen1990/rainbow'
  let g:rainbow_active = 1

  call vundle#end()
endif

filetype plugin on 
"filetype indent off  " Builtin indents are weird...
syntax enable

set title
set showcmd
set nonumber
set showmatch
set nodigraph
set wrap
set background=dark 
set complete-=i  " Too slow...
set history=10000

" Scroll options
set scrolloff=3
set sidescrolloff=5

" Search tags from current directory up first, then from file's directory
set tags=tags;/,./tags;/

" Search options
set hlsearch
set noincsearch
set nowrapscan

" Silence
set noerrorbells
set visualbell
set t_vb=

" Speedup rendering
set lazyredraw
set ttyfast
set lazyredraw

set list
set listchars=precedes:<,extends:>,tab:▸\ ,trail:▫

" Disable backup files
set nobackup

" Dictionary (install wamerican)
set dictionary=/usr/share/dict/words

" Special keys
if &term == "cygwin"
    set t_kD=[3~
endif
set backspace=indent,eol,start

" Autocomplete menu
set wildmenu
set wildignore+=*.swp,*~,*.o,*.obj,*.py[co],*.class

" Nicer status line
set ruler
set laststatus=2
highlight StatusLine cterm=bold ctermfg=white ctermbg=blue

" Highlight current line
set cursorline

" Highlight 80 columns
au BufReadPost,BufNewFile *
  \ if &ft=~'^\(c\|cpp\|java\|python\|perl\|vim\|sh\)$' |
  \ set colorcolumn=80 | endif

" Enable mouse
if has('mouse')
  set mouse=a
endif

function MyToggleNumbering()
  if &number && &relativenumber
    set nonumber
    set norelativenumber
  elseif &number && ! &relativenumber
    set relativenumber
  elseif ! &number && &relativenumber
    set number
  else  " ! &number && ! &relativenumber
    set number
  endif
endfunction

" File explorer
let g:netrw_banner=0
let g:netrw_liststyle= 3
let g:netrw_preview=1
let g:netrw_alto=0

" Use syntax folds
set foldmethod=manual
"set foldmethod=syntax  " Better but too slow...
set foldminlines=3

" Better leader
let mapleader = " "

" Custom bindings

inoremap <C-H> <Left>
inoremap <C-J> <Down>
inoremap <C-K> <Up>
inoremap <C-L> <Right>

" Save current buffer
nnoremap <F2> :w!<CR>
inoremap <F2> <Esc>:w!<CR>a

" Toggle line numbers
nnoremap <F1> :call MyToggleNumbering()<CR>

" Toggle case-sensitive search
nnoremap <Leader>i :set ic!<CR>

" Navigate errors/vimgrep results
nnoremap <F3> :cprev<CR>
inoremap <F3> <Esc>:cprev<CR>
nnoremap <F4> :cnext<CR>
inoremap <F4> <Esc>:cnext<CR>

" Navigate buffers
nnoremap <F5> :prev<CR>
inoremap <F5> <Esc>:prev<CR>a
nnoremap <F6> :next<CR>
inoremap <F6> <Esc>:next<CR>a

" Navigate windows
nnoremap <F7> <C-W>k<C-W>_
inoremap <F7> <Esc><C-W>k<C-W>_a
nnoremap <F8> <C-W>j<C-W>_
inoremap <F8> <Esc><C-W>j<C-W>_a
nnoremap <S-F7> <C-W>h<C-W>\|
inoremap <S-F7> <Esc><C-W>h<C-W>\|a
nnoremap <S-F8> <C-W>l<C-W>\|
inoremap <S-F8> <Esc><C-W>l<C-W>\|a

nnoremap <C-W>M <C-W>\| <C-W>_
nnoremap <C-W>m <C-W>=

" Navigate tabs
nnoremap <C-F7> :tabprev<CR>
inoremap <C-F7> <Esc>:tabprev<CR>
nnoremap <C-F8> :tabnext<CR>
inoremap <C-F8> <Esc>:tabnext<CR>

" Save and exit
nnoremap <F10> <Esc>:x<CR>
inoremap <F10> <Esc>:x<CR>
nnoremap <S-F10> <Esc>:xa<CR>
inoremap <S-F10> <Esc>:xa<CR>

" Discard and exit
nnoremap <F11> <Esc>:q!<CR>
inoremap <F11> <Esc>:q!<CR>
nnoremap <S-F11> <Esc>:qa!<CR>
inoremap <S-F11> <Esc>:qa!<CR>

" Alias for Esc
inoremap jj <Esc>

" Alias to toggle hlsearch
nnoremap <Leader><Space> :set hlsearch!<CR>

" Alias for YRShow
nnoremap <Leader>y :YRShow<CR>

" Edit binary using xxd-format
augroup Binary
  au!
  au BufReadPre   *.bin,*.o,*.obj,*.exe let &bin=1
  au BufReadPost  *.bin,*.o,*.obj,*.exe if &bin | exe '%!xxd' | set ft=xxd | endif
  au BufWritePre  *.bin,*.o,*.obj,*.exe if &bin | exe '%!xxd -r' | endif
  au BufWritePost *.bin,*.o,*.obj,*.exe if &bin | exe '%!xxd' | set nomod | endif
augroup END

" Abbreviations
iabbrev binsh #!/bin/sh<CR><C-O>:s/^#//e<CR><CR>set -eu<CR>if set -o \| grep -q pipefail; then set -o pipefail; fi<CR>set -x<CR>
iabbrev binpl #!/usr/bin/perl<CR><C-O>:s/^#//e<CR><CR>use strict;<CR>use warnings;<CR>

" CtrlP aliases
map <Leader>h :call SwitchHeader()<CR>
nnoremap <Leader>o :CtrlPMRUFiles<CR>

" CtrlP-based header switching (https://github.com/kien/ctrlp.vim/issues/412)
function! SwitchHeader(...)
  let g:ctrlp_default_input = expand('%:t:r')
  call ctrlp#init(0)
  "call feedkeys(":CtrlP .\<CR>", "t")
  "call feedkeys(expand('%:t:r'), "t")
  let l:split = get(a:, 1, "i")
  if l:split == 'h'
    call feedkeys("\<C-s>", "t")
  elseif l:split == 'v'
    call feedkeys("\<C-v>", "t")
  else
    call feedkeys("\<CR>", "t")
  endif
  unlet g:ctrlp_default_input
endfunction

" Yoink mappings
nmap <c-n> <plug>(YoinkPostPasteSwapBack)
nmap <c-p> <plug>(YoinkPostPasteSwapForward)
nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

" Search visual selection
" (from http://zzapper.co.uk/vimtips.html)
vmap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
