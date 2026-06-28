local teleBuiltin = require("telescope.builtin")
local nmap = require("pault.utils").normalMap

require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = require("telescope.actions").close,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			"--hidden",
		},
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		smart_open = {
			mappings = {
				i = {
					-- works around smart_open overriding ctrl-w keybind for deleting
					-- word. should be able to remove this once this issue is resolved:
					-- https://github.com/danielfalk/smart-open.nvim/issues/71
					["<C-w>"] = function() vim.api.nvim_input("<c-s-w>") end,
				},
			},
			ignore_patterns = {},
		},
	},
})

-- load telescope-fzf-native
require("telescope").load_extension("fzf")

-- load smart_open.nvim
require("telescope").load_extension("smart_open")

nmap("<leader>f", teleBuiltin.find_files)
nmap("<leader>h", function()
	require("telescope").extensions.smart_open.smart_open({
		filename_first = false,
		cwd_only = true,
	})
end)
nmap("<leader>b", teleBuiltin.buffers)
nmap("<leader>l", teleBuiltin.live_grep)

nmap("<leader>gg", teleBuiltin.git_branches)
