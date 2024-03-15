return {
	"tpope/vim-fugitive",
	config = function(_, _)
		vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { desc = "[G]it [S]tatus" })

		vim.keymap.set("n", "<leader>gp", function()
			vim.cmd.Git({ "push" })
		end, { remap = false, desc = "[G]it [P]ush " })

		--for some reason the maps dont load without this print...
		vim.keymap.set("n", "<leader>gp", function()
			vim.cmd.Git({ "push" })
		end, { remap = false, desc = "[G]it [P]ush " })

		-- rebase always
		vim.keymap.set("n", "<leader>gP", function()
			vim.cmd.Git({ "pull", "--rebase" })
		end, { remap = false, desc = "[G]it [P]ull " })

		-- NOTE: It allows me to easily set the branch i am pushing and any tracking
		-- needed if i did not set the branch up correctly

		vim.keymap.set("n", "<leader>gt", ":Git push -u origin", { remap = false, desc = "[G]it [T]rack and push" })
	end,
}
