-- Set up LSP keybindings when LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf

		local opts = { silent = true, buffer = bufnr }

		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<leader>n", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
		vim.keymap.set("n", "<C-c>", function() vim.diagnostic.jump({ count = -1 }) end, opts)
		vim.keymap.set("n", "<C-t>", function() vim.diagnostic.jump({ count = 1 }) end, opts)
	end,
})

-- Set up default capabilities for all LSP servers
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Configure diagnostic settings
vim.diagnostic.config({
	virtual_text = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "✘",
			[vim.diagnostic.severity.WARN] = "▲",
			[vim.diagnostic.severity.HINT] = "⚑",
			[vim.diagnostic.severity.INFO] = "»",
		},
	},
	update_in_insert = false,
	underline = true,
	severity_sort = true,
	float = {
		border = 'rounded',
		source = true,
	},
})

-- mason.nvim/lspconfig setup
require("mason").setup()
require("mason-lspconfig").setup({
	ensure_installed = {
		"pyright",
		"ts_ls",
		"clangd",
		"lua_ls",
		"intelephense",
	},
})

vim.lsp.config("intelephense", {
	capabilities = capabilities,
	settings = {
		intelephense = {
			environment = {
				shortOpenTag = true,
			},
		},
	},
})

-- nvim-lint setup
require('lint').linters_by_ft = {
	groovy = {'npm-groovy-lint'},
}
