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
	},
	format_on_save = {},
})

require("mason-conform").setup()
