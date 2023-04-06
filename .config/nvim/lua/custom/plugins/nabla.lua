return {
  'jbyuki/nabla.nvim',
  config = function()
    vim.keymap.set("n", "<leader>m", require("nabla").popup, { desc = "[M]ath" })
    -- vim.keymap.set("n", "<leader>tm", require("nabla").toggle_virt, { desc = "[T]oggle [M]ath" })
  end
}
