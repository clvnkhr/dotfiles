return {
  -- themes installed at the top; autodarkmode at the bottom
  -- "Shatur/neovim-ayu",
  -- "ellisonleao/gruvbox.nvim",
  -- 'navarasu/onedark.nvim',
  { "catppuccin/nvim", name = "catppuccin", enabled = false },
  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        colors = {
          onedark = {
            bg           = "#332A1A",
            color_column = "#372f24", -- this colors inactive windows.
          },
          onelight = {
            git_change = "#F8B600",
            git_add    = "#6CFF75",
            git_delete = "#FF7A77",
          }
        },
        highlights = {
          ["@nospell.latex"] = { link = "String" },
          ["@text.math.latex"] = { fg = "${purple}" },
          ["@punctuation.bracket.latex"] = { fg = "${git_delete}" },
          ["@punctuation.special.latex"] = { style = "bold" },
          ["@punctuation.delimiter.latex"] = { style = "bold" },
          -- ["@function.macro"] = { style = "bold" },
        },
        options = {
          highlight_inactive_windows = true,
          cursorline = true
        },
      })
    end
  },
  {
    'f-person/auto-dark-mode.nvim',
    priority = 1000,
    lazy = false,
    -- see https://github.com/f-person/auto-dark-mode.nvim if i wanna figure out how to make it auto? It seems to work just fine at startup for now.
    config = function()
      local auto_dark_mode = require('auto-dark-mode')

      auto_dark_mode.setup({
        -- update_interval = 1000,
        set_dark_mode = function()
          -- vim.api.nvim_set_option('background', 'dark')
          vim.cmd('colorscheme onedark')
          require 'lualine'.setup { options = { theme = require 'lualine.themes.onedark' } }
        end,
        set_light_mode = function()
          vim.api.nvim_set_option('background', 'light')
          vim.cmd('colorscheme onelight')
          require 'lualine'.setup { options = { theme = require 'lualine.themes.onelight' } }
        end,
      })
      auto_dark_mode.init()
    end
  },
  { -- commented out because onedarkpro does this directly
    -- "levouh/tint.nvim",
    -- -- Default configuration
    -- config = function()
    --   require("tint").setup({
    --     tint = -5,                             -- Darken colors, use a positive value to brighten
    --     saturation = 0.6,                      -- Saturation to preserve
    --     transforms = require("tint").transforms.SATURATE_TINT, -- Showing default behavior, but value here can be predefined set of transforms
    --     tint_background_colors = true,         -- Tint background portions of highlight groups
    --     highlight_ignore_patterns = { "WinSeparator", "Status.*" }, -- Highlight group patterns to ignore, see `string.find`
    --     window_ignore_function = function(winid)
    --       local bufid = vim.api.nvim_win_get_buf(winid)
    --       local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
    --       local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
    --
    --       -- Do not tint `terminal` or floating windows, tint everything else
    --       return buftype == "terminal" or floating
    --     end
    --   })
    -- end
  }
}
