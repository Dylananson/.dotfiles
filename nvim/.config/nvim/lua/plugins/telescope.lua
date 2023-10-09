return {
	"nvim-telescope/telescope.nvim",
	dependencies = { { "nvim-lua/plenary.nvim" } },
	cmd = "Telescope",
	keys = {
		{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git files" },
		{ "<leader>fe", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
		{ "<leader>fr", "<cmd>Telescope find_recent<cr>", desc = "Find Recent" },
	},
	opts = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				file_sorter = require("telescope.sorters").get_fzy_sorter,
				prompt_prefix = " >",
				color_devicons = true,

				file_previewer = require("telescope.previewers").vim_buffer_cat.new,
				grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
				qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,

				mappings = {
					i = {
						["<C-x>"] = false,
						["<C-q>"] = actions.send_to_qflist,
						["<CR>"] = actions.select_default,
					},
				},
			},
		})

		local M = {}

		function M.reload_modules()
			-- Because TJ gave it to me.  Makes me happpy.  Put it next to his other
			-- awesome things.
			local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
			for _, dir in ipairs(lua_dirs) do
				dir = string.gsub(dir, "./lua/", "")
				require("plenary.reload").reload_module(dir)
			end
		end

		M.search_dotfiles = function()
			require("telescope.builtin").find_files({
				prompt_title = "< VimRC >",
				cwd = vim.env.DOTFILES,
				hidden = true,
			})
		end

		return M
	end,
}
