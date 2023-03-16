return {
	-- "Shatur/neovim-ayu",
	-- "ellisonleao/gruvbox.nvim",
	-- 'navarasu/onedark.nvim',
	'olimorris/onedarkpro.nvim',
	config = function()
		require("onedarkpro").setup({
			colors = {
				onedark = {
					bg = "#231A0A"
				},
				-- onelight = {
				-- 	bg = "#00FF00" -- green
				-- }
			},
			MatchParen = { style = "bold" },
		})
	end
}
-- control the selection of themes in autodark.lua
