return {
  "preservim/tagbar",
  vim.keymap.set('n', '<leader>tb', vim.cmd.TagbarToggle, { desc = "Open [T]ag[b]ar" })
}
