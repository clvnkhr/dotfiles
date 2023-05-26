return {
  'scalameta/nvim-metals',
  dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap", },
  ft = { "sc", "scala" },
  config = function()
    -- Metals setup (scala LSP)
    --
    local metals_config = require("metals").bare_config()

    -- Example of settings
    metals_config.settings = {
      showImplicitArguments = true,
      showImplicitConversionsAndClasses = true,
      excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
      enableSemanticHighlighting = true,
    }

    -- *READ THIS*
    -- I *highly* recommend setting statusBarProvider to true, however if you do,
    -- you *have* to have a setting to display this in your statusline or else
    -- you'll not see any messages from metals. There is more info in the help
    -- docs about this
    metals_config.init_options.statusBarProvider = "on"

    -- Example if you are using cmp how to make sure the correct capabilities for snippets are set
    metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Debug settings if you're using nvim-dap
    local dap = require("dap")

    dap.configurations.scala = {
      {
        type = "scala",
        request = "launch",
        name = "RunOrTest",
        metals = {
          runType = "runOrTestFile",
          --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
        },
      },
      {
        type = "scala",
        request = "launch",
        name = "Test Target",
        metals = {
          runType = "testTarget",
        },
        decorationColor = 'DiagnosticHint',
      },
    }

    metals_config.on_attach = function(client, bufnr)
      require("metals").setup_dap()

      -- INFO: calling the on_attach in lua/keymaps.lua
      require "keymaps".on_attach(client, bufnr)

      --metals nmap
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'Metals: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<localleader>m", function() require "telescope".extensions.metals.commands() end,
        '[M]etals telescope')
      nmap("<localleader>cl", vim.lsp.codelens.run, '[C]ode[l]ens') -- added
      nmap('<localleader>k', function() require("metals").hover_worksheet() end,
        '[W]ork[s]heet hover')

      -- nmap("<localleader>ad", vim.lsp.buf.rename, '[A]ll [D]iagnostics')
      -- nmap("<localleader>ae", vim.lsp.buf.rename, '[A]ll [E]rrors')
      -- nmap("<localleader>aw", vim.lsp.buf.rename, '[A]ll [W]arnings')
      -- 3 wrong

      -- NOTE: I didn't copy the dap bindings from https://github.com/scalameta/nvim-metals/discussions/39
    end

    -- Autocmd that will actually be in charging of starting the whole thing
    local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
    vim.api.nvim_create_autocmd("FileType", {
      -- NOTE: You may or may not want java included here. You will need it if you
      -- want basic Java support but it may also conflict if you are using
      -- something like nvim-jdtls which also works on a java filetype autocmd.
      pattern = { "scala", "sbt", "java" },
      callback = function()
        require("metals").initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })
  end
}
