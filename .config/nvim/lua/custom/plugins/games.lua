return {
  "seandewar/killersheep.nvim",
  'ThePrimeagen/vim-be-good',
  "rktjmp/shenzhen-solitaire.nvim",
  {
    "jim-fx/sudoku.nvim",
    -- dependencies = "" -- NOTE: add onedark as dependency?
    cmd = "Sudoku",
    config = function()
      local color = require("onedarkpro.helpers")
      local colors = color.get_colors()
      require("sudoku").setup {
        custom_highlights = {
          board = { fg = colors.fg },
          number = { fg = colors.green, bg = colors.cursorline },
          active_menu = { fg = colors.diff_text, bg = colors.selection, gui = "bold" },
          hint_cell = { fg = colors.git_hunk_add, bg = colors.selection },
          square = { bg = colors.selection, fg = colors.orange },
          column = { bg = colors.selection, fg = colors.purple },
          row = { bg = colors.selection, fg = colors.purple },
          settings_disabled = { fg = colors.fg_gutter, gui = "italic" },
          same_number = { fg = colors.cyan, gui = "bold" },
          set_number = { fg = colors.blue, gui = "italic" },
          error = { fg = colors.red, bg = colors.yellow },
        }
      }
    end
  }
}
