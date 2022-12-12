local nnoremap = require("danson.keymap").nnoremap

nnoremap("<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>")
