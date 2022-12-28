local luasnip = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local partial = require("luasnip.extras").partial
local s = luasnip.snippet
local i = luasnip.insert_node
local t = luasnip.text_node

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
		s("python", fmt("```python\n{}\n```", { i(0) })),
		s("cpp", fmt("```cpp\n{}\n```", { i(0) })),
		s("javascript", fmt("```javascript\n{}\n```", { i(0) })),
		s("java", fmt("```java\n{}\n```", { i(0) })),
		s("go", fmt("```go\n{}\n```", { i(0) })),
		s("new", fmt("## {}:\n\n\n", { partial(os.date, "%-m/%-d/%y") })),
		s("link", fmt("[{}]({})", { i(1), i(2) })),
	},
})

-- use tab expansion/navigation TODO rewrite as lua
vim.cmd([[imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>']])
