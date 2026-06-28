require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "isort", "black" },
		json = { "prettier" },
		cpp = { "clang_format" },
		sh = { "shfmt" },
		javascript = { "prettier" },
		typescript = { "prettier" },
		sql = { "sql_formatter" },
		mysql = { "sql_formatter" },
		php = { "php_cs_fixer" },
		xml = { "xmlformatter" },
		html = { "prettier" },
		css = { "prettier" },
		scss = { "prettier" },
		markdown = { "prettier" },
		yaml = { "prettier" },
	},
	formatters = {
		php_cs_fixer = {
			command = "vendor/bin/php-cs-fixer",
			cwd = require("conform.util").root_file({ ".php-cs-fixer.dist.php" }),
			require_cwd = true,
		},
		prettier = {
			cwd = require("conform.util").root_file({ ".prettierrc" }),
			require_cwd = true,
		},
	},
	format_on_save = function(bufnr)
		-- Only format PHP files on save
		if vim.bo[bufnr].filetype == "php" then
			return { timeout_ms = 5500, lsp_format = "never" }
		end
		-- Format on save for filetypes handled by prettier
		local prettier_filetypes =
			{ "javascript", "typescript", "html", "css", "scss", "json", "markdown", "yaml" }
		if vim.tbl_contains(prettier_filetypes, vim.bo[bufnr].filetype) then
			return { timeout_ms = 5500, lsp_format = "never" }
		end
		-- For other filetypes, return nil or an empty table to skip formatting on save
		return nil
	end,
	notify_no_formatters = false,
})

require("conform").formatters.black = {
	append_args = { "--line-length", "120" },
}

require("mason-conform").setup()
