local null_ls = require("null-ls")
local null_ls_h = require("null-ls.helpers")

-- require("lspconfig").tsserver.setup({
--     capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities()),
--     on_attach = function(client)
--         client.server_capabilities.document_formatting = false
--     end,
-- })

-- -- local format = function(payload)
-- --     vim.lsp.buf.format({
-- --         filter = function(client)
-- --             return client.name ~= "tsserver"
-- --         end,
-- --     })
-- -- end

require("null-ls").setup({
	sources = {
		require("null-ls").builtins.formatting.stylua,
		require("null-ls").builtins.diagnostics.eslint_d,
		require("null-ls").builtins.completion.spell,
		require("null-ls").builtins.code_actions.eslint_d,
		null_ls.builtins.formatting.prettierd,
	},
})

