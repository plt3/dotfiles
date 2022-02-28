local ls = require("luasnip")
local s = ls.snippet
local f = ls.function_node

-- load friendly-snippets
require("luasnip.loaders.from_vscode").load()
ls.filetype_extend("all", { "global" })

function dateOrTime(args, snip, date)
  if date then
    return os.date("%-m/%-d/%C")
  else
    return os.date("%H:%M:%S")
  end
end

ls.snippets = {
  all = {
    s("date", {f(dateOrTime, {}, true)}),
    s("time", {f(dateOrTime, {}, false)}),
  },
}
