local M = {}

function M.normalmap(binding, command, opts)
    opts = opts or { noremap = true, silent = true }
    vim.keymap.set('n', binding, command, opts)
end

return M
