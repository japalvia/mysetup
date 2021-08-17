set nocompatible            " declare nocompatible before loading any plugins

call plug#begin(stdpath('data') . '/plugged')

Plug 'vim-scripts/Zenburn'
Plug 'jremmen/vim-ripgrep'
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf'

call plug#end()             " Initialize plugin system

colors zenburn

let mapleader=","

set tabstop=4               " number of columns occupied by a tab
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set breakindent             " indent long lines when inserting

set hidden                  " switch buffer without promting to save

set cursorline              " highlight cursor line
set textwidth=79            " wrap longer text on white space

set incsearch               " show matches while typing pattern
set ignorecase              " ignore case in search pattern
set smartcase               " override ignorecase option when pattern contains upper case characters

set formatoptions-=cro      " do no insert comment leaders automatically

autocmd BufWritePre * :%s/\s\+$//e " remove trailing whitespaces on buffer save
