return {
  { "HiPhish/nvim-ts-rainbow2", event = "VeryLazy" },
  -- setup: see https://github.com/HiPhish/nvim-ts-rainbow2
  {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
  },
  -- {
  --   -- sentiment.nvim: Enhanced matchparen.vim plugin for Neovim to highlight the outer pair.
  -- "utilyre/sentiment.nvim",
  --   name = "sentiment",
  --   version = "*",
  --   opts = {
  --     -- config
  --   },
  -- },
  -- {
  --   -- I'm actually not 100% sure what this plugin is doing
  --   "rktjmp/highlight-current-n.nvim",
  --   config = function()
  --     vim.cmd([[ " Map keys
  --       nmap n <Plug>(highlight-current-n-n)
  --       nmap N <Plug>(highlight-current-n-N)
  --
  --       " If you want the highlighting to take effect in other maps they must
  --       " also be nmaps (or rather, not "nore").
  --       "
  --       " * will search <cword> ahead, but it can be more ergonomic to have *
  --       " simply fill the / register with the current <cword>, which makes future
  --       " commands like cgn "feel better". This effectively does that by performing
  --       " "search ahead <cword> (*), go back to last match (N)".
  --       nmap * *N
  --
  --       " Some QOL autocommands
  --       augroup ClearSearchHL
  --         autocmd!
  --         " You may only want to see hlsearch /while/ searching, you can automatically
  --         " toggle hlsearch with the following autocommands
  --         autocmd CmdlineEnter /,\? set hlsearch
  --         autocmd CmdlineLeave /,\? set nohlsearch
  --         " this will apply similar n|N highlighting to the first search result
  --         " careful with escaping ? in lua, you may need \\?
  --         autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
  --       augroup END]])
  --   end
  -- }
}
