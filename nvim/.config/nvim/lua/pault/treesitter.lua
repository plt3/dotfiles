require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"python",
		"javascript",
		"lua",
		"bash",
		"cpp",
		"css",
		"html",
		"dockerfile",
		"json",
		"latex",
		"yaml",
		"java",
		"go",
		"vim",
		"vimdoc",
		"markdown",
		"markdown_inline",
	},
	highlight = {
		enable = true,
		disable = { "latex" }, -- latex highlighting always crashes
	},
	indent = {
		enable = true,
	},
})
