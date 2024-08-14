return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"antoinemadec/FixCursorHold.nvim",
		"nvim-treesitter/nvim-treesitter",
		"Issafalcon/neotest-dotnet",
	},
	config = function()
		require("neotest").setup({
			adapters = {
				require("neotest-dotnet"),
			},
		})

		vim.keymap.set("n", "<leader>tr", "<cmd>Neotest run<CR>", { desc = "Run tests" })
		vim.keymap.set("n", "<leader>tsp", "<cmd>Neotest output-panel<CR>", { desc = "Show test output panel" })
		vim.keymap.set("n", "<leader>tso", "<cmd>Neotest output<CR>", { desc = "Show test output" })
		vim.keymap.set("n", "<leader>tss", "<cmd>Neotest summary<CR>", { desc = "Show test summary" })
	end,
}
