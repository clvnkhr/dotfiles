--[[

Modified from Kickstart.nvim (https://github.com/nvim-lua/kickstart.nvim)

Managed in this file:
- telescope: fuzzy file finder
- lualine
- neovide options

 TODO: maybe inline theme and autodark, and put lualine with it?
 TODO: Understand on_attach and remove the extra keymaps all over the place
 TODO: make alpha.nvim not clash with lazy and mason
 TODO: With barbar, I can remove the filename from the lualine
 TODO: Consider https://github.com/simrat39/symbols-outline.nvim_cmd
 TODO: Consider https://github.com/rmagatti/goto-preview
 TODO: Consider https://github.com/norcalli/nvim-colorizer.lua
 TODO: nanotee/luv-vimdocs and milisims/nvim-luaref

lua guide: - https://learnxinyminutes.com/docs/lua/
For translating between vimscript and lua, search through `:help lua-guide`
--]]
require('vim_options')


-- Install package manager,  https://github.com/folke/lazy.nvim, see `:help lazy.nvim.txt`
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup('plugins')

-- [[ Configure Telescope  See `:help telescope` and `:help telescope.setup()` ]]
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
require('nvim-treesitter.configs').setup(require 'treesitter_config')
require('cmp_setup')
require('keymaps').init() -- NOTE: this comes after the plugins to allow calling functions they define
-- non-plugin custom edits below:
--
-- Open help window in a vertical split to the right. https://vi.stackexchange.com/questions/4452/how-can-i-make-vim-open-help-in-a-vertical-split
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = vim.api.nvim_create_augroup("help_window_right", {}),
  pattern = { "*.txt" },
  callback = function()
    if vim.o.filetype == 'help' then vim.cmd.wincmd("L") end
  end
})

if vim.g.neovide then
  require 'neovide_options'
end

-- vim.cmd [[
-- augroup Hiunicode
--   autocmd!
--   autocmd BufEnter *
--       \ syntax match nonascii "[^\x00-\x7F]" |
--       \ highlight nonascii ctermfg=NONE ctermbg=red
-- augroup END
-- ]]

--[[ -- define a function that yanks the current word and passes it to gx
local function yank_and_open()
  -- yank the current word under the cursor
  vim.cmd("normal! yiw")
  -- add some characters to the yanked word
  vim.fn.setreg("+", vim.fn.getreg("+") .. "some characters")
  -- call netrw's gx function with the modified word
  vim.fn.netrw#BrowseX(vim.fn.getreg("+"), vim.fn.netrw#CheckIfRemote())
end ]]
-- map the function to a user command
-- vim.cmd("command! YankAndOpen lua yank_and_open()")

-- require "telescope".extensions.metals.commands()

-- vim.lsp.set_log_level("TRACE")
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
