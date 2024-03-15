return {
	"tpope/vim-fugitive",
	config = function(_, _)
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

		local bufnr = vim.api.nvim_get_current_buf()
		local opts = { buffer = bufnr, remap = false }
		vim.keymap.set("n", "<leader>gp", function()
			vim.cmd.Git("push")
		end, opts, "[G]it [P]ush")

		-- rebase always
		vim.keymap.set("n", "<leader>gP", function()
			vim.cmd.Git({ "pull", "--rebase" })
		end, opts, "[G]it [P]ush")

		-- NOTE: It allows me to easily set the branch i am pushing and any tracking
		-- needed if i did not set the branch up correctly
		vim.keymap.set("n", "<leader>gt", ":Git push -u origin ", opts, "[G]it [T]rack and push")
	end,
}
