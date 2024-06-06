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
			"/opt/homebrew/bin/rg", -- need full path for notes script that doesn't get $PATH
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
		-- TODO: doesn't look like these options are getting set
		smart_open = {
			match_algorithm = "fzf",
			show_scores = true,
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
-- project-wide fuzzy search
-- can also do Telescope live_grep, then <C-space> runs the fuzzy finder over the
-- results
nmap("<leader>r", function()
	-- avoid searching in filenames
	teleBuiltin.grep_string({
		only_sort_text = true,
		search = "",
	})
end)
