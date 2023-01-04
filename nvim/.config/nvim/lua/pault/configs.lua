local nmap = require("pault.utils").normalMap
local toggle = require("pault.utils").toggleWindow

-- tokyonight configuration
vim.cmd([[colorscheme tokyonight-night]])

-- vim-tmux-navigator configuration
-- Write all buffers before navigating from Vim to tmux pane
vim.g.tmux_navigator_save_on_switch = 2

-- vim-maximizer configuration
nmap("<leader>mt", ":MaximizerToggle!<CR>")

-- vim-fugitive configuration
nmap("<leader>gs", function()
	toggle("fugitive", "Git")
end)
nmap("<leader>gl", function()
	toggle("git", "Git log")
end)
nmap("<leader>gp", ":Git push<CR>")
-- use these remaps when running Gvdiffsplit!
nmap("<leader>gu", ":diffget //2<CR>")
nmap("<leader>gh", ":diffget //3<CR>")

-- vimwiki configuration
local vimwikiGroup = vim.api.nvim_create_augroup("VimwikiGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		nmap("j", "gj", { buffer = true })
		nmap("k", "gk", { buffer = true })
		nmap("gj", "j", { buffer = true })
		nmap("gk", "k", { buffer = true })
		vim.o.wrap = true
		vim.o.colorcolumn = ""
		-- no idea why but luasnip tab expansion won't work in vimwiki files,
		-- so use ctrl + c to expand
		vim.keymap.set("i", "<C-c>", require("luasnip").expand_or_jump, { buffer = true })
	end,
	group = vimwikiGroup,
	pattern = "vimwiki",
})
-- this was setting markdown filetype as vimwiki
vim.g.vimwiki_global_ext = 0
-- this was interfering with UltiSnips trigger TODO delete?
vim.g.vimwiki_table_mappings = 0
vim.g.vimwiki_conceal_pre = 1
vim.g.vimwiki_markdown_link_ext = 1
vim.g.vimwiki_key_mappings = { global = 0 }
vim.g.vimwiki_list = { { path = "~/vimwiki/", syntax = "markdown", ext = ".md" } }
nmap("<leader><leader>w", "<Plug>VimwikiIndex")
nmap("<leader><leader>t", "<Plug>VimwikiTabIndex")
nmap("_", "<Plug>VimwikiRemoveHeaderLevel")
nmap("<leader><leader>&", "<Plug>VimwikiNextLink")

-- vimtex configuration
vim.g.vimtex_view_method = "skim"
vim.g.vimtex_quickfix_mode = 0
local vimtexGroup = vim.api.nvim_create_augroup("VimtexGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		nmap("<leader>tc", ":VimtexCompile<CR>", { buffer = true })
		nmap("<leader>tl", ":VimtexClean<CR> <bar> :silent !rm *.synctex.gz<CR>", { buffer = true, silent = true })
	end,
	group = vimtexGroup,
	pattern = "tex",
})

-- vimux configuration
vim.g.VimuxOrientation = "h"
vim.g.VimuxHeight = "45"
vim.g.VimuxLastCommand = "make && ./a.out"
nmap("<leader>vp", ":silent wall <bar> VimuxPromptCommand<CR>")
-- because my weird .inputrc makes VimuxClearTerminalScreen not work
nmap("<leader>vc", ':call VimuxSendKeys("ii")<CR>')
nmap("<leader>vs", ":VimuxCloseRunner<CR>")
nmap("<leader>vi", ":VimuxInspectRunner<CR>")
nmap("<leader>vz", ":VimuxZoomRunner<CR>")
nmap("<leader>vk", ":VimuxInterruptRunner<CR>")
nmap("<C-s>", ":silent wall <bar> VimuxRunLastCommand<CR>")

-- telescope configuration
require("pault.telescope")

-- hop configuration
require("hop").setup()
nmap("-", ":HopWord<CR>")

-- comment configuration
require("Comment").setup()

-- neoscroll configuration
require("neoscroll").setup({ mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "zt", "zz", "zb" } })

-- lualine configuration
require("lualine").setup()

-- treesitter configuration
require("pault.treesitter")

-- diffview configuration
nmap("<leader>gd", ":DiffviewOpen")
nmap("<leader>gdc", ":DiffviewOpen<CR>")
nmap("<leader>gc", ":DiffviewClose<CR>")

-- lsp configuration
require("pault.lsp")

-- nvim-cmp configuration
require("pault.completion")

-- luasnip configuration
require("pault.snippets")

-- formatting configuration
-- NOTE: must be called after pault.lsp due to mason stuff (same with dap)
require("pault.formatting")

-- debugging configuration
require("pault.dap")

-- lsp_signature configuration
require("lsp_signature").setup()
