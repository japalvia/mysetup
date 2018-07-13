" Declare nocompatible before loading any plugins
set nocompatible

" Leader key for prefixing custom commands
let mapleader=","

runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

set tabstop=4       " Number of spaces that a <Tab> in the file counts for.

set shiftwidth=4    " Number of spaces to use for each step of (auto)indent.

set expandtab       " Use the appropriate number of spaces to insert a <Tab>.

set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.
set autoindent
set smartindent
set cindent

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

" Don't insert comment automatically
set formatoptions-=cro

set t_Co=256
" more color related fixes, storing for future need:
" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm
" set background=light

filetype plugin indent on
syntax on

" Disable arrow keys
noremap <Left> <Nop>
noremap <Right> <Nop>
noremap <Up> <Nop>
noremap <Down> <Nop>

" Automatically removing all trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Use paste (insert) mode for pasting unformatted text
set pastetoggle=<F2>

" format and return the same line where you were
nnoremap <F7> mzgg=G`z<CR>

" Redraw with <leader>-l to remove search hits
:nnoremap <silent> <leader>l :nohls<cr><leader>l


colors zenburn
" Fallback colors in Linux subsystem for Windows (beta)
if !empty($VIM_LSW)
    colors default
    set background=dark
endif

" Show status line always
set laststatus=2

" Syntax highlight for SCons files
au BufNewFile,BufRead SCons* set filetype=scons

" Indent function parameters on opening parenthesis level
set cino+=(0

" disable attention message about existing swap file
set shortmess+=A

" Show current C function in status line
fun! ShowFuncName()
  let lnum = line(".")
  let col = col(".")
  echohl ModeMsg
  echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
  echohl None
  call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
nnoremap f :call ShowFuncName() <CR>

" Move focus to window without pressing 'w'
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

if has("cscope")
		set csprg=/usr/bin/cscope
		set csto=0
		set cst
		set nocsverb
		" add any database in current directory
		if filereadable("cscope.out")
			cs add cscope.out
		" else add database pointed to by environment
		elseif $CSCOPE_DB != ""
			cs add $CSCOPE_DB
		endif
		set csverb
endif

" scope bindings
"USAGE   :cs find {querytype} {name}
"
"	{querytype} corresponds to the actual cscope line
"	interface numbers as well as default nvi commands:
"
"		0 or s: Find this C symbol
"		1 or g: Find this definition
"		2 or d: Find functions called by this function
"		3 or c: Find functions calling this function
"		4 or t: Find this text string
"		6 or e: Find this egrep pattern
"		7 or f: Find this file
"		8 or i: Find files #including this file
"		9 or a: Find places where this symbol is assigned a value

nnoremap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-_>a :cs find a <C-R>=expand("<cword>")<CR><CR>

" Using 'CTRL-h' then a search type makes the vim window
" split horizontally, with search result displayed in
" the new window.

nnoremap <C-h>s :scs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h>g :scs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h>c :scs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h>t :scs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h>e :scs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h>f :scs find f <C-R>=expand("<cfile>")<CR><CR>
nnoremap <C-h>i :scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-h>d :scs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h>a :scs find a <C-R>=expand("<cword>")<CR><CR>

" Hitting CTRL-h *twice* before the search type does a vertical
" split instead of a horizontal one
" FIXME: why these are not working?
nnoremap <C-h><C-h>s
		\:vert scs find s <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h><C-h>g
		\:vert scs find g <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h><C-h>c
		\:vert scs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h><C-h>t
		\:vert scs find t <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h><C-h>e
		\:vert scs find e <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h><C-h>i
		\:vert scs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nnoremap <C-h><C-h>d
		\:vert scs find d <C-R>=expand("<cword>")<CR><CR>
nnoremap <C-h><C-h>a
		\:vert scs find a <C-R>=expand("<cword>")<CR><CR>

" space selects word under cursor and enter visual mode
" useful for copying the selected text to primary clipboard
map <space> viw

" FIXME: not working in Arch
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" http://vim.wikia.com/wiki/Keep_your_cursor_centered_vertically_on_the_screen
" Keep the cursor centered in view when possible
if exists("##WinNew")
    augroup VCenterCursor
      au!
      au BufEnter,WinEnter,WinNew,VimResized *,*.*
            \ let &scrolloff=winheight(win_getid())/2
    augroup END
endif

nnoremap <F12> <Plug>CscopeDBInit

" Pressing only Enter cancels, useful when you actually don't want to complete
" the word but to close the dialog.
let g:SuperTabCrMapping = 1

" Terminal sends NUL character when pressing ctrl-space
" reserve <tab> for literal tabs
" Backward mapping is default <s-tab>
let g:SuperTabMappingForward = '<NUL>'

" Black hole register to delete without yanking
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP
