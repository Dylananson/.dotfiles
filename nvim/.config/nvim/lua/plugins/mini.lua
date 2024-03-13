return {
	-- Comments
	"echasnovski/mini.comment",
	event = "VeryLazy",
	dependencies = {
		{ "JoosepAlviste/nvim-ts-context-commentstring", event = "VeryLazy", lazy = true },
	},
	opts = {
		hooks = {
			pre = function()
				require("ts_context_commentstring.internal").update_commentstring({})
			end,
		},
		mappings = {
			comment = "<C-_>",
			comment_line = "<C-_>",
			comment_visual = "<C-_>",
		},
	},
	config = function(_, opts)
		require("mini.comment").setup(opts)
	end,
}
