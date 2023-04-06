return {
  -- "rafamadri z/friendly-snippets",
  {
    "windwp/nvim-autopairs",
    config = function()
      require('nvim-autopairs').setup {
        check_ts = true,
        ts_config = {
          lua = { "string", "source" },
          javascript = { "string", "template_string" },
          -- java = false,
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" }, -- nb :echo &ft to find the filetype
        -- fast_wrap = {
        --   map = "<M-e>",
        --   chars = { "{", "[", "(", '"', "'" },
        --   pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
        --   offset = 0,
        --   end_key = "$",
        --   keys = "qwertyuiopasdfghjklzxcvbnm",
        --   check_comma = true,
        --   highlight = "PmenuSel",
        --   highlight_grey = "LineNr",
        -- },
      }
      local Rule = require('nvim-autopairs.rule')
      local npairs = require('nvim-autopairs')

      npairs.add_rules { Rule("\\[", "\\]", "tex") }
      npairs.add_rules { Rule("\\(", "\\)", "tex") }
      npairs.add_rules { Rule("\\|", "\\|", "tex") }
      npairs.add_rules { Rule("\\langle", "\\rangle", "tex") }
    end
  }
}
