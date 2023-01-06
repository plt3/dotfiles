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
		live_grep = {
			mappings = {
				i = {
					["<c-f>"] = require("telescope.actions").to_fuzzy_refine,
				},
			},
		},
	},
})

-- load telescope-fzf-native
require("telescope").load_extension("fzf")

nmap("<leader>f", teleBuiltin.find_files)
-- default to git_files but fall back to find_files
nmap("<leader>h", function()
	vim.fn.system("git rev-parse --is-inside-work-tree")
	if vim.v.shell_error == 0 then
		teleBuiltin.git_files()
	else
		teleBuiltin.find_files()
	end
end)
-- to project-wide fuzzy search, search for one letter and then
-- <C-f> to filter through results TODO find better solution for this
nmap("<leader>r", teleBuiltin.live_grep)
nmap("<leader>b", teleBuiltin.buffers)
