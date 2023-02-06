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

-- don't let lsp-zero configure jdtls, leave that to nvim-jdtls
lsp.skip_server_setup("jdtls")

local function onAttach(client, bufnr)
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
	nmap("<C-c>", vim.diagnostic.goto_prev, opts)
	nmap("<C-t>", vim.diagnostic.goto_next, opts)
end

-- choose my own keymaps
lsp.on_attach(onAttach)

lsp.nvim_workspace()
lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})

-- start jdtls with nvim-jdtls
local javaGroup = vim.api.nvim_create_augroup("JavaGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		local jdtlsConfig = {
			cmd = {
				vim.fn.expand("$HOME/.local/share/nvim/mason/bin/jdtls"),
				"-data", -- didn't have to specify this before but for some reason this is necessary now?
				vim.fn.expand("$HOME/.cache/jdtls/workspace"),
			},
			root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
			on_attach = onAttach,
			init_options = {
				bundles = {
					vim.fn.glob(
						"~/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
						1
					),
				},
			},
		}
		require("jdtls").start_or_attach(jdtlsConfig)
	end,
	group = javaGroup,
	pattern = "java",
})
