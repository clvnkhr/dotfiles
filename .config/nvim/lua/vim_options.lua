-- See `:help mapleader`. NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- folds
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99

-- floating windows and popups
vim.opt.winblend = 20
vim.opt.pumblend = 20

-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.hlsearch = false       -- Set highlight on search
vim.wo.number = true         -- line numbers
vim.wo.relativenumber = true -- relative line numbers
vim.o.mouse = 'a'            -- Enable mouse mode

-- Sync clipboard between OS and Neovim.
-- Remove this option if you want your OS clipboard to remain independent.
-- See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- [[ Highlight on yank, See `:help vim.highlight.on_yank()`]]
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- :set nolist wrap linebreak
vim.o.breakindent = true -- Enable break indent
vim.o.linebreak = true
vim.o.showbreak = "󱞪 "

-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "eol:"

vim.o.undofile = true   -- Save undo history. see also ./lua/custom/plugin/undotree.lua

vim.o.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true

vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default

vim.o.updatetime = 250    -- Decrease update time
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

vim.cmd(':set cursorline')
vim.cmd('set whichwrap+=<,>,h,l,[,]')

vim.cmd [[ "unmenu options
aunmenu PopUp.How-to\ disable\ mouse
aunmenu PopUp.-1-
menu 500 PopUp.Save  :w<CR>
]]
vim.cmd [[ :set scrolloff=5 ]]
