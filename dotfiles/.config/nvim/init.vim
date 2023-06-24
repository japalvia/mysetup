set nocompatible            " declare nocompatible before loading any plugins

call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-scripts/Zenburn'
Plug 'jremmen/vim-ripgrep'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-sensible'
Plug 'fidian/hexmode'
Plug 'peterhoeg/vim-qml'
Plug 'fedorenchik/qt-support.vim'
Plug 'tpope/vim-dispatch'
Plug 'https://git.sr.ht/~ackyshake/VimCompletesMe.vim'
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'pwd && set -x && cd app && yarn install' }
Plug 'dkarter/bullets.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'AndrewRadev/linediff.vim'

" LSP
Plug 'williamboman/mason.nvim',  { 'do': ':MasonUpdate' }
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'

call plug#end()             " Initialize plugin system

" Load lua/lsp.lua
lua require('lsp')

colors zenburn

let mapleader=","

""" Options """

" Disable all mouse actions
set mouse=

" number of columns occupied by a tab
set tabstop=4

" see multiple spaces as tabstops so <BS> does the right thing
set softtabstop=4

" converts tabs to white space
set expandtab

" width for autoindents
set shiftwidth=4

" indent a new line the same amount as the line just typed
set autoindent

" indent long lines when inserting
set breakindent

" highlight cursor line
set cursorline

" wrap longer text on white space
set textwidth=79

" show matches while typing pattern
set incsearch

" ignore case in search pattern
set ignorecase

" override ignorecase option when pattern contains upper case characters
set smartcase

" do no insert comment leaders automatically
set formatoptions-=cro

" Indent function parameters on opening parenthesis level
set cino+=(0

" Long lines are indented to the beginning of the line
set breakindent

" Highlight cursor line
set cursorline

" Allow switching out of buffer without saving file
set hidden

" Spell check added words
set spellfile=~/.vim/spell/en.utf-8.add

" Allow block cursor to move outside text on current line
set virtualedit+=block

" Use paste (insert) mode for pasting unformatted text
set pastetoggle=<F2>

" Disable cursor highlight on matching parent
au VimEnter * execute "NoMatchParen"

""" Key mapping """

" Switch to the most recent buffer
noremap <F4> :b#<CR>

" unwrap paragraph under cursor
noremap <F6> vipJ

" format and return the same line where you were
nnoremap <F7> mzgg=G`z<CR>

" Source config and install plugins
nnoremap <silent><leader>1 :source ~/.config/nvim/init.vim \| :PlugInstall<CR>

" Fzf open buffers
nnoremap <silent><leader>l :Buffers<CR>

" fzf on git-tracked files
nnoremap <C-p> :GFiles<Cr>

" Disable arrow key navigation
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Move focus to window without pressing 'w'
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
" FIXME: moving to right conflicts with clearing search highlights
" nnoremap <C-l> <C-w>l

" Black hole register to delete without yanking
nnoremap <leader>d "_d
xnoremap <leader>d "_d
xnoremap <leader>p "_dP

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

""" Autocommand """

" Keep the cursor centered in view when possible
if exists("##WinNew")
    augroup VCenterCursor
      au!
      au BufEnter,WinEnter,WinNew,VimResized *,*.*
            \ let &scrolloff=winheight(win_getid())/2
    augroup END
endif

" Always start on first line of git commit message
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])

" remove trailing whitespaces on buffer save
autocmd BufWritePre * :%s/\s\+$//e

" Column width for various known file types
autocmd FileType gitcommit set textwidth=72
autocmd FileType gitcommit set colorcolumn=73

" Other file types detected by file name
autocmd bufreadpre *.patch setlocal textwidth=79

" JSON formatting
autocmd Filetype json setlocal ts=2 sw=2

" Markdown settings
let g:mkdp_browser = 'google-chrome-stable'
