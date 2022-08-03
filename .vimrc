set shell=/bin/bash

" try to use pathogen
silent! call pathogen#infect()

"Use Vim defaults
set nocompatible

syntax enable

let g:syntastic_ocaml_camlp4r = 1

filetype off
" enables filetype detection
filetype on
" enable filetype specific plugins
filetype plugin on
filetype indent on

" Put swap files in .tmp
set backupdir=~/.tmp
set directory=~/.tmp

" Allow hidden buffer
set hidden 

set backspace=indent,eol,start  " backspace through everything in insert mode


augroup markdown
    " turn-on distraction free writing mode for markdown files
    autocmd BufNewFile,BufRead *.{md,mdown,mkd,mkdn,markdown,mdwn} call DistractionFreeWriting()
augroup END

augroup insertmode
    " Display unprintable characters with '^' and put $ after the line.
    autocmd InsertEnter * set list
    autocmd InsertLeave * set nolist
augroup END

augroup comments
    autocmd FileType haskell nnoremap <buffer> <localleader>c I//
    autocmd FileType javascript nnoremap <buffer> <localleader>c I--
    autocmd FileType python     nnoremap <buffer> <localleader>c I#
augroup END

augroup wrap
    " turn-on distraction free writing mode for markdown files
    autocmd BufNewFile,BufRead *.txt set wrap
augroup END
" Config for polling apps
set nobackup " Do not make a backup before overwriting a file
set nowritebackup " Do not make a backup before overwriting a file
set noswapfile " Don't create swapfiles
" Functions
"====================================
"
" Functions can be called via `:call myfunc()`.

function! DistractionFreeWriting()
    set wrap " make long lines wrap around to the next line
    set linebreak " break the lines on words rather than arbitrary characters
    set nolist " don't show list
    set noruler " don't show ruler
    " set nonumber " don't show line number
    set laststatus=0 " don't show status line
endfunction

" Correct indentation in a file
function! Indent()
    " Go to start of file
    normal gg
    " Indent (takes a motion)
    normal =
    " To end of file
    normal G
endfunction

" Strip trailing whitespace
function! Strip()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfunction

" Configure vim for polling apps
function! Poll()
    " Do not make a backup before overwriting a file
    set nobackup
    " Do not make a backup before overwriting a file
    set nowritebackup
    " Don't create swapfiles
    set noswapfile
endfunction

"Use TAB to complete when typing words, else inserts TABs as usual.
"Uses dictionary and source files to find matching words to complete.

"See help completion for source,
"Note: usual completion is on <C-n> but more trouble to press all the time.
"Never type the same word twice and maybe learn a new spellings!
"Use the Linux dictionary when spelling is in doubt.
"Window users can copy the file to their machine.
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
set dictionary="/usr/dict/words"


