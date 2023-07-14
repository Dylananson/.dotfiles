return {
	"wbthomason/packer.nvim",

	--copilot
	"github/copilot.vim",
	"airblade/vim-gitgutter",

	{
		"ThePrimeagen/refactoring.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},

	-- TJ created lodash of neovim
	"nvim-lua/plenary.nvim",
	"nvim-lua/popup.nvim",

	"folke/tokyonight.nvim",

	"tpope/vim-fugitive",
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

	{
		"nvim-telescope/telescope.nvim",
		dependencies = { { "nvim-lua/plenary.nvim" } },
	},

	"pantharshit00/vim-prisma",

	"numToStr/Comment.nvim",

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
	},

	"JoosepAlviste/nvim-ts-context-commentstring",

	"nvim-treesitter/playground",
	"romgrk/nvim-treesitter-context",

	{
		"jose-elias-alvarez/null-ls.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	},

	"MunifTanjim/eslint.nvim",
}
