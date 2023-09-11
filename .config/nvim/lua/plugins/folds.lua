vim.o.foldcolumn = '1'
-- vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
-- vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  -- event = "BufReadPre",
  config = function()
    require('ufo').setup() -- TODO: look into setup in https://github.com/kevinhwang91/nvim-ufo
  end
}
