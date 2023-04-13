-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

local line_begin = require("luasnip.extras.expand_conditions").line_begin

local function envstr(envname)
  return [[
 \begin{]] .. envname .. [[}
   <>
 \end{]] .. envname .. [[}
 ]]
end

local function envstr2(envname, labelprefix)
  return [[
\begin{]] .. envname .. [[}\label{]] .. labelprefix .. [[:<>}
  <>
\end{]] .. envname .. [[}
]]
end

local function tbl1(tag)
  return { trig = tag, snippetType = "autosnippet", condition = line_begin }
end

local function div(tag, stag)
  return s({ trig = tag, condition = line_begin }, {
    t("\\" .. tag .. "{"),
    i(1),
    t "}",
    d(2, function(args)
      local text
      if args[1] == "" then
        text = tag
      else
        text = args[1][1]:gsub(" ", "_"):lower()
      end
      return sn(nil, { t("\\label{" .. stag .. ":"), i(1, text), t "}", t { "", "" }, i(0) })
    end, { 1 }),
  }
  )
end

-- influenced by https://github.com/tiagovla/.dotfiles/blob/master/neovim/.config/nvim/lua/plugins/modules/luasnip/snips/tex.lua#L107
return {
  s({ trig = "||", snippetType = "autosnippet" },
    fmta("\\lvert<>\\rvert", { i(1) })),
  s({ trig = "\\|", snippetType = "autosnippet" },
    fmta("\\lVert<>\\rVert", { i(1) })),
  s({ trig = "$", snippetType = "autosnippet" },
    fmta("\\(<>\\)", { i(1) })),
  --   s(tbl1("\\["), fmta([[
  -- \[<>\]
  -- ]], { i(1) })
  --   ),
  s(tbl1("beg"), fmta(envstr("<>"), { i(1), i(2), rep(1) })),
  s(tbl1("eq"), fmta(envstr2("equation", "eq"), { i(1), i(2) })),
  s(tbl1("al"), fmta(envstr2("align", "eq"), { i(1), i(2) })),
  s(tbl1("ad"), fmta(envstr("aligned"), { i(1) })),
  s(tbl1("th"), fmta(envstr2("thm", "thm"), { i(1), i(2) })),
  s(tbl1("de"), fmta(envstr2("defn", "def"), { i(1), i(2) })),
  s(tbl1("le"), fmta(envstr2("lem", "lem"), { i(1), i(2) })),
  s(tbl1("pr"), fmta(envstr2("prop", "prp"), { i(1), i(2) })),
  s(tbl1("co"), fmta(envstr2("cor", "cor"), { i(1), i(2) })),
  s(tbl1("pr"), fmta(envstr("proof"), { i(1) })),
  s(tbl1("cs"), fmta(envstr("cases"), { i(1) })),
  div("chapter", "ch"),
  div("section", "s"),
  div("subsection", "ss"),
  div("subsubsection", "sss"),

  s(tbl1("enm"),
    fmta(
      [[
\begin{enumerate}
   \item <>
\end{enumerate}
     ]],
      { i(1), }
    )
  ),

  s(tbl1("itm"),
    fmta(
      [[
\begin{itemize}
   \item <>
\end{itemize}
     ]],
      { i(1), }
    )
  ),

  s({ trig = "multieq", dscr = "multiple equations grouped together", condition = line_begin },
    fmta(
      [[
\begin{align}
\label{eq:<>\}
  \left\{\begin{aligned}
  <>
  \end{aligned}\right.
\end{align}
     ]], {
        i(1), i(2), }
    )
  ),

}
