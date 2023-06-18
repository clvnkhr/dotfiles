vim.g.vimwiki_list = { { path = '~/Documents/GitHub/Coding-Notes', ext = '.md', syntax = 'markdown' } }
return {
	'vimwiki/vimwiki',
	keys = { "<leader>w" },
	ft = "md, wiki",
	config = function()
		vim.keymap.set({ "n", }, "<localleader>d", "<Plug>VimwikiToggleListItem", { noremap = false })
	end
}
