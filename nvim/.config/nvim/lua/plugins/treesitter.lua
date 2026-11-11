return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local languages = {
			"bash",
			"c",
			"go",
			"html",
			"lua",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
		}

		local ok, ts = pcall(require, "nvim-treesitter")
		if ok and ts.setup then
			ts.setup({})
			if type(ts.install) == "function" then
				ts.install(languages)
			end

			local group = vim.api.nvim_create_augroup("danson-treesitter", { clear = true })
			vim.api.nvim_create_autocmd("FileType", {
				group = group,
				pattern = { "c", "go", "html", "lua", "markdown", "query", "sh", "vim" },
				callback = function(args)
					pcall(vim.treesitter.start, args.buf)
					vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end,
			})
			return
		end

		---@diagnostic disable-next-line: missing-fields
		require("nvim-treesitter.configs").setup({
			ensure_installed = languages,
			auto_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
