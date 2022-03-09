local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local partial = require("luasnip.extras").partial
local s = ls.snippet
local i = ls.insert_node

-- load friendly-snippets
require("luasnip.loaders.from_vscode").load()
ls.filetype_extend("all", { "global" })

ls.snippets = {
  all = {
    s("date", partial(os.date, "%-m/%-d/%y")),
    s("time", partial(os.date, "%H:%M:%S")),
  },
  cpp = {
    s("if", fmt("if ({}) {{\n\t{}\n}}", {i(1, "condition"), i(0)})), -- escape curly braces by doubling them
  },
  tex = {
    s("ex", fmta("\\begin{exercise}{<>}\n\t<>\n\\end{exercise}", {i(1, "number"), i(0)})),
    s("frac", fmta("\\frac{<>}{<>}<>", {i(1), i(2), i(0)})),
  },
  vimwiki = {
    s("python", fmt("```python\n{}\n```", {i(0)})),
    s("cpp", fmt("```cpp\n{}\n```", {i(0)})),
    s("javascript", fmt("```javascript\n{}\n```", {i(0)})),
    s("java", fmt("```java\n{}\n```", {i(0)})),
    s("new", fmt("## {}:\n\n\n", {partial(os.date, "%-m/%-d/%y")})),
  },
}
