execute pathogen#infect()

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.

set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.

set expandtab       " Use the appropriate number of spaces to insert a <Tab>.

set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

" set number          " Show line numbers.

set ruler

set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.

set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.

set ignorecase      " Ignore case in search patterns.

set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.

set textwidth=79    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.

"set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode.
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)

set formatoptions-=cro
set t_Co=256
" more color related fixes, storing for future need:
" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm
" set background=light

filetype plugin indent on
syntax on

" Disable arrow keys
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" Automatically removing all trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Use paste (insert) mode for pasting unformatted text
set pastetoggle=<F2>

" format and return the same line where you were
map <F7> mzgg=G`z<CR>

" Redraw with ctrl-l to remove search hits
:noremap <silent> <c-l> :nohls<cr><c-l>

"map <ESC>[5D <C-Left>
"map <ESC>[5C <C-Right>
"map! <ESC>[5D <C-left>
"map! <ESC>[5C <C-Right>

" Don't insert comment automatically
set formatoptions-=cro

colors zenburn

" Show status line always
set laststatus=2

" Syntax highlight for SCons files
au BufNewFile,BufRead SCons* set filetype=scons

" Indent function parameters on opening parenthesis level
set cino+=(0

" disable attention message about existing swap file
set shortmess+=A

fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map f :call ShowFuncName() <CR>
