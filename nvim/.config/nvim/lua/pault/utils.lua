local M = {}

-- make a normal mode remap
function M.normalMap(binding, command, opts)
	opts = opts or { noremap = true, silent = true }
	vim.keymap.set("n", binding, command, opts)
end

-- make a normal mode remap that is dot-repeatable using vim-repeat plugin
function M.normalRepeatableMap(binding, func)
	-- map unique Plug mapping using tostring of function
	local mapName = "<Plug>" .. tostring(func):gsub("function: ", "")
	-- mapping including vim-repeat magic
	local repeatMap = mapName .. [[:silent! call repeat#set("\]] .. mapName .. [[", v:count)<CR>]]
	M.normalMap(mapName, func)
	M.normalMap(binding, repeatMap)
end

-- toggle opening/closing a window with the given filetype (using command to open it)
function M.toggleWindow(ftype, command)
	local winId = nil
	for _, win in pairs(vim.fn.getwininfo()) do
		local curBuf = vim.api.nvim_win_get_buf(win.winid)
		if vim.api.nvim_buf_get_option(curBuf, "filetype") == ftype then
			winId = win.winid
		end
	end
	if winId ~= nil then
		vim.api.nvim_win_close(winId, false)
	else
		vim.cmd(command)
	end
end

return M
