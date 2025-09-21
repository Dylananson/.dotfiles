local nnoremap = require("danson.keymap").nnoremap

-- nnoremap("<leader>pv", "<cmd>Ex<CR>")
nnoremap("<leader>pv", "<cmd>edit .<CR>")

nnoremap("J", "mzJ`z")
nnoremap("<C-d>", "<C-d>zz")
nnoremap("<C-u>", "<C-u>zz")
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader><C-n>", "<cmd>silent !tmux neww tmux-sessionator ~/code/notes<CR>")
vim.keymap.set("n", "<leader>D", "<cmd>silent !tmux neww tmux-sessionator ~/.dotfiles<CR>")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })


vim.keymap.set({"n","v","x"}, "<leader>y", "\"*y")
vim.keymap.set({"n","v","x"}, "<leader>d", "\"*d")

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})


--local terminal = require("config.util")
-- Key mappings
--vim.keymap.set("n", "<leader>t", terminal.FloatingTerminal, { noremap = true, silent = true, desc = "Toggle floating terminal" })
--vim.keymap.set("t", "<Esc>", function()
 -- if terminal.terminal_state.is_open then
  --  vim.api.nvim_win_close(terminal.terminal_state.win, false)
   -- terminal.terminal_state.is_open = false
  --end
--end, { noremap = true, silent = true, desc = "Close floating terminal from terminal mode" })
--
vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>")




