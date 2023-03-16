vim.keymap.set("n", "<leader>h", vim.cmd.Alpha, { desc = '[H]ome' })
return {
	'goolord/alpha-nvim',
	-- opts = { margin = 40 },not sure how to set this
	-- requires = { 'nvim-tree/nvim-web-devicons' },
	config = function()
		require 'alpha'.setup(
			require 'alpha.themes.startify'.config
		)
	end
}
