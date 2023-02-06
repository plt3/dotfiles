vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.scrolloff = 8
vim.o.sidescrolloff = 8
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "89"
vim.o.textwidth = 88
vim.o.formatoptions = "jcrql"
vim.o.lbr = true
vim.o.cursorline = true

vim.g.mapleader = " "

-- use ripgrep for grep and default to silent grep
vim.o.grepprg = "rg --vimgrep --no-heading --smart-case --hidden"
vim.o.grepformat = "%f:%l:%c:%m,%f:%l:%m"
vim.api.nvim_create_user_command("Grep", ":silent grep <args>", { nargs = "+" })

vim.g.markdown_fenced_languages =
	{ "sql", "python", "sh", "html", "css", "javascript", "dockerfile", "yaml", "json", "vim", "cpp" }

-- highlight on yank
local yankHiGroup = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", on_visual = false })
	end,
	group = yankHiGroup,
	pattern = "*",
})

-- show cursorline in everything but insert mode
local cursorLineHiGroup = vim.api.nvim_create_augroup("CursorLineHighlight", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave", "WinEnter", "InsertEnter", "WinLeave" }, {
	callback = function(opts)
		if opts.event == "InsertLeave" or opts.event == "WinEnter" then
			vim.o.cursorline = true
		else
			vim.o.cursorline = false
		end
	end,
	group = cursorLineHiGroup,
	pattern = "*",
})
