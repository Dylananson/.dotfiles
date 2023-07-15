return {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local null_ls_h = require("null-ls.helpers")

		require("null-ls").setup({
			sources = {
				require("null-ls").builtins.formatting.stylua,
				require("null-ls").builtins.diagnostics.eslint_d,
				require("null-ls").builtins.completion.spell,
				require("null-ls").builtins.code_actions.eslint_d,
				null_ls.builtins.formatting.prettierd,
			},
		})
	end,
}
