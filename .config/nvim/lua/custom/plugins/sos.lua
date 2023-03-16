vim.api.nvim_set_keymap("n", "<leader>tas", ":SosToggle<CR>", { desc = "[T]oggle [A]uto[S]ave" })
return {
	'tmillr/sos.nvim',
	config = function()
		require("sos").setup { enabled = false, timeout = 1000 }
	end
}
