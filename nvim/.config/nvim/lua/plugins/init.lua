return {
	--copilot
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		end,
	},
	"tpope/vim-sleuth",
	-- TJ created lodash of neovim
	"nvim-lua/plenary.nvim",
	"nvim-lua/popup.nvim",
	{
		"folke/tokyonight.nvim",
		opts = function()
			require("tokyonight").setup({
				style = "night",
				transparent = "true",
			})

			vim.g.tokyonight_transparent_sidebar = true
			vim.g.tokyonight_transparent = true
			vim.opt.background = "dark"

			vim.cmd([[colorscheme tokyonight]])
		end,
	},

	"mbbill/undotree",
	"ThePrimeagen/vim-be-good",
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	"glepnir/lspsaga.nvim",

	"folke/lsp-colors.nvim",

	"nvim-lua/lsp_extensions.nvim",

	"simrat39/symbols-outline.nvim",
	"pantharshit00/vim-prisma",
}
