local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local partial = require("luasnip.extras").partial
local s = ls.snippet
local i = ls.insert_node

local rep = require("luasnip.extras").rep
local t = ls.text_node
local f = ls.function_node

ls.config.set_config{updateevents = "TextChanged,TextChangedI", store_selection_keys = "<Tab>"}

-- load friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()
-- ls.filetype_extend("all", { "global" })

function defArgs(nodes)
  local funcArgs = nodes[1][1]
  if funcArgs == "" then
    return ""
  else
    local lines = {"", ""}
    local oneArg = ""

    for c in funcArgs:gmatch"." do
      if c ~= " " and c ~= "," then
        oneArg = oneArg .. c
      else
        if oneArg ~= "" then
          oneArg = "    " .. oneArg
          table.insert(lines, oneArg .. ": TODO")
          oneArg = ""
        end
      end
    end

    oneArg = "    " .. oneArg
    table.insert(lines, oneArg .. ": TODO")
    table.insert(lines, "    returns: TODO")
    table.insert(lines, "    ")

    return lines
  end
end

ls.add_snippets(nil, {
  python = {
    s(
      "func",
      fmt(
        [[
          def {}({}):
              """TODO: docstring for {}{}"""
              {}{}
        ]],
        {
          i(1, "function"),
          i(2),
          rep(1),
          f(defArgs, {2}),
          i(3, "pass"),
          i(0),
        }
      )
    ),
  },
  cpp = {
    s("if", fmt("if ({}) {{\n\t{}\n}}", {i(1, "condition"), i(0)})), -- escape curly braces by doubling them
  },
  tex = {
    s("ex", fmta("\\begin{exercise}{<>}\n\t<>\n\\end{exercise}", {i(1, "number"), i(0)})),
    s("frac", fmta("\\frac{<>}{<>}<>", {i(1), i(2), i(0)})),
    s("cyc", fmt("\\langle {} \\rangle{}", {i(1), i(0)})),
    s("ilmat", fmta("\\begin{bmatrix}<>\\end{bmatrix}", {i(1)})),
    s("proof", fmta("\\begin{proof}\n\t<>\n\\end{proof}", {i(1)})),
    s("*", t("\\cdot")),
    s("nin", t("$n \\in \\N$")),
    s("lim", fmta("\\displaystyle\\lim_{<>}", {i(1, "n \\to \\infty")})),
  },
  vimwiki = {
    s("python", fmt("```python\n{}\n```", {i(0)})),
    s("cpp", fmt("```cpp\n{}\n```", {i(0)})),
    s("javascript", fmt("```javascript\n{}\n```", {i(0)})),
    s("java", fmt("```java\n{}\n```", {i(0)})),
    s("go", fmt("```go\n{}\n```", {i(0)})),
    s("new", fmt("## {}:\n\n\n", {partial(os.date, "%-m/%-d/%y")})),
    s("link", fmt("[{}]({})", {i(1), i(2)})),
  },
})
