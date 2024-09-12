return {

	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-treesitter/nvim-treesitter" },
		{ "nvim-telescope/telescope.nvim" },
	},
	keys = {
		{
			"<leader>rr",
			function() require('telescope').extensions.refactoring.refactors() end,
			mode = "v",
			{ noremap = true, silent = true, expr = false },
			desc = "Select refactoring",
		},
		-- Remaps for the refactoring operations currently offered by the plugin
		{
			"<leader>re",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>]],
			mode = "v",
			{ noremap = true, silent = true, expr = false },
			desc = "Select refactoring",
		},
		{
			"<leader>rf",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>]],
			mode = "v",
			{ noremap = true, silent = true, expr = false },
			desc = "Extract function to file",
		},
		{
			"<leader>rv",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>]],
			mode = "v",
			{ noremap = true, silent = true, expr = false },
			desc = "Extract variable",
		},
		{
			"<leader>ri",
			[[ <Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
			mode = "v",
			{ noremap = true, silent = true, expr = false },
			desc = "Inline variable",
		},

		-- Extract block doesn't need visual mode
		{
			"<leader>rb",
			[[ <Cmd>lua require('refactoring').refactor('Extract Block')<CR>]],
			{ noremap = true, silent = true, expr = false },
			desc = "Extract block",
		},
		{
			"<leader>rbf",
			[[ <Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>]],
			{ noremap = true, silent = true, expr = false },
			desc = "Extract block to file",
		},

		-- Inline variable can also pick up the identifier currently under the cursor without visual mode
		{
			"<leader>ri",
			[[ <Cmd>lua require('refactoring').refactor('Inline Variable')<CR>]],
			{ noremap = true, silent = true, expr = false },
			desc = "Inline variable",
		},
	},
	config = function()
		require("refactoring").setup({})

		vim.keymap.set("x", "<leader>re", ":Refactor extract ")
		vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")

		vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")

		vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var")

		vim.keymap.set("n", "<leader>rI", ":Refactor inline_func")

		vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
		vim.keymap.set("n", "<leader>rbf", ":Refactor extract_block_to_file")

		-- load refactoring Telescope extension
		require("telescope").load_extension("refactoring")

		vim.keymap.set(
			{ "n", "x" },
			"<leader>rr",
			function() require('telescope').extensions.refactoring.refactors() end
		)


		-- prompt for a refactor to apply when the remap is triggered
	end,
}
