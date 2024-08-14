vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true
vim.opt.guicursor = ""

vim.opt.nu = true

vim.opt.showmode = false

vim.opt.errorbells = false

vim.opt.termguicolors = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.smartindent = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.undodir = vim.fn.stdpath("config") .. "/undo"

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.cmdheight = 1

vim.netrw_keepdir = 0

vim.opt.colorcolumn = "80"

-- Turns off netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

vim.cmd [[
  autocmd BufRead,BufNewFile *.tfvars set filetype=terraform
]]
