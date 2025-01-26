require("danson.set")
require("danson.remap")

vim.api.nvim_create_augroup("diag", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter" }, {
    group = "diag",
	callback = function()
		vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR, open = false })
	end,
})
