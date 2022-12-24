local lsp = require("lsp-zero")
local mason_nullls = require("mason-null-ls")
local nmap = require("pault.utils").normalmap

-- 'recommended' wasn't letting me setup nvim-cmp how I wanted (see completion.lua)
lsp.preset("lsp-compe")

lsp.ensure_installed({
	"pyright",
	"tsserver",
	"clangd",
	"gopls",
	"jdtls",
	"sumneko_lua",
})

-- silence weird warning about multiple offset_encodings due to clangd + null-ls
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.offsetEncoding = "utf-8"
lsp.configure("clangd", {
	capabilities = capabilities,
})

lsp.nvim_workspace()
lsp.setup()

-- override some lsp-zero keymaps
nmap("<leader>a", vim.lsp.buf.code_action)
nmap("<leader>n", vim.lsp.buf.rename)

vim.diagnostic.config({
	virtual_text = true,
})

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
