return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- LSP Support
			{ "williamboman/mason.nvim", cmd = "Mason", build = ":MasonUpdate" },
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			{ "j-hui/fidget.nvim", opts = {} },
		},

		---@class PluginLspOpts
		opts = {
			---@type lspconfig.options
		},
		config = function(_, opts)
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("LspAttach", { clear = true }),
				callback = function(event)
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					--Keymaps
					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-T>.
					map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

					-- vim.keymap.set("n", "gi", vim.lsp.buf.implementation)

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace
					--  Similar to document symbols, except searches over your whole project.
					--
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

					map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
					vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ction" })

					map("K", vim.lsp.buf.hover, "Hover Documentation")

					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					vim.keymap.set("n", "gv", ":vsplit | lua vim.lsp.buf.definition()<CR>")
					vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help)
					--
					--vim.keymap.set("n", "<leader>fm", vim.lsp.buf.format)

					vim.cmd([[
					  autocmd BufRead,BufNewFile *.tfvars set filetype=terraform
					]])

					local client = vim.lsp.get_client_by_id(event.data.client_id)
					if client and client.server_capabilities.documentHighlightProvider then
						vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.document_highlight,
						})

						vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
							buffer = event.buf,
							callback = vim.lsp.buf.clear_references,
						})
					end
				end,
			})

			-- LSP servers and clients are able to communicate to each other what features they support.
			--  By default, Neovim doesn't support everything that is in the LSP Specification.
			--  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
			--  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

			local util = require("lspconfig").util

			local servers = {
				terraformls = {},
				csharp_ls = {},
				-- omnisharp = {
				-- 	root_dir = util.root_pattern("*.sln"),
				-- 	settings = {
				-- 		FormattingOptions = {
				-- 			-- Enables support for reading code style, naming convention and analyzer
				-- 			-- settings from .editorconfig.
				-- 			EnableEditorConfigSupport = nil,
				-- 			-- Specifies whether 'using' directives should be grouped and sorted during
				-- 			-- document formatting.
				-- 			OrganizeImports = nil,
				-- 		},
				-- 		MsBuild = {
				-- 			-- If true, MSBuild project system will only load projects for files that
				-- 			-- were opened in the editor. This setting is useful for big C# codebases
				-- 			-- and allows for faster initialization of code navigation features only
				-- 			-- for projects that are relevant to code that is being edited. With this
				-- 			-- setting enabled OmniSharp may load fewer projects and may thus display
				-- 			-- incomplete reference lists for symbols.
				-- 			LoadProjectsOnDemand = nil,
				-- 		},
				-- 		RoslynExtensionsOptions = {
				-- 			-- Enables support for roslyn analyzers, code fixes and rulesets.
				-- 			EnableAnalyzersSupport = nil,
				-- 			-- Enables support for showing unimported types and unimported extension
				-- 			-- methods in completion lists. When committed, the appropriate using
				-- 			-- directive will be added at the top of the current file. This option can
				-- 			-- have a negative impact on initial completion responsiveness,
				-- 			-- particularly for the first few completion sessions after opening a
				-- 			-- solution.
				-- 			EnableImportCompletion = true,
				-- 			-- Only run analyzers against open files when 'enableRoslynAnalyzers' is
				-- 			-- true
				-- 			AnalyzeOpenDocumentsOnly = nil,
				-- 		},
				-- 		Sdk = {
				-- 			-- Specifies whether to include preview versions of the .NET SDK when
				-- 			-- determining which version to use for project loading.
				-- 			IncludePrereleases = true,
				-- 		},
				-- 	},
				-- },
				pyright = {
					cmd = { "pyright-langserver", "--stdio" },
					filetypes = { "python" },
					root_dir = function(fname)
						local root_files = {
							"pyproject.toml",
							"setup.py",
							"setup.cfg",
							"requirements.txt",
							"Pipfile",
							"pyrightconfig.json",
						}
						return util.root_pattern(unpack(root_files))(fname)
							or util.find_git_ancestor(fname)
							or util.path.dirname(fname)
					end,
					settings = {
						python = {
							analysis = {
								autoSearchPaths = true,
								diagnosticMode = "workspace",
							},
						},
					},
				},
				tsserver = {
					settings = {
						typescript = {
							inlayHints = {
								includeInlayParameterNameHints = "literal",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = false,
								includeInlayVariableTypeHints = false,
								includeInlayPropertyDeclarationTypeHints = false,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
						javascript = {
							inlayHints = {
								includeInlayParameterNameHints = "all",
								includeInlayParameterNameHintsWhenArgumentMatchesName = false,
								includeInlayFunctionParameterTypeHints = true,
								includeInlayVariableTypeHints = true,
								includeInlayPropertyDeclarationTypeHints = true,
								includeInlayFunctionLikeReturnTypeHints = true,
								includeInlayEnumMemberValueHints = true,
							},
						},
					},
				},
				-- tailwindcss = {
				-- 	settings = {
				-- 		tailwindCSS = {
				-- 			experimental = {
				-- 				classRegex = {
				-- 					{ "cva\\(([^)]*)\\)", "[\"'`]([^\"'`]*).*?[\"'`]" },
				-- 				},
				-- 			},
				-- 		},
				-- 	},
				-- },
				clangd = {},
				gopls = {
					cmd = { "gopls" },
					filetypes = { "go", "gomod", "gowork", "gotmpl" },
					settings = {
						gopls = {
							completeUnimported = true,
							usePlaceholders = true,
							analyses = {
								unusedparams = true,
							},
						},
					},
				},
				-- rust_analyzer = {},
				lua_ls = {
					-- cmd = {...},
					-- filetypes { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							runtime = { version = "LuaJIT" },
							workspace = {
								checkThirdParty = false,
								-- Tells lua_ls where to find all the Lua files that you have loaded
								-- for your neovim configuration.
								library = {
									"${3rd}/luv/library",
									unpack(vim.api.nvim_get_runtime_file("", true)),
								},
								-- If lua_ls is really slow on your computer, you can try this instead:
								-- library = { vim.env.VIMRUNTIME },
							},
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
							diagnostics = { globals = { "vim" } },
						},
					},
				},
				marksman = {},
			}

			-- -- Ensure the servers and tools above are installed
			-- --  To check the current status of installed tools and/or manually install
			-- --  other tools, you can run
			-- --    :Mason
			-- --
			-- --  You can press `g?` for help in this menu
			require("mason").setup()

			--
			-- -- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			--
			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						-- This handles overriding only values explicitly passed
						-- by the server configuration above. Useful when disabling
						-- certain features of an LSP (for example, turning off formatting for tsserver)
						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})

			--
			vim.diagnostic.config({
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
				},
				severity_sort = true,
				float = {
					focusable = true,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "",
				},
			})
		end,
	},
	{ -- Autoformat
		"stevearc/conform.nvim",
		keys = {
			{
				-- Customize or remove this keymap to your liking
				"<leader>fm",
				function()
					require("conform").format({ async = true, lsp_fallback = true })
				end,
				mode = "",
				desc = "Format buffer",
			},
		},
		opts = {
			notify_on_error = false,
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
			formatters_by_ft = {
				lua = { "stylua" },
				-- Conform can also run multiple formatters sequentially
				python = { "isort", "black" },
				--
				-- You can use a sub-list to tell conform to run *until* a formatter
				-- is found.
				javascript = { { "eslint_d", "eslint", "prettierd", "prettier" } },
				typescript = { { "eslint_d", "esling", "prettierd", "prettier" } },
			},
		},
		config = function(_, opts)
			local conform = require("conform")
			local utils = require("conform.util")

			local formatters = {
				eslint_d = {
					meta = {
						url = "https://github.com/mantoni/eslint_d.js/",
						description = "Like ESLint, but faster.",
					},
					command = require("conform.util").from_node_modules("eslint_d"),
					args = { "--fix-to-stdout", "--stdin", "--stdin-filename", "$FILENAME" },
					cwd = require("conform.util").root_file({
						"package.json",
						".eslintrc.json",
						".prettierrc",
					}),
				},
			}

			local extended_opts = vim.tbl_deep_extend("force", opts, formatters)
			conform.setup(extended_opts)
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		-- version = false, -- last release is way too old
		event = "InsertEnter",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = (function()
					-- Build Step is needed for regex support in snippets
					-- This step is not supported in many windows environments
					-- Remove the below condition to re-enable on windows
					if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
						return
					end
					return "make install_jsregexp"
				end)(),
			},
			"saadparwaiz1/cmp_luasnip",

			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			-- "saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0
					and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			local luasnip = require("luasnip")
			local cmp = require("cmp")
			luasnip.config.set_config({})

			local compare = require("cmp.config.compare")

			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				completion = { completeopt = "menu,menuone,noinsert" },

				sources = cmp.config.sources({
					{ name = "nvim_lsp", priority = 1 },
					{ name = "luasnip", priority = 5, keyword_length = 2 },
					{ name = "path", priority = 2 },
				}),
				mapping = cmp.mapping.preset.insert({
					-- Select the [n]ext item
					["<C-n>"] = cmp.mapping.select_next_item(),
					-- Select the [p]revious item
					["<C-p>"] = cmp.mapping.select_prev_item(),

					-- Accept ([y]es) the completion.
					--  This will auto-import if your LSP supports it.
					--  This will expand snippets if the LSP sent a snippet.
					["<C-y>"] = cmp.mapping.confirm({ select = true }),
					-- Manually trigger a completion from nvim-cmp.
					--  Generally you don't need this, because nvim-cmp will display
					--  completions whenever it has completion options available.
					["<C-Space>"] = cmp.mapping.complete(),

					-- Think of <c-l> as moving to the right of your snippet expansion.
					--  So if you have a snippet that's like:
					--  function $name($args)
					--    $body
					--  end
					--
					-- <c-l> will move you to the right of each of the expansion locations.
					-- <c-h> is similar, except moving you backwards.
					["<C-l>"] = cmp.mapping(function()
						if luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function()
						if luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						end
					end, { "i", "s" }),
				}),
			})
		end,
	},
}
