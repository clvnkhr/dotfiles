return {
  {
    'romgrk/barbar.nvim',
    -- cond = false,
    dependencies = 'nvim-tree/nvim-web-devicons',
    lazy = false,
    config = function()
      local map = vim.api.nvim_set_keymap
      local opts = { noremap = true, silent = true }

      -- Move to previous/next
      map('n', '≤', '<Cmd>BufferPrevious<CR>', opts)   -- <A-,>
      map('n', '≥', '<Cmd>BufferNext<CR>', opts)       -- <A-.>
      -- Re-order to previous/next
      map('n', '¯', '<Cmd>BufferMovePrevious<CR>', opts) -- '<A-<>'
      map('n', '˘', '<Cmd>BufferMoveNext<CR>', opts)    -- '<A->>'
      -- Goto buffer in position...
      map('n', '¡', '<Cmd>BufferGoto 1<CR>', opts)      -- <A-1>
      map('n', '€', '<Cmd>BufferGoto 2<CR>', opts)     -- ...
      map('n', '#', '<Cmd>BufferGoto 3<CR>', opts)
      map('n', '¢', '<Cmd>BufferGoto 4<CR>', opts)
      map('n', '∞', '<Cmd>BufferGoto 5<CR>', opts)
      map('n', '§', '<Cmd>BufferGoto 6<CR>', opts)
      map('n', '¶', '<Cmd>BufferGoto 7<CR>', opts)
      map('n', '•', '<Cmd>BufferGoto 8<CR>', opts) -- ...
      map('n', 'ª', '<Cmd>BufferGoto 9<CR>', opts) -- <A-9>
      map('n', 'º', '<Cmd>BufferLast<CR>', opts)  -- <A-0>
      -- Pin/unpin buffer
      map('n', 'π', '<Cmd>BufferPin<CR>', opts)   -- <A-p>
      -- Close buffer
      map('n', 'ç', '<Cmd>BufferClose<CR>', opts) -- <A-c>
      -- Wipeout buffer
      --                 :BufferWipeout
      -- Close commands
      --                 :BufferCloseAllButCurrent
      --                 :BufferCloseAllButPinned
      --                 :BufferCloseAllButCurrentOrPinned
      --                 :BufferCloseBuffersLeft
      --                 :BufferCloseBuffersRight
      -- Magic buffer-picking mode
      map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)
      -- Sort automatically by...
      map('n', '<Space>tb', '<Cmd>BufferOrderByBufferNumber<CR>',
        { desc = "[T]oggle buffer order: [B]uffer No.", noremap = true, silent = true })
      map('n', '<Space>td', '<Cmd>BufferOrderByDirectory<CR>',
        { desc = "[T]oggle buffer order: [D]irectory", noremap = true, silent = true })
      map('n', '<Space>tl', '<Cmd>BufferOrderByLanguage<CR>',
        { desc = "[T]oggle buffer order: [L]anguage", noremap = true, silent = true })
      map('n', '<Space>tw', '<Cmd>BufferOrderByWindowNumber<CR>',
        { desc = "[T]oggle buffer order: [W]indow No.", noremap = true, silent = true })

      require 'barbar'.setup {
        icons = {
          separator = {
            left = "⎡"
          },
          inactive = {
            separator = {
              left = "⎡"
            },
          }
        },
      }
      -- Other:
      -- :BarbarEnable - enables barbar (enabled by default)
      -- :BarbarDisable - very bad command, should never be used
    end
  },

  -- {
  -- "MaximilianLloyd/ascii.nvim",
  -- dependencies = { "MunifTanjim/nui.nvim" }
  -- },
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons',
      "MaximilianLloyd/ascii.nvim",
    },
    config = function()
      vim.keymap.set("n", "<leader>h", vim.cmd.Alpha, { desc = '[H]ome' })
      local alpha = require 'alpha'
      local startify = require 'alpha.themes.startify'
      -- local ascii = require('goolord/ascii.nvim')
      -- startify.section.header.val = ascii.get_random_global()
      -- need to figure out how this works
      --
      startify.section.header.val = {
        [[                                                      ██]],
        [[                                                      ░░░]],
        [[ ████████       ██████      ██████     █████ █████    ████     █████████████]],
        [[░░███░░███     ███░░███    ███░░███   ░░███ ░░███    ░░███    ░░███░░███░░███]],
        [[  ███ ░███    ░███████    ░███ ░███    ░███  ░███     ░███     ░███ ░███ ░███]],
        [[  ███ ░███    ░███░░░     ░███ ░███    ░░███ ███      ░███     ░███ ░███ ░███]],
        [[ ████ █████   ░░██████    ░░██████      ░░█████       █████    █████░███ █████]],
        [[░░░░ ░░░░░     ░░░░░░      ░░░░░░        ░░░░░       ░░░░░    ░░░░░ ░░░ ░░░░░ ]],
      } --       startify.section.header.val = [[
      --                                                        █
      --                                                       ░░░
      --  ████████       ██████      ██████     █████ █████    ████     █████████████
      -- ░░███░░███     ███░░███    ███░░███   ░░███ ░░███    ░░███    ░░███░░███░░███
      --  ░███ ░███    ░███████    ░███ ░███    ░███  ░███     ░███     ░███ ░███ ░███
      --  ░███ ░███    ░███░░░     ░███ ░███    ░░███ ███      ░███     ░███ ░███ ░███
      --  ████ █████   ░░██████    ░░██████      ░░█████       █████    █████░███ █████
      -- ░░░░ ░░░░░     ░░░░░░      ░░░░░░        ░░░░░       ░░░░░    ░░░░░ ░░░ ░░░░░]]
      alpha.setup(startify.config)
    end
  },
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.o.termguicolors = true
      vim.notify = require("notify")
      require("telescope").load_extension("notify")
      vim.api.nvim_set_keymap('n', '<leader>x', '<cmd>lua vim.notify.dismiss()<cr>',
        { noremap = true, desc = 'dismiss notifications' })
      -- require("notify")("My super important message")
    end
  },
  {
    "luukvbaal/statuscol.nvim",
    config = function()
      local builtin = require("statuscol.builtin")
      -- local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        -- configuration goes here, for example:
        -- relculright = true,
        -- segments = {
        --   { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
        --   {
        --     sign = { name = { "Diagnostic" }, maxwidth = 2, auto = true },
        --     click = "v:lua.ScSa"
        --   },
        --   { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
        --   {
        --     sign = { name = { ".*" }, maxwidth = 2, colwidth = 1, auto = true, wrap = true },
        --     click = "v:lua.ScSa"
        --   },
        -- }
        segments = {
          { text = { "%s" },             click = "v:lua.ScSa" },
          { text = { builtin.lnumfunc }, click = "v:lua.ScLa", },
          {
            text = { " ", builtin.foldfunc, " " },
            condition = { builtin.not_empty, true, builtin.not_empty },
            click = "v:lua.ScFa"
          }, }
      })
    end,
  },
  -- {
  --   "folke/noice.nvim",
  --   config = function()
  --     require("noice").setup({
  --       lsp = {
  --         -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
  --         override = {
  --           ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
  --           ["vim.lsp.util.stylize_markdown"] = true,
  --           ["cmp.entry.get_documentation"] = true,
  --         },
  --       },
  --       -- you can enable a preset for easier configuration
  --       presets = {
  --         bottom_search = true,   -- use a classic bottom cmdline for search
  --         command_palette = true, -- position the cmdline and popupmenu together
  --         long_message_to_split = true, -- long messages will be sent to a split
  --         inc_rename = false,     -- enables an input dialog for inc-rename.nvim
  --         lsp_doc_border = false, -- add a border to hover docs and signature help
  --       },
  --     })
  --   end
  -- }
}
