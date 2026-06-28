require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		json = { "jq" },
		cpp = { "clang_format" },
		go = { "gofumpt" },
		sh = { "shfmt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		sql = { "sql_formatter" },
	},
	format_on_save = {},
})

require("conform").formatters.black = {
	append_args = { "--line-length", "120" },
}

require("mason-conform").setup()
