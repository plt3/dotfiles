local nmap = require("pault.utils").normalMap

require("obsidian").setup({
	workspaces = {
		{
			name = "personal",
			path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vimwiki",
		},
	},
	mappings = {
		["<C-space>"] = {
			action = function()
				return require("obsidian").util.toggle_checkbox()
			end,
			opts = { buffer = true },
		},
		["<CR>"] = {
			action = function()
				return vim.cmd("ObsidianFollowLink")
			end,
			opts = { buffer = true },
		},
	},
	daily_notes = {
		folder = "daily_notes",
	},
	disable_frontmatter = true,
	follow_url_func = function(url)
		vim.fn.jobstart({ "open", url })
	end,
})

local obsidianGroup = vim.api.nvim_create_augroup("ObsidianGroup", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		nmap("j", "gj", { buffer = true })
		nmap("k", "gk", { buffer = true })
		nmap("gj", "j", { buffer = true })
		nmap("gk", "k", { buffer = true })
		vim.o.wrap = true
		vim.o.colorcolumn = ""
		vim.o.textwidth = 0
		vim.o.breakindent = true
		vim.o.breakindentopt = "shift:2"
	end,
	group = obsidianGroup,
	pattern = "markdown",
})

-- return number of Obsidian tabpage, if there is one open. Otherwise return -1
local function getObsidianTabNumber()
	local windows = vim.api.nvim_list_wins()

	for _, window in pairs(windows) do
		local buffer = vim.api.nvim_win_get_buf(window)
		local filename = vim.api.nvim_buf_get_name(buffer)
		if string.find(filename, "iCloud~md~obsidian/Documents/vimwiki/") then
			return vim.api.nvim_win_get_tabpage(window)
		end
	end

	return -1
end

-- both keybinds open Obsidian notes a preexisting tab containing Obsidian notes if
-- there is one, otherwise in a new tab
nmap("<leader><leader>t", function()
	local obsidianTabNum = getObsidianTabNumber()
	if obsidianTabNum == -1 then
		vim.cmd("tabnew")
	else
		vim.api.nvim_set_current_tabpage(obsidianTabNum)
	end
	vim.cmd("ObsidianToday")
end)

nmap("<leader><leader>n", function()
	local obsidianTabNum = getObsidianTabNumber()
	if obsidianTabNum == -1 then
		vim.cmd("tabnew ~/Library/Mobile Documents/iCloud~md~obsidian/Documents/vimwiki/other/TODO.md")
	else
		vim.api.nvim_set_current_tabpage(obsidianTabNum)
	end
	vim.cmd("ObsidianQuickSwitch")
end)
