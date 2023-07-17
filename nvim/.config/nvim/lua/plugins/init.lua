return {
	--copilot
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		end,
	},
	"airblade/vim-gitgutter",

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
		"VonHeikemen/lsp-zero.nvim",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" },
			{ "williamboman/mason.nvim" },
			{ "williamboman/mason-lspconfig.nvim" },

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" },
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-path" },
			{ "saadparwaiz1/cmp_luasnip" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-nvim-lua" },

			-- Snippets
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
		},
	},

	"neovim/nvim-lspconfig", -- Configurations for Nvim LSP
	"glepnir/lspsaga.nvim",
	"folke/lsp-colors.nvim",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"nvim-lua/lsp_extensions.nvim",
	"hrsh7th/nvim-cmp",
	"L3MON4D3/LuaSnip",
	"saadparwaiz1/cmp_luasnip",
	"simrat39/symbols-outline.nvim",

	"pantharshit00/vim-prisma",
	"nvim-treesitter/playground",
}
