return {
  {
    -- autosaver, turned off by default
    'tmillr/sos.nvim',
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>tas", ":SosToggle<CR>", { desc = "[T]oggle [A]uto[S]ave" })
      require("sos").setup { enabled = false, timeout = 1000 }
    end
  }
  ,
  -- Lua
  -- use({
  --   "folke/persistence.nvim",
  --   event = "BufReadPre", -- this will only start session saving when an actual file was opened
  --   module = "persistence",
  --   config = function()
  --     require("persistence").setup()
  --   end,
  -- })
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
  },
  -- {
  --   -- saves nvim 'sessions'.
  --   "rmagatti/auto-session",
  --   config = function()
  --     local function close_neo_tree()
  --       require 'neo-tree.sources.manager'.close_all()
  --       vim.notify('closed all')
  --     end
  --
  --     -- local function open_neo_tree()
  --     --   vim.notify('opening neotree')
  --     --   require 'neo-tree.sources.manager'.show('filesystem')
  --     -- end
  --     --
  --     local function close_all_floating_wins()
  --       for _, win in ipairs(vim.api.nvim_list_wins()) do
  --         local config = vim.api.nvim_win_get_config(win)
  --         if config.relative ~= "" then
  --           vim.api.nvim_win_close(win, false)
  --           -- print('Closing window', win)
  --         end
  --       end
  --     end
  --
  --     require("auto-session").setup {
  --       log_level = "error",
  --       auto_session_suppress_dirs = {
  --         "~/", "~/Projects", "~/Downloads", "/"
  --       },
  --       bypass_session_save_file_types = { "neo-tree" },
  --       pre_save_cmds = { close_neo_tree, close_all_floating_wins },
  --       -- post_restore_cmds = { open_neo_tree, }
  --     }
  --   end
  -- }
}
