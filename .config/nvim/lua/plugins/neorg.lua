return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  ft = 'norg',
  opts = {
    load = {
      ["core.defaults"] = {},  -- Loads default behaviour
      ["core.concealer"] = {}, -- Adds pretty icons to your documents
      ["core.dirman"] = {      -- Manages Neorg workspaces
        config = {
          workspaces = {
            notes = "~/notes",
          },
        },
      },
    },
  },
  dependencies = { { "nvim-lua/plenary.nvim" } },
}
