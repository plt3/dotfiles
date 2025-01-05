local nmap = require("pault.utils").normalMap
local toggle = require("pault.utils").toggleWindow

-- tokyonight configuration
vim.cmd.colorscheme("tokyonight-night")

-- vim-tmux-navigator configuration
-- Write all buffers before navigating from Vim to tmux pane
vim.g.tmux_navigator_save_on_switch = 2

-- vim-maximizer configuration
nmap("<leader>mt", ":MaximizerToggle!<CR>")

-- bullets.vim configuration
vim.g.bullets_outline_levels = {}

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
nmap("<leader>vp", ":silent wall <bar> VimuxPromptCommand<CR>")
-- because my weird .inputrc makes VimuxClearTerminalScreen not work
nmap("<leader>vc", ':call VimuxSendKeys("ii")<CR>')
nmap("<leader>vs", ":VimuxCloseRunner<CR>")
nmap("<leader>vi", ":VimuxInspectRunner<CR>")
nmap("<leader>vz", ":VimuxZoomRunner<CR>")
nmap("<leader>vk", ":VimuxInterruptRunner<CR>")
-- <C-s> writes all buffers, then runs last vimux command. If there is no last vimux
-- command, it finds the last command run in a tmux pane in the same window, and sets
-- that as the last command
nmap("<C-s>", function()
	vim.cmd.wall({ mods = { silent = true } })

	if vim.g.VimuxLastCommand == nil then
		vim.fn.VimuxRunCommand("")
		local pane_lines = vim.fn.system({ "tmux", "capture-pane", "-S", "-5", "-t", vim.g.VimuxRunnerIndex, "-p" })

		-- note that command line prompt is hard-coded
		local prompt = "^(pault @ pauls%-air%-8.->) (.+)"
		local last_cmd = nil

		for line in pane_lines:gmatch("[^\r\n]+") do
			local _, _, _, command = line:lower():find(prompt)
			if command ~= nil then
				last_cmd = command
			end
		end
		vim.g.VimuxLastCommand = last_cmd
	end
	vim.cmd.VimuxRunLastCommand()
end)

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

-- debugprint setup
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

-- obsidian.nvim configuration
require("pault.obsidian")

-- rsync.nvim configuration
require("rsync").setup({ sync_on_save = false })
