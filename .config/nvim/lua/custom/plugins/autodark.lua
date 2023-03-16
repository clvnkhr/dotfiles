-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	'f-person/auto-dark-mode.nvim',
	-- see https://github.com/f-person/auto-dark-mode.nvim if i wanna figure out how to make it auto? It seems to work just fine at startup for now.
	config = function()
		local auto_dark_mode = require('auto-dark-mode')

		auto_dark_mode.setup({
			-- update_interval = 1000,
			set_dark_mode = function()
				-- vim.api.nvim_set_option('background', 'dark')
				vim.cmd('colorscheme onedark')
			end,
			set_light_mode = function()
				vim.api.nvim_set_option('background', 'light')
				vim.cmd('colorscheme onelight')
			end,
		})
		auto_dark_mode.init()
	end,
}
