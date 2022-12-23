local nmap = require('pault.utils').normalmap

function quickfixToggle()
    print('TODO: this function')
end

nmap('mm', ':w<CR>')
-- to copy/paste to/from system clipboard
nmap('<leader>y', '"+y')
nmap('<leader>Y', '"+y$')
nmap('<leader>p', '"+p')
-- easier way to switch to alternate buffer
nmap('<leader>c', '<C-^>')
-- insert blank lines above/below current line
nmap('<leader>k', 'O<ESC>j^')
nmap('<leader>j', 'o<ESC>k^')
-- quickfix navigation
nmap('<C-n>', ':cnext<CR>')
nmap('<C-p>', ':cprev<CR>')
nmap('<leader>q', quickfixToggle)
-- be able to repeat indents on visual selections
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('x', '>', '>gv')
-- move visual selection up/down with J/K
vim.keymap.set('x', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('x', 'K', ":m '>-2<CR>gv=gv")