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
				on_highlights = function(hl, c)
					hl.LineNr = { fg = "#a7bed5" }
					hl.LineNrAbove = { fg = "#608ab2" }
					hl.LineNrBelow = { fg = "#608ab2" }
				end,
			})

			-- vim.g.tokyonight_transparent_sidebar = true
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
		cmd = "Trouble",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			auto_preview = false,
		},
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	"glepnir/lspsaga.nvim",

	"folke/lsp-colors.nvim",

	"nvim-lua/lsp_extensions.nvim",

	"simrat39/symbols-outline.nvim",
	"pantharshit00/vim-prisma",
}
