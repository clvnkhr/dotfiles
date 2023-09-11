local on_attach = require 'keymaps'.on_attach

vim.cmd [[
sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticSignError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=
]]

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


-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.

local servers = {
  -- clangd = {},
  -- gopls = {},
  pyright = {},
  -- pylsp = {},
  texlab = {
    -- symbols = {
    --   ignoredPatterns = { "\\" }, -- TODO: fix this, and then remove the \\ stopgap in the snippet
    -- },
    latexindent = {
      -- modifyLineBreaks = true
    },
    -- cmd = { "texlab", "-vvvv", "--log-file=tmp/texlab.log" },
  }, -- https://github.com/latex-lsp/texlab/wiki/Configuration
  ltex = {
    ltex = {
      enabled = { "tex", "latex", "lua" },
      -- NOTE: there are extra settings in ltex_extra. See lua/cmp_setup.lua
      language = "en-GB",
      disabledRules = {
        ['en-GB'] = { "OXFORD_SPELLING_Z_NOT_S" }
      },
      dictionary = {
        ['en-GB'] = { "Leray", "Buckmaster", "Khor", "Xiaoyan", "Su", }
      },
    }
  },
  rust_analyzer = {},
  tsserver = {},
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

-- nvim-cmp setup: Autocompletions
local cmp = require 'cmp'
local luasnip = require 'luasnip'
-- local types = require "luasnip.util.types"
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
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'codeium' },
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
