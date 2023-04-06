return {
  "folke/todo-comments.nvim", -- https://github.com/folke/todo-comments.nvim
  config = function()
    vim.keymap.set("n", "]t", function()
      require("todo-comments").jump_next()
    end, { desc = "Next todo comment" })

    vim.keymap.set("n", "[t", function()
      require("todo-comments").jump_prev()
    end, { desc = "Previous todo comment" })
    require("todo-comments").setup({
      signs = false,
      -- Testing comments below
      --PERF: lorem ipsum.                    color: default  Aliases: OPTIM, PERFORMANCE, OPTIMIZE
      --HACK: lorem ipsum.                    color: warning
      --TODO: perhaps change these colors.    color: info
      --NOTE: adding a note.                  color: hint     Aliases: INFO
      --FIX: this needs to be fixed           color: error    Aliases: FIXME, BUG, FIXIT, ISSUE
      --WARN: this is bad oh no               color: warning  Aliases: WARNING, XXX
      --TEST: this test is to do ????         color: default  Aliases: TESTING, PASSED, FAILED
      --
      colors = {
        --NOTE: 0th element of list is tried first; remaining colors are fallbacks
        error = { --[[  "DiagnosticError", "ErrorMsg", ]] "#DC2626" },
        warning = { --[[  "DiagnosticWarn", "WarningMsg", ]] "#FBBF24" },
        info = { --[[ "DiagnosticInfo",  ]] "#2593EB" },
        hint = { --[[  "DiagnosticHint",  ]] "#10B981" },
        default = { --[[ "Identifier" ,]] "#7C3AED" },
        test = { --[[ "Identifier", ]] "#FF00FF" }
      },
    })
  end
}
