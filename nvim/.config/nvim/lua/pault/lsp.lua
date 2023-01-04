local lsp = require("lsp-zero")
local nmap = require("pault.utils").normalMap

-- 'recommended' wasn't letting me setup nvim-cmp how I wanted (see completion.lua)
lsp.preset("lsp-compe")

lsp.set_preferences({
	set_lsp_keymaps = false,
})

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

-- choose my own keymaps
lsp.on_attach(function(client, bufnr)
	local opts = { silent = true, buffer = bufnr }

	nmap("K", vim.lsp.buf.hover, opts)
	nmap("gd", vim.lsp.buf.definition, opts)
	nmap("gD", vim.lsp.buf.declaration, opts)
	nmap("gi", vim.lsp.buf.implementation, opts)
	nmap("go", vim.lsp.buf.type_definition, opts)
	nmap("gr", vim.lsp.buf.references, opts)
	nmap("<leader>n", vim.lsp.buf.rename, opts)
	nmap("<leader>a", vim.lsp.buf.code_action, opts)
	nmap("gl", vim.diagnostic.open_float, opts)
	nmap("<C-p>", vim.diagnostic.goto_prev, opts)
	nmap("<C-n>", vim.diagnostic.goto_next, opts)
end)

lsp.nvim_workspace()
lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
