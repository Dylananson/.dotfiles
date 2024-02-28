local nnoremap = require("danson.keymap").nnoremap

nnoremap("<leader>pv", "<cmd>Ex<CR>")

nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader><C-n>", "<cmd>silent !tmux neww tmux-sessionator ~/code/notes<CR>")
vim.keymap.set("n", "<leader>D", "<cmd>silent !tmux neww tmux-sessionator ~/.dotfiles<CR>")

