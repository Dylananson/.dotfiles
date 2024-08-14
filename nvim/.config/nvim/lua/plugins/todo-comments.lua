return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	opts = {
		-- your configuration comes here
		-- or leave it empty to use the default settings
		-- refer to the configuration section below
		--
	},
	config = function()
		-- setup your plugin here
		-- this will be executed on `nvim cmd` + `PackerCompile`
		require("todo-comments").setup()

		vim.keymap.set("n", "]t", function()
			require("todo-comments").jump_next()
		end, { desc = "Next todo comment" })

		vim.keymap.set("n", "[t", function()
			require("todo-comments").jump_prev()
		end, { desc = "Previous todo comment" })

		-- You can also specify a list of valid jump keywords

		vim.keymap.set("n", "]t", function()
			require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
		end, { desc = "Next error/warning todo comment" })

		vim.keymap.set("n", "<leader>std", function()
			vim.cmd("TodoTelescope")
		end, { desc = "Toggle todo comment" })
	end,
}
