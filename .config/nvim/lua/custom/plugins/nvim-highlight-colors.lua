vim.api.nvim_set_keymap("n", "<leader>tc", ":HighlightColorsToggle<CR>", { desc = "[T]oggle [C]olors" })

return {
  "brenoprata10/nvim-highlight-colors",
  config = function()
    require('nvim-highlight-colors').setup {}
  end
}
