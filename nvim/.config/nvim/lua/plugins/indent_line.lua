return {
	{ -- Add indentation guides even on blank lines
		"lukas-reineke/indent-blankline.nvim",
		-- Enable `lukas-reineke/indent-blankline.nvim`
		-- See `:help ibl`
		main = "ibl",
		opts = {},
		config = function()
			require("ibl").setup({
				indent = {
					char = "▏", -- This is a slightly thinner char than the default one, check :help ibl.config.indent.char
				},
				scope = {
					show_start = false,
					show_end = false,
				},
			})

			local hooks = require("ibl.hooks")
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)
			hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_tab_indent_level)
		end,
	},
}
