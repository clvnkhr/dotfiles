return {
    -- cond = false,
    event = "BufReadPre",
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {
        -- configurations go here
    },
}

-- return { 'Bekaboo/dropbar.nvim' } -- INFO: this requires neovim nightly (>= 0.10.0 apparently, last i checked.)