" Graphical interface options
"""""""""""""""""""""""""""""

" Enable the use of the mouse. Only works for certain terminals.
" The mouse can be enabled for different modes:
"   n   Normal mode
"   v   Visual mode
"   i   Insert mode
"   c   Command-line mode
"   a   All four modes modes
set mouse=a

" use colors which look good on a light background
set background=light

" Try to use solarized
silent! colorscheme solarized
if exists("g:colors_name") &&  g:colors_name  ==? "solarized"
    let g:solarized_contrast="high"
endif

" Automatically wrap around at the 80 character limit.
"
" Maximum width of text that is being inserted. A longer line will be broken
" after white space to get this width. A zero value disables this. 'textwidth'
" is set to 0 when the paste option is set.
set textwidth=0

" When on, lines longer than the width of the window will wrap and displaying
" continues on the next line. When off, lines will not wrap and only part of
" long lines will be displayed. When the cursor is moved to a part that is not
" shown, the screen will scroll horizontally.
set nowrap

" Number of columns on the screen. Normally this is set by the terminal
" initialization and does not have to be set by hand.
"set columns=80

" Precede each line with its line number.
set number

" Show the line number relative to the line with the cursor in front of each
" line.
"set relativenumber

" Show the line and column number of the cursor position, separated by a
" comma.
set ruler

" Show partial commands in the last line of the screen
set showcmd

" Minimal number of screen lines to keep above and below the cursor.
set scrolloff=5

"split settings so they are not stupid like defaults
set splitbelow splitright

" Indentation
"====================================

" Number of spaces that a <Tab> in the file counts for.
" > This affects how existing text displays.
set tabstop=4

" Number of spaces that a <Tab> counts for while performing editing
" operations, like inserting a <Tab> or using <BS>.
set softtabstop=4

" In Insert mode: Use the appropriate number of spaces to insert a <Tab>.
" To insert a real tab when 'expandtab' is on, use CTRL-V<Tab>.
" When true, inserts 'softtabstop' spaces instead of a tab on <TAB>
set expandtab

" Number of spaces to use for each step of (auto)indent. Used for
" `cindent`, `>>`, `<<`, etc.
set shiftwidth=4

" The kind of folding used for the current window.
" - indent - Lines with equal indent form a fold.
" set foldmethod=indent

" Changes how <TAB> is interpreted depending on where the cursor is.
" If true, pressing <TAB> inserts indentation according to 'shiftwidth'
" at the beginning of a line, whereas 'tabstop' and 'softtabstop' are
" used everywhere else.
set smarttab

" Copy indent from current line when starting a new line.
set autoindent

" Copy the structure of the existing lines indent when autoindenting a new
" line.
set copyindent

" Automatically indent when it makes sense
" Do smart autoindenting when starting a new line.
" Works for C-like programs, but can also be used for other languages.
" An indent is automatically insert:
" - After a line ending in '{'.
" - After a line starting with a keyword from 'cinwords'.
" - Before a line starting with '}'
set smartindent

" Mappings
"====================================

let mapleader = ","
" let maplocalleader = "\\"

inoremap jk <esc>
" This is commeneted because ', ' is frequently typed!
" inoremap <leader><space> <esc>

" nnoremap <leader>ev :split $MYVIMRC<cr>
" nnoremap <leader>sv :source $MYVIMRC<cr>

" Surrounds
nnoremap <leader>' viw<esc>a'<esc>hbi'<esc>lel
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel
nnoremap <leader>( viw<esc>a)<esc>hbi(<esc>lel
nnoremap <leader>) viw<esc>a)<esc>hbi(<esc>lel

" Convenience
nnoremap H ^
nnoremap L $

" Training
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>


" When there is a previous search pattern, highlight all its matches.
set hlsearch

" While typing a search command, show where the pattern, as it was typed so
" far, matches. The matched string is highlighted.
set incsearch

" While searching, the case of normal letters is ignored.
set ignorecase

" Adjust case of match based on typed text
set infercase

" Ignore case when the patterns contains lowercase letters only.
set smartcase

" Spelling
" ========
"
" This section implements commands to aid spelling.
"
" Tips:
"
" - Words can be added to the dictionary via ``zg`` and removed via ``zw``.

" enable spell-check
set spell spelllang=en_us

set dictionary="/usr/share/dict/words"

abbreviate w/ with
abbreviate betw between
abbreviate teh the
abbreviate thier their
nnoremap <leader>dt :put=strftime('%Y-%m-%d')<CR>

" Fix misspelled words
inoremap <leader>= <esc>[s1z=`]a
" On by default, turn it off for html and rst
let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': ['html', 'rst'] }

" Better :sign interface symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '!'

autocmd Filetype javascript setlocal ts=2 sts=2 sw=2
autocmd Filetype cpp setlocal ts=2 sts=2 sw=2
autocmd Filetype python set cursorcolumn


" Plugins
" "install vimplug
"Should work on not using plugins to  be honest



if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

Plug 'chikamichi/mediawiki.vim'

Plug 'https://github.com/nathanaelkane/vim-indent-guides'

Plug 'scrooloose/nerdtree'

Plug 'https://github.com/hashivim/vim-terraform.git'

Plug 'https://github.com/tweekmonster/django-plus.vim'

Plug 'https://github.com/pangloss/vim-javascript'

call plug#end()
