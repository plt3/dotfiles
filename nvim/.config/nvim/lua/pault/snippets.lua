local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local partial = require("luasnip.extras").partial
local s = luasnip.snippet
local i = luasnip.insert_node
local t = luasnip.text_node
local c = luasnip.choice_node

luasnip.config.set_config({ updateevents = "TextChanged,TextChangedI", store_selection_keys = "<Tab>" })

luasnip.add_snippets(nil, {
	tex = {
		s("ex", fmta("\\begin{exercise}{<>}\n\t<>\n\\end{exercise}", { i(1, "number"), i(0) })),
		s("frac", fmta("\\frac{<>}{<>}<>", { i(1), i(2), i(0) })),
		s("cyc", fmt("\\langle {} \\rangle{}", { i(1), i(0) })),
		s("ilmat", fmta("\\begin{bmatrix}<>\\end{bmatrix}", { i(1) })),
		s("proof", fmta("\\begin{proof}\n\t<>\n\\end{proof}", { i(1) })),
		s("*", t("\\cdot")),
		s("nin", t("$n \\in \\N$")),
		s("lim", fmta("\\displaystyle\\lim_{<>}", { i(1, "n \\to \\infty") })),
	},
	vimwiki = {
		s(
			"code",
			fmt("```{}\n{}\n```", { c(1, { t("python"), t("cpp"), t("java"), t("javascript"), t("go") }), i(0) })
		),
		s("new", fmt("## {}:\n\n\n", { partial(os.date, "%-m/%-d/%y") })),
		s("link", fmt("[{}]({})", { i(1), i(2) })),
	},
})

-- snippet expansion/navigation remaps (because configuring them in nvim-cmp was too hard)
vim.keymap.set("i", "<Tab>", function()
	return luasnip.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>"
end, { silent = true, expr = true, remap = true })
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
	luasnip.jump(-1)
end, { silent = true })
vim.keymap.set("s", "<Tab>", function()
	luasnip.jump(1)
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-E>", function()
	return luasnip.choice_active() and "<Plug>luasnip-next-choice" or "<C-E>"
end, { silent = true, expr = true, remap = true })
