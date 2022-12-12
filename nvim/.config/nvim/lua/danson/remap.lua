local nnoremap = require("danson.keymap").nnoremap

nnoremap("<leader>pv", "<cmd>Ex<CR>")

nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")
