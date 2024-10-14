return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ -- If encountering errors, see telescope-fzf-native README for install instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
	},
	keys = {
		{ "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git files" },
		--		{ "<leader>fe", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		--		{ "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
		--		{ "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
		--		{ "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
		--		{ "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help tags" },
		--		{ "<leader>fr", "<cmd>Telescope find_recent<cr>", desc = "Find Recent" },
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
	config = function()
		require("telescope").setup({
			extensions = {
				["ui-select"] = {
					require("telescope.themes").get_dropdown(),
				},
			},
		})
		-- Enable telescope extensions, if they are installed
		pcall(require("telescope").load_extension, "fzf")
		pcall(require("telescope").load_extension, "ui-select")

		-- See `:help telescope.builtin`
		local builtin = require("telescope.builtin")

		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
		vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "[S]earch [J]ump list" })
		vim.keymap.set("n", "<leader><leader>", builtin.buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Git files" })

		-- Slightly advanced example of overriding default behavior and theme
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer" })
		-- Also possible to pass additional configuration options.
		--  See `:help telescope.builtin.live_grep()` for information about particular keys
		vim.keymap.set("n", "<leader>s/", function()
			builtin.live_grep({
				grep_open_files = true,
				prompt_title = "Live Grep in Open Files",
			})
		end, { desc = "[S]earch [/] in Open Files" })

		-- Shortcut for searching your neovim configuration files
		vim.keymap.set("n", "<leader>sn", function()
			builtin.find_files({ cwd = vim.fn.stdpath("config") })
		end, { desc = "[S]earch [N]eovim files" })
	end,
}
