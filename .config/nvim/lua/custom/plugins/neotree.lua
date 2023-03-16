-- Unless you are still migrating, remove the deprecated commands from v1.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

-- vim.keymap.set("n", "<leader>ft", vim.cmd.Neotree, { desc = "Open [F]ile-[T]ree" })
vim.cmd([[ nnoremap <leader>ff :Neotree toggle filesystem reveal left <cr>]])
vim.cmd([[ nnoremap <leader>fc :Neotree toggle current reveal_force_cwd<cr>]])
-- vim.cmd([[ nnoremap | :Neotree reveal<cr> ]])
vim.cmd([[nnoremap gd :Neotree float reveal_file=<cfile> reveal_force_cwd<cr> ]])
vim.cmd([[nnoremap <leader>fb :Neotree toggle show buffers right<cr> ]])
vim.cmd([[nnoremap <leader>fg :Neotree float git_status<cr> ]])

return {
	"nvim-neo-tree/neo-tree.nvim",
	version = "*",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require('neo-tree').setup {}
	end,
}
