return {
  'scalameta/nvim-metals',
  dependencies = { "nvim-lua/plenary.nvim", "mfussenegger/nvim-dap", },
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
      vim.keymap.set("n", "<localleader>m", function() require "telescope".extensions.metals.commands() end,
        { desc = '[M]etals telescope' })
      -- HACK: we need to add the commands here from ./init.lua ourself because metals is configured separately from nvim-cmp
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end
      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
      nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
      nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
      nmap('gds', vim.lsp.buf.document_symbol, '[G]oto [D]ocument [S]ymbols')
      nmap('gws', vim.lsp.buf.workspace_symbol, '[G]oto [W]orkspace [S]ymbols')
      nmap("<localleader>cl", vim.lsp.codelens.run, '[C]ode[l]ens')
      nmap("<localleader>sh", vim.lsp.buf.signature_help, '[S]ignature [H]elp')
      nmap('<localleader>ws', function()
        require("metals").hover_worksheet()
      end, '[W]ork[s]heet hover')
      -- See `:help K` for why this keymap
      nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
      -- nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

      nmap("<localleader>ad", vim.lsp.buf.rename, '[A]ll [D]iagnostics')
      nmap("<localleader>ae", vim.lsp.buf.rename, '[A]ll [E]rrors')
      nmap("<localleader>aw", vim.lsp.buf.rename, '[A]ll [W]arnings')
      nmap("<localleader>d", vim.diagnostic.setloclist, 'Buffer Diagnostics Only')
      nmap("[c", vim.diagnostic.goto_prev({ wrap = false }), 'previous diagnostic')
      nmap("]c", vim.diagnostic.goto_next({ wrap = false }), 'next diagnostic')
      -- NOTE: I didn't copy the dap bindings from https://github.com/scalameta/nvim-metals/discussions/39

      -- Lesser used LSP functionality
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
      nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
      nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, '[W]orkspace [L]ist Folders')
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
