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

local function opt(v)
  return { trig = ("\\?%s"):format(v), regTrig = true }
end


local function in_math()
  local math_nodes = {
    "displayed_equation", "inline_formula", "math_environment",
  }
  local text_commands = {
    "textrm",
  }
  local node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
  while node do
    if vim.tbl_contains(math_nodes, node:type()) then
      return true
    end
    if node:type() == "generic_command" then
      local command = vim.treesitter.query.get_node_text(node, 0):match "^\\(%w+)"
      if vim.tbl_contains(text_commands, command) then
        return false
      end
    end
    node = node:parent()
  end
  return false
end

local function tbl1(tag)
  return { trig = tag, snippetType = "autosnippet", condition = in_math }
end

local function tbl2(tag)
  return { trig = tag, snippetType = "autosnippet" }
end

local function tbl3(tag)
  return {
    trig = tag,
    snippetType = "autosnippet",
    condition = in_math,
    wordTrig = false
  }
end

local function tbl4(tag)
  return {
    trig = tag,
    snippetType = "autosnippet",
    wordTrig = false
  }
end

return {
  s(tbl2("ttt"), fmta("\\texttt{<>}", { i(1) })),
  s(tbl2("tit"), fmta("\\textit{<>}", { i(1) })),
  s(tbl2("tbf"), fmta("\\textbf{<>}", { i(1) })),
  s(tbl1("tsf"), fmta("\\textsf{<>}", { i(1) })),
  s(tbl1("tsc"), fmta("\\textsc{<>}", { i(1) })),
  s(tbl1("tup"), fmta("\\textup{<>}", { i(1) })),
  s(tbl1("mbf"), fmta("\\mathbf{<>}", { i(1) })),
  s(tbl1("bb"), fmta("\\mathbb{<>}", { i(1) })),
  s(tbl1("mcl"), fmta("\\mathcal{<>}", { i(1) })),
  s(tbl1("mfrk"), fmta("\\mathfrak{<>}", { i(1) })),
  s(tbl1("vc"), fmta("\\vec{<>}", { i(1) })),
  s(tbl1("ff"), fmta("\\frac{<>}{<>}", { i(1), i(2) })),
  s(tbl3(";a"), t("\\alpha")),
  s(tbl3(";b"), t("\\beta")),
  s(tbl3(";g"), t("\\gamma")),
  s(tbl3(";d"), t("\\delta")),
  s(tbl3(";e"), t("\\epsilon")),
  s(tbl3(";z"), t("\\zeta")),
  s(tbl3(";h"), t("\\eta")),
  s(tbl3(";i"), t("\\iota")),
  s(tbl3(";k"), t("\\kappa")),
  s(tbl3(";l"), t("\\lambda")),
  s(tbl3(";m"), t("\\mu")),
  s(tbl3(";n"), t("\\nu")),
  s(tbl3(";x"), t("\\xi")),
  s(tbl3(";p"), t("\\pi")),
  s(tbl3(";r"), t("\\rho")),
  s(tbl3(";s"), t("\\sigma")),
  s(tbl3(";t"), t("\\theta")),
  s(tbl3(";y"), t("\\tau")),
  s(tbl3(";f"), t("\\phi")),
  s(tbl3(";vf"), t("\\varphi")),
  s(tbl3(";c"), t("\\psi")),
  s(tbl3(";o"), t("\\omega")),
  s(tbl3(";G"), t("\\Gamma")),
  s(tbl3(";D"), t("\\Delta")),
  s(tbl3(";L"), t("\\Lambda")),
  s(tbl3(";X"), t("\\Xi")),
  s(tbl3(";P"), t("\\Pi")),
  s(tbl3(";S"), t("\\sigma")),
  s(tbl3(";T"), t("\\Theta")),
  s(tbl3(";F"), t("\\Phi")),
  s(tbl3(";vf"), t("\\varphi")),
  s(tbl3(";C"), t("\\Psi")),
  s(tbl3(";O"), t("\\Omega")),
  s(tbl3("->"), t("\\to")),
  s(tbl3("=>"), t("\\implies")),
  s(tbl3("<=>"), t("\\iff")),
  s(tbl3(":="), t("\\coloneq")),
  s(tbl3(">="), t("\\geq")),
  s(tbl3("<="), t("\\leq")),
  s(tbl3("<<"), t("\\ll")),
  s(tbl3(">>"), t("\\gg")),
  s(tbl3("|->"), t("\\mapsto")),
  s(tbl3("\\int"), fmta("\\int_{<>}^{<>}", { i(1), i(2) })),
  s(tbl1("\\iint"), fmta("\\iint_{<>}^{<>}", { i(1), i(2) })),
  s(tbl1("\\iiint"), fmta("\\iiint_{<>}^{<>}", { i(1), i(2) })),
  s(tbl1("\\oint"), fmta("\\oint_{<>}^{<>}", { i(1), i(2) })),
  s(tbl4("^^"), fmta("^{<>}", { i(1) })),
  s(tbl4("\\\\"), t("\\\\ ")),
  s(tbl4("__"), fmta("_{<>}", { i(1) })),

  s({ trig = "\\href" }, fmta(
    "\\href{<>}{<>}", {
      i(1, "url"), i(2, "text")
    }
  )
  ),
}
