--[[

Modified from Kickstart.nvim (https://github.com/nvim-lua/kickstart.nvim)

Managed in this file:
- various variables and keybindings
- lazy.nvim
- telescope
- treesitter
- mason (languages)
- lualine
- luasnip
- neovide options

 TODO: maybe inline theme and autodark, and put lualine with it?

lua guide: - https://learnxinyminutes.com/docs/lua/
For translating between vimscript and lua, search through `:help lua-guide`
--]]
-- See `:help mapleader`. NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99

-- floating windows and popups
vim.opt.winblend = 20
vim.opt.pumblend = 20

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

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  'tpope/vim-fugitive', -- Git related plugins
  'tpope/vim-rhubarb',
  'tpope/vim-sleuth',   -- Detect tabstop and shiftwidth automatically

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
      { 'j-hui/fidget.nvim', opts = {} },
      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },
  -- CUSTOM : WIP : Luasnip and friendly snippets added here
  {
    'L3MON4D3/LuaSnip',
    lazy = false,
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
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',  opts = {} },
  {
    -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
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
      on_attach = function(buffer)
        vim.keymap.set('n', '[c', require('gitsigns').prev_hunk, { buffer = buffer })
        vim.keymap.set('n', ']c', require('gitsigns').next_hunk, { buffer = buffer })
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
        theme = 'auto',
        component_separators = '󱐋',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_c = { 'filename', "vim.g['metals_status']" },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
      },
    },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┇',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
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

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  require 'kickstart.plugins.autoformat',
  require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = 'custom.plugins' },
}, {                 -- this is the opts table for Lazy (custom: empty in original kickstart.nvim)
  border = "rounded" -- doesn't seem to work though?
})


-- [[ Setting options ]]
-- See `:help vim.o`

vim.o.hlsearch = false       -- Set highlight on search
vim.wo.number = true         -- line numbers
vim.wo.relativenumber = true -- relative line numbers
vim.o.mouse = 'a'            -- Enable mouse mode

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true    -- Save undo history. see also ./lua/custom/plugin/undotree.lua

vim.o.ignorecase = true  -- Case insensitive searching UNLESS /C or capital in search
vim.o.smartcase = true

vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default

vim.o.updatetime = 250    -- Decrease update time
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
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

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 30,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'lua', 'python', 'rust', 'tsx', 'typescript', 'help', 'vim', 'latex' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  rainbow = {
    -- added rainbow bracketing, see lua/custom/plugins/highlighting.lua
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = false, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil,  -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
    query = {
      'rainbow-parens',
      html = 'rainbow-tags',
      latex = 'rainbow-blocks',
    }
  },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true,             -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer', -- custom: changed m to f as they interfere with VimTeX (jumping between environments)
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- LSP settings.

-- -- custom for borders
local _border = "rounded"

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = _border
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = _border
  }
)

vim.diagnostic.config {
  float = { border = _border }
}
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end


  -- HACK: this is just copied into ./lua/custom/plugins/metals.lua, BY HAND. So if you change something here, do it again there
  -- TODO: figure out how to reduce code duplication...
  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  texlab = {
    symbols = {
      ignoredPatterns = { "\\" }, -- todo: fix this, and then remove the \\ stopgap in the snippet
    },
  },                              -- https://github.com/latex-lsp/texlab/wiki/Configuration
  rust_analyzer = {},
  -- tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}
-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
local types = require "luasnip.util.types"
local cmp_autopairs = require('nvim-autopairs.completion.cmp')

luasnip.config.setup { -- custom setup taken from https://www.youtube.com/watch?v=Dn800rlPIho
  history = true,
  updateevents = "TextChanged,TextChangedI",
  enable_autosnippets = true,
  -- ext_opts = {
  --   [types.choiceNode] = {
  --     active = {
  --       virt_text = { { "<-", Error } },
  --     },
  --   },
  -- },
}



