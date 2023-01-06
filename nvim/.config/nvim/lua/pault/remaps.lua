local nmap = require("pault.utils").normalMap
local toggle = require("pault.utils").toggleWindow

nmap("mm", ":write<CR>")
-- write all buffers
nmap("<leader>w", ":wall<CR>")
-- to copy/paste to/from system clipboard
vim.keymap.set({ "n", "x" }, "<leader>y", '"+y')
nmap("<leader>Y", '"+y$')
vim.keymap.set({ "n", "x" }, "<leader>p", '"+p')
nmap("<leader>P", '"+P$')
-- paste over visual selection without losing register content
vim.keymap.set("x", "<leader>d", '"_dP')
-- easier way to switch to alternate buffer
nmap("<leader>c", "<C-^>")
-- insert blank lines above/below current line
nmap("<leader>k", "O<ESC>j^")
nmap("<leader>j", "o<ESC>k^")
-- quickfix navigation
nmap("<C-c>", ":cprev<CR>")
nmap("<C-t>", ":cnext<CR>")
nmap("<leader>q", function()
	toggle("qf", "copen")
end)
-- be able to repeat indents on visual selections
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")
-- move visual selection up/down with J/K
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("x", "K", ":m '>-2<CR>gv=gv")
