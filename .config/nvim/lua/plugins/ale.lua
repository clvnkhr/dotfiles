return {
  "dense-analysis/ale",
  config = function()
    vim.cmd [[
     let g:ale_use_neovim_diagnostics_api = 1
     let g:ale_linters_explicit = 1
     let g:ale_linters = {
     \   'tex': ['chktex'],
     \}
     let g:ale_tex_chktex_options = '-n1 -n3 -n8 -n11 -n25'
     " NB if you pass a bad option like -25 this will silently fail
    ]]
  end
} --[[
    --errors: for full list run texdoc chktex and see §7
    -- Warning 1: Command terminated with space.
    -- Warning 3: You should enclose the previous parenthesis with ‘{}’.
    -- Warning 8: Wrong length of dash may have been used.
    -- Warning 11: You should use ‘%s’ to achieve an ellipsis.
    -- Warning 17: Number of ‘character’ doesn’t match the number of ‘character’.
    -- Warning 25: You might wish to put this between a pair of ‘{}’
  ]]
