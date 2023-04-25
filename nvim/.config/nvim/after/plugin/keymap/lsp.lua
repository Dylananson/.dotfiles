local nnoremap = require("danson.keymap").nnoremap

vim.lsp.buf.format({ timeout_ms = 2000 })

nnoremap("<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>")
nnoremap("<M-F>", "<cmd>lua vim.Neoformat<CR>")
