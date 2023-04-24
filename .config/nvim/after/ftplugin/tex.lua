-- " set nocursorline
-- " set nornu
-- " let g:loaded_matchparen=1
vim.cmd('au InsertLeave *.tex execute "w"')                       -- autosave on exiting w
vim.keymap.set("n", "√", vim.cmd.VimtexView, { desc = '[V]iew' }) --NOTE: √ is option V
vim.cmd [[menu 500 PopUp.Find\ in\ PDF\ (Opt-V)  :VimtexView<CR>]]

vim.keymap.set("n", "<localleader>f",
	[[<cmd>:lua vim.lsp.buf.format{timeout_ms = 10000}<cr><cmd>:w<cr><cmd>:lua print('Formatted')<cr>]],
	{ desc = '[F]ormat' })
