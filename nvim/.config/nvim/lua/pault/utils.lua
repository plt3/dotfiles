local M = {}

function M.normalMap(binding, command, opts)
	opts = opts or { noremap = true, silent = true }
	vim.keymap.set("n", binding, command, opts)
end

function M.normalRepeatableMap(binding, func)
	-- map unique Plug mapping using tostring of function
	local mapName = "<Plug>" .. tostring(func):gsub("function: ", "")
	-- mapping including vim-repeat magic
	local repeatMap = mapName .. [[:silent! call repeat#set("\]] .. mapName .. [[", v:count)<CR>]]
	M.normalMap(mapName, func)
	M.normalMap(binding, repeatMap)
end

return M
