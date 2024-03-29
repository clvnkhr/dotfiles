return {
	-- NOTE: Here is where you install your plugins.
	--  You can configure plugins using the `config` key.
	--  You can also configure plugins after the setup call,
	--    as they will be available in your neovim runtime.
	{ 'tpope/vim-fugitive', cmd = "Git" },   -- Git related plugins
	{ 'tpope/vim-rhubarb',  event = "BufReadPre" }, -- Git related plugins
	{ 'tpope/vim-sleuth',   event = "BufReadPre" }, -- Git related plugins

	-- LSP related plugins:
	-- configuration is done below. Search for lspconfig to find configs.
	{
		-- LSP Configuration & Plugins
		'neovim/nvim-lspconfig',
		dependencies = {
			-- Automatically install LSPs to stdpath for neovim
			'williamboman/mason.nvim',
			'williamboman/mason-lspconfig.nvim',
			-- Useful status updates for LSP
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ 'j-hui/fidget.nvim', opts = {}, tag = 'legacy' },
			-- Additional lua configuration, makes nvim stuff amazing!
			'folke/neodev.nvim',
		},
	},
	-- CUSTOM : WIP : Luasnip and friendly snippets added here
	{
		'L3MON4D3/LuaSnip',
		event = "InsertEnter",
		dependencies = { 'saadparwaiz1/cmp_luasnip', --[[ 'rafamadriz/friendly-snippets' ]] },
		config = function()
			-- Load snippets
			require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" }) -- WARNING: path = "..." without s will silently fail!!!
			-- require("luasnip.loaders.from_vscode").load()
			require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim/snippets/vscode_snippets" })
		end
	},
	{
		-- Autocompletion
		'hrsh7th/nvim-cmp',
		event = "VeryLazy",
		dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
		-- config = function()
		-- 	require('cmp_setup')
		-- end
	},
	-- Useful plugin to show you pending keybinds.
	{ 'folke/which-key.nvim',  opts = {}, event = "VeryLazy" },
	{
		-- Adds git releated signs to the gutter, as well as utilities for managing changes
		'lewis6991/gitsigns.nvim',
		event = "VeryLazy",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = '✚' },
				change = { text = '' },
				delete = { text = '' },
				topdelete = { text = '' },
				changedelete = { text = '' },
			},
			yadm = {
				enable = true
			},
			on_attach = function(bufnr)
				vim.keymap.set('n', '[c', require('gitsigns').prev_hunk,
					{ buffer = bufnr, desc = 'Go to Previous Hunk' })
				vim.keymap.set('n', ']c', require('gitsigns').next_hunk,
					{ buffer = bufnr, desc = 'Go to Next Hunk' })
				vim.keymap.set('n', '<leader>1', require('gitsigns').preview_hunk,
					{ buffer = bufnr, desc = 'Hunks' })
			end
		},
	},

	{
		-- Set lualine as statusline
		'nvim-lualine/lualine.nvim',
		event = { 'VimEnter' },
		dependencies = {
			'nvim-tree/nvim-web-devicons',
			-- 'linrongbin16/lsp-progress.nvim'
		},
		-- See `:help lualine.txt`
		opts = {
			options = {
				icons_enabled = true,
				theme = "catppuccin",
				component_separators = '󱐋',
				section_separators = { left = '', right = '' },
				disabled_filetypes = { 'neo-tree' },
			},
			sections = {
				lualine_c = { "vim.g['metals_status']" },
				lualine_x = { 'encoding', 'fileformat', 'filetype' },
			},
		},
	},

	{
		'lukas-reineke/indent-blankline.nvim',
		event = "BufReadPre",
		-- See `:help indent_blankline.txt`
		opts = {
			char = '┇',
			space_char_blankline = " ",
			show_trailing_blankline_indent = false,
			show_current_context = true,
			show_current_context_start = true,
		},
	},

	-- "gc" to comment visual regions/lines
	{ 'numToStr/Comment.nvim', opts = {}, event = "BufReadPre" },
	-- { 'numToStr/Comment.nvim', opts = { toggler = { line = 'gcc', block = 'gbc' }, } },

	-- Fuzzy Finder (files, lsp, etc)
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim' }
	},

	-- Fuzzy Finder Algorithm which requires local dependencies to be built.
	-- Only load if `make` is available. Make sure you have the system
	-- requirements installed.
	{
		'nvim-telescope/telescope-fzf-native.nvim',
		-- NOTE: If you are having trouble with this installation,
		--       refer to the README for telescope-fzf-native for more instructions.
		build = 'make',
		cond = function()
			return vim.fn.executable 'make' == 1
		end,
	},

	{
		-- treesitter: Highlight, edit, and navigate code
		'nvim-treesitter/nvim-treesitter',
		dependencies = {
			'nvim-treesitter/nvim-treesitter-textobjects',
		},
		config = function()
			pcall(require('nvim-treesitter.install').update { with_sync = true })
		end,
	},

	require 'kickstart.plugins.autoformat',
	require 'kickstart.plugins.debug',
}
