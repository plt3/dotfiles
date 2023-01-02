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

nmap("<leader>f", require("telescope.builtin").find_files)
nmap("<leader>h", require("telescope.builtin").git_files)
-- to project-wide fuzzy search, search for one letter and then
-- <C-f> to filter through results TODO find better solution for this
nmap("<leader>r", require("telescope.builtin").live_grep)
nmap("<leader>b", require("telescope.builtin").buffers)