-- custom from tjdv's video on luasnip: <c-k> is my expansion keys:
-- this will expand the current item or jump to the next item within the snippet.
-- vim.keymap.set({ "i", "s" }, "<c-k>", function()
--   if luasnip.expand_or_jumpable() then
--     luasnip.expand_or_jump()
--   end
-- end, { silent = true }
-- )

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done()
  ),
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    {
      name = 'nvim_lsp',
    },
    { name = 'luasnip' },
  },
  formatting = {
    -- added labels on the LHS
    fields = { 'menu', 'abbr', 'kind' },
    format = function(entry, item)
      local menu_icon = {
        nvim_lsp = 'λ',
        luasnip = '',
        -- buffer = 'Ω',
        -- path = 'P',
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
}

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

-- stolen from https://neovide.dev/faq.html

-- vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
-- vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
-- vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
-- vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
-- vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
-- vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

vim.cmd(':set cursorline')
vim.cmd('set whichwrap+=<,>,h,l,[,]')

if vim.g.neovide then
  -- Put anything you want to happen only in Neovide here
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  -- local color = require("onedarkpro.helpers")
  --
  -- local colors = color.get_preloaded_colors()

  -- -- Helper function for transparency formatting
  -- local alpha = function()
  --   return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
  -- end
  -- -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  -- vim.g.neovide_transparency = 0.0
  -- vim.g.transparency = 0.9
  -- vim.g.neovide_background_color = colors.bg .. alpha()
end

-- require "telescope".extensions.metals.commands()


-- ThePrimeagen style remap, https://www.youtube.com/watch?v=KfENDDEpCsI&list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R&index=3
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("x", "<leader>p", "\"_dP")
-- for some reason these below are not working so are commented out.
-- vim.keymap.set("n", "÷", "gcc") -- <D-/> (D = option)
-- vim.keymap.set("v", "÷", "gc")
-- vim.keymap.set("n", "<D-/>", "gcc")

-- indentation
vim.keymap.set("n", "˙", "<<") -- option h and l (<D-h>, <D-l>)
vim.keymap.set("n", "¬", ">>")
vim.keymap.set("v", "˙", "<gv") -- works on lines and blocks(!)
vim.keymap.set("v", "¬", ">gv")

vim.keymap.set('n', '˚', '"addk"aP')         -- option k; note that this deletes lines at the top of the text!
vim.keymap.set('n', '∆', '"add"ap')
vim.keymap.set('v', '˚', '"ad<esc>k"aP`[V`]') -- only use these two when
vim.keymap.set('v', '∆', '"ad<esc>"ap`[V`]') -- in visual line mode.

vim.keymap.set('n', '', '"ayy"aP')         -- option k; note that this deletes lines at the top of the text!
vim.keymap.set('n', 'Ô', '"ayy"ap')          -- duplicate lines

--quick save button and buffer close
vim.keymap.set('n', 'œ', ':bd<CR>') -- option Q
vim.keymap.set('n', '∑', ':w<CR>') -- option W


--blocks of text to play with!
--
-- 1\   11  1111111   11111\   V|   VV  |II|  N\  /MI       4   \44  4444444   444444     VVVV   |II|  M    MM
-- 222  22  22___    2     22  V\   VV   II   M MM MM       3  3V33  33ºº'    3    .33   V\  VV   II   M WW MM
-- 3  3V33  33ºº'    3    .33   V\  VV   II   M WW MM       222  22  22___    2     22  V\   VV   II   M MM MM
-- 4   \44  4444444   444444     VVVV   |II|  M    MM       1\   11  1111111   11111\   V|   VV  |II|  N\  /MI
--

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*", "*zzzv")


vim.keymap.set('n', '<Leader>L',
  function()
    require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
    require("luasnip.loaders.from_vscode").load({ paths = "~/.config/nvim/snippets/vscode_snippets/" })
    print("Reloaded snippets")
  end,
  { desc = 'Hot reload LuaSnips' }
)

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
