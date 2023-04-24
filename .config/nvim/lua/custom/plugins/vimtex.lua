vim.cmd([[
filetype plugin indent on
syntax enable
let g:vimtex_view_method = 'sioyek'
" vim.cmd("let g:vimtex_matchparen_enabled = 0")
let g:matchup_override_vimtex = 1
" vim.cmd("let g:vimtex_syntax_enabled = 0")
let g:vimtex_syntax_conceal_disable = 1
]])

-- see https://github.com/lervag/vimtex/issues/2174,
-- https://github.com/andymass/vim-matchup, and
-- :help vimtex-faq-slow-matchparen
-- :help vimtex-nf-enhanced-matchparen
-- :help g:vimtex_matchparen_enabled



vim.g.vimtex_quickfix_ignore_filters = {
  'Underfull \\\\hbox',
  'Overfull \\\\hbox',
  'LaTeX Warning: .+ float specifier changed to',
  'LaTeX hooks Warning',
  'Package siunitx Warning: Detected the "physics" package:',
  'Package hyperref Warning: Token not allowed in a PDF string',
  'Package biblatex Warning: Using fall-back BibTeX(8) backend',
}
-- " Or with a generic interface::
-- vim.cmd("let g:vimtex_view_general_viewer = 'okular'")
-- vim.cmd("let g:vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'")
--
-- " VimTeX uses latexmk as the default compiler backend. If you use it, which is
-- " strongly recommended, you probably don't need to configure anything. If you
-- " want another compiler backend, you can change it as follows. The list of
-- " supported backends and further explanation is provided in the documentation,
-- " see ":help vimtex-compiler".
-- let g:vimtex_compiler_method = 'latexrun'
--
-- " Most VimTeX mappings rely on localleader and this can be changed with the
-- " following line. The default is usually fine and is the symbol "\".
-- let uplocalleader = ","

return {
  'lervag/vimtex',
  lazy = false,
  config = function()
    vim.keymap.set("n", "√", vim.cmd.VimtexView, { desc = '[V]iew' }) --NOTE: √ is option V
    vim.cmd [[menu 500 PopUp.Find\ in\ PDF\ (Opt-V)  :VimtexView<CR>]]
  end
}
