vim.treesitter.language.register("sql", "mysql")

-- tree-sitter-manager only auto-attaches highlighting when FileType matches a
-- parser name; mysql uses the sql parser, so attach it here explicitly.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "mysql",
	callback = function() pcall(vim.treesitter.start) end,
})

require("tree-sitter-manager").setup({
	ensure_installed = {
		"python",
		"javascript",
		"typescript",
		"lua",
		"bash",
		"cpp",
		"css",
		"html",
		"http",
		"dockerfile",
		"json",
		"latex",
		"yaml",
		"php",
		"java",
		"go",
		"vim",
		"vimdoc",
		"markdown",
		"markdown_inline",
		"groovy",
		"sql",
	},
	-- kulala_http not in ensure_installed due to tree-sitter-manager bug
	-- (ensure_installed only checks built-in repos, not cfg.languages overrides).
	-- Install once via :TSManager -> 'i' on kulala_http.
	languages = {
		kulala_http = {
			install_info = {
				url = "https://github.com/HusuSama/tree-sitter-kulala-http",
				use_repo_queries = true,
			},
		},
	},
	nohighlight = { "latex" }, -- latex highlighting always crashes
	auto_install = true,
})
