local nmap = require("pault.utils").normalMap
local toggle = require("pault.utils").toggleWindow

-- tokyonight configuration
vim.cmd.colorscheme("tokyonight-night")

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
		vim.o.textwidth = 0
	end,
	group = vimwikiGroup,
	pattern = "vimwiki",
})
-- this was setting markdown filetype as vimwiki
vim.g.vimwiki_global_ext = 0
vim.g.vimwiki_conceal_pre = 1
vim.g.vimwiki_markdown_link_ext = 1
-- disabling table mappings allows Tab to expand snippets
vim.g.vimwiki_key_mappings = { global = 0, table_mappings = 0 }
vim.g.vimwiki_list = {
	{
		path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vimwiki/",
		syntax = "markdown",
		ext = ".md",
		listsyms = " .oOx",
	},
}
nmap("<leader><leader>w", "<Plug>VimwikiIndex")
nmap("<leader><leader>t", "<Plug>VimwikiTabIndex")
nmap("_", "<Plug>VimwikiRemoveHeaderLevel")

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
-- if nvim is opened with a python file, automatically set VimuxLastCommand
local vimuxGroup = vim.api.nvim_create_augroup("VimuxGroup", { clear = true })
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		vim.g.VimuxLastCommand = "python3 " .. vim.api.nvim_buf_get_name(0)
	end,
	group = vimuxGroup,
	pattern = "*.py",
})
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

-- indent-blankline configuration
require("ibl").setup({
	indent = { char = "▏" },
	scope = { enabled = false },
})

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

-- nvim-tree configuration
require("nvim-tree").setup()
nmap("<leader>s", ":NvimTreeFindFileToggle<CR>")

-- deugprint setup
require("debugprint").setup({
	filetypes = {
		["python"] = {
			left = 'print(f"',
			right = '")',
			mid_var = "{",
			right_var = '}")',
		},
	},
})
