local nmap = require("pault.utils").normalmap

-- tokyonight configuration
vim.cmd([[colorscheme tokyonight-night]])

-- vim-tmux-navigator configuration
-- Write all buffers before navigating from Vim to tmux pane
vim.g.tmux_navigator_save_on_switch = 2

-- vim-maximizer configuration
nmap("<leader>mt", ":MaximizerToggle!<CR>")

-- vim-fugitive configuration TODO toggle function
nmap("<leader>gs", ":Git<CR>")
nmap("<leader>gl", ":Git log<CR>")
nmap("<leader>gp", ":Git push<CR>")
-- use these remaps when running Gvdiffsplit!
nmap("<leader>gu", ":diffget //2<CR>")
nmap("<leader>gh", ":diffget //3<CR>")

-- vimwiki configuration
-- this was setting markdown filetype as vimwiki
vim.g.vimwiki_global_ext = 0
-- this was interfering with UltiSnips trigger TODO delete?
vim.g.vimwiki_table_mappings = 0
vim.g.vimwiki_conceal_pre = 1
vim.g.vimwiki_markdown_link_ext = 1
-- this was interfering with my <leader>w mapping TODO delete?
vim.g.vimwiki_key_mappings = { global = 0 }
vim.g.vimwiki_list = { { path = "~/vimwiki/", syntax = "markdown", ext = ".md" } }
-- TODO: figure out why this doesn't need to be recursive?
nmap("<leader><leader>w", "<Plug>VimwikiIndex")
nmap("<leader><leader>t", "<Plug>VimwikiTabIndex")

-- vimtex configuration TODO translate from vimscript
vim.g.vimtex_view_method = "skim"
vim.g.vimtex_quickfix_mode = 0
vim.cmd([[autocmd FileType tex nnoremap <buffer> <leader>tc :VimtexCompile<CR>]])
vim.cmd(
	[[autocmd FileType tex nnoremap <buffer> <silent> <leader>tl :VimtexClean<CR> <bar> :silent !rm *.synctex.gz<CR>]]
)

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
-- TODO: experiment with these keys
-- TODO: also try putting setup in packer.use.config as in hop readme?
require("hop").setup({ keys = "ahotenusi-d" })
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
nmap("<leader>gd", ":DiffviewOpen", { noremap = true })
nmap("<leader>gdc", ":DiffviewOpen<CR>")
nmap("<leader>gc", ":DiffviewClose<CR>")

-- lsp configuration
require("pault.lsp")

-- nvim-cmp configuration
require("pault.completion")

-- luasnip configuration
require("pault.snippets")
