local cmp = require("cmp")

-- add friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- custom nvim-cmp setup
cmp.setup({
	preselect = cmp.PreselectMode.None,
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-n>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		["<C-p>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		["<C-Space>"] = cmp.mapping.disable,
		["<Tab>"] = cmp.mapping(
			cmp.mapping.confirm({
				behavior = cmp.ConfirmBehavior.Insert,
				select = false,
			}),
			{ "i", "c" }
		),
		["<C-e>"] = cmp.mapping.disable,
		["<CR>"] = cmp.mapping.disable,
	},
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "nvim_lua" },
		{ name = "path" },
		{ name = "buffer" },
	}),
	formatting = {
		format = require("lspkind").cmp_format({
			menu = {
				buffer = "[Buffer]",
				nvim_lsp = "[LSP]",
				path = "[Path]",
				luasnip = "[LuaSnip]",
				nvim_lua = "[Lua]",
				latex_symbols = "[Latex]",
			},
		}),
	},
})

-- Use buffer source for '/'
cmp.setup.cmdline("/", {
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':'
cmp.setup.cmdline(":", {
	-- C-n/C-p cycle through completions if a character has been typed and through
	-- command history if not (from https://www.reddit.com/r/neovim/comments/v5pfmy/comment/ibb61w3/)
	mapping = cmp.mapping.preset.cmdline({
		["<C-n>"] = { c = cmp.mapping.select_next_item() },
		["<C-p>"] = { c = cmp.mapping.select_prev_item() },
	}),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
