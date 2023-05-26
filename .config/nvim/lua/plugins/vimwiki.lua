		vim.g.vimwiki_list = {{path= '~/Documents/GitHub/Coding-Notes', ext = '.md', syntax = 'markdown' }}
return {
	'vimwiki/vimwiki',
	lazy = false,
	keys = { "<leader>w" },
	ft = "md, wiki",

}
