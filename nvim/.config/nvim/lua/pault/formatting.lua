local mason_nullls = require("mason-null-ls")

-- setup formatters with null-ls
mason_nullls.setup({
	ensure_installed = { "stylua", "jq", "black", "isort", "clang_format", "gofumpt" },
	automatic_setup = true,
})

mason_nullls.setup_handlers({})

-- format with null-ls on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
require("null-ls").setup({
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(subClient)
							return subClient.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
})
