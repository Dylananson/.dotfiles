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
		lazy = false,
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
		keys = {
			{ "<leader>fm", "<cmd>lua vim.lsp.buf.format()<CR>", desc = "Format" },
		},
		opts = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			local lsp = require("lsp-zero")
			vim.lsp.buf.format({ timeout_ms = 2000 })
			lsp.extend_cmp()

			require("lspconfig").tsserver.setup({
				on_attach = function(client, bufnr)
					lsp.default_keymaps({ buffer = bufnr })
				end,
			})

			lsp.preset("recommended")

			lsp.ensure_installed({
				"tsserver",
				"eslint",
				"pyright",
				"rust_analyzer",
			})

			local cmp = require("cmp")
			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			local cmp_mappings = lsp.defaults.cmp_mappings({
				["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
				["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
				["<C-y>"] = cmp.mapping.confirm({ select = true }),
				["<C-Space>"] = cmp.mapping.complete(),
			})

			lsp.set_preferences({
				sign_icons = {},
			})

			lsp.setup_nvim_cmp({
				mapping = cmp_mappings,
			})

			require("lspconfig").eslint.setup({
				settings = {
					packageManager = "npm",
				},
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})

			-- require("lspconfig").tsserver.setup({
			-- 	capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
			-- 	on_attach = function(client)
			-- 		client.server_capabilities.document_formatting = false
			-- 	end,
			-- })

			local lsp_formatting = function(bufnr)
				vim.lsp.buf.format({
					filter = function(client)
						-- apply whatever logic you want (in this example, we'll only use null-ls)
						return client.name == "null-ls"
					end,
					bufnr = bufnr,
				})
			end

			lsp.on_attach(function(client, bufnr)
				local opts = { buffer = bufnr, remap = false }

				vim.keymap.set("n", "gd", function()
					-- vim.lsp.buf.definition()
					require("telescope.builtin").lsp_definitions()
				end, opts)
				vim.keymap.set("n", "K", function()
					vim.lsp.buf.hover()
				end, opts)
				vim.keymap.set("n", "<leader>vws", function()
					vim.lsp.buf.workspace_symbol()
				end, opts)
				vim.keymap.set("n", "<leader>vd", function()
					vim.diagnostic.open_float()
				end, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.goto_next()
				end, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.goto_prev()
				end, opts)
				vim.keymap.set("n", "<M-CR>", function()
					vim.lsp.buf.code_action()
				end, opts)
				vim.keymap.set("n", "<leader>vrr", function()
					vim.lsp.buf.references()
				end, opts)
				vim.keymap.set("n", "<leader>vrn", function()
					vim.lsp.buf.rename()
				end, opts)
				vim.keymap.set("i", "<C-h>", function()
					vim.lsp.buf.signature_help()
				end, opts)

				vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
				vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
				vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							lsp_formatting(bufnr)
						end,
					})
				end
			end)

			lsp.setup()
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
	{
		"MunifTanjim/prettier.nvim",
		opts = function()
			local prettier = require("prettier")

			prettier.setup({
				bin = "prettier", -- or `'prettierd'` (v0.23.3+)
				filetypes = {
					"css",
					"graphql",
					"html",
					"javascript",
					"javascriptreact",
					"json",
					"less",
					"markdown",
					"scss",
					"typescript",
					"typescriptreact",
					"yaml",
				},
			})
		end,
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
