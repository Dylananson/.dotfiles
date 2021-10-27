set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set relativenumber
set number
set hidden
set noerrorbells
set nowrap
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set incsearch
set scrolloff=8
set colorcolumn=80
set signcolumn=yes

call plug#begin('~/.vim/plugged')
Plug 'gruvbox-community/gruvbox'
Plug 'nvim-telescope/telescope.nvim'
call plug#end()

colorscheme gruvbox
highlight Normal ctermbg=NONE guibg=NONE 
highlight NonText ctermbg=NONE guibg=NONE

