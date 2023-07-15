return {

	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-treesitter/nvim-treesitter" },
	},
	keys = {
		{
			"<leader>rr",
			":lua require('refactoring').select_refactor()<CR>",
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

		-- prompt for a refactor to apply when the remap is triggered
	end,
}
