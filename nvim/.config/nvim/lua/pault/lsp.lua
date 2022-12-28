local lsp = require("lsp-zero")
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
