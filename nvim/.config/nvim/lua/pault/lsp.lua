local lsp = require('lsp-zero')

-- 'recommended' wasn't letting me setup nvim-cmp how I wanted (see completion.lua)
lsp.preset('lsp-compe')

lsp.ensure_installed({
    'pyright',
    'tsserver',
    'clangd',
    'gopls',
    'jdtls',
    'sumneko_lua'
})

lsp.nvim_workspace()
lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})
