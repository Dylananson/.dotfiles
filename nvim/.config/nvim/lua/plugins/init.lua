return {
	"tpope/vim-sleuth",
	-- TJ created lodash of neovim
	"nvim-lua/plenary.nvim",
	"nvim-lua/popup.nvim",
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	priority = 1000,
	-- 	config = true,
	-- 	opts = function()
	-- 		require("gruvbox").setup({
	-- 			contrast = "hard",
	-- 			overrides = {
	-- 				SignColumn = { bg = "" },
	-- 			},
	-- 		})
	-- 		vim.cmd([[colorscheme gruvbox]])
	-- 	end,
	-- },
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
			--
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
