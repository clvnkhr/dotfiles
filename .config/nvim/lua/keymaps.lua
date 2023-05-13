local set = vim.keymap.set

local keymaps = {
  init = function()
    -- [[ Basic Keymaps ]]
    -- Keymaps for better default experience
    -- See `:help vim.keymap.set()`
    -- vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

    -- Remap for dealing with word wrap
    set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
    set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

    -- [[ Telescope Keymaps ]]
    -- See `:help telescope.builtin`
    set('n', '<leader>?', require('telescope.builtin').oldfiles,
      { desc = '[?] Find recently opened files' })
    set('n', '<leader><space>', require('telescope.builtin').buffers,
      { desc = '[ ] Find existing buffers' })
    set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 30,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
    set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
    set('n', '<leader>sw', require('telescope.builtin').grep_string,
      { desc = '[S]earch current [W]ord' })
    set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
    set('n', '<leader>sd', require('telescope.builtin').diagnostics,
      { desc = '[S]earch [D]iagnostics' })

    set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
    set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
    set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
    -- set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
    -- NOTE: above is replaced with :Trouble in lua/custom/plugins/ui.lua


    -- ThePrimeagen style remap, https://www.youtube.com/watch?v=KfENDDEpCsI&list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R&index=3
    set("n", "<C-d>", "<C-d>zz")
    set("n", "<C-u>", "<C-u>zz")
    set("x", "<leader>p", "\"_dP")
    -- for some reason these below are not working so are commented out.
    -- set("n", "÷", "gcc") -- <D-/> (D = option)
    -- set("v", "÷", "gc")
    -- set("n", "<D-/>", "gcc")

    -- indentation
    set("n", "˙", "<<") -- option h and l (<D-h>, <D-l>)
    set("n", "¬", ">>")
    set("v", "˙", "<gv") -- works on lines and blocks(!)
    set("v", "¬", ">gv")

    set('n', '˚', '"addk"aP')         -- option k; note that this deletes lines at the top of the text!
    set('n', '∆', '"add"ap')
    set('v', '˚', '"ad<esc>k"aP`[V`]') -- only use these two when
    set('v', '∆', '"ad<esc>"ap`[V`]') -- in visual line mode.

    -- set('n', '', '"ayy"aP')         -- option k; note that this deletes lines at the top of the text!
    -- set('n', 'Ô', '"ayy"ap')          -- duplicate lines

    --quick save button and buffer close
    set('n', 'œ', ':bd<CR>') -- option Q
    set('n', '∑', ':w<CR>') -- option W

    -- common commands while in insert mode
    set('i', '„', '<C-O>W', { noremap = true })
    set('i', 'ı', '<C-O>B', { noremap = true })
    set('i', '∑', '<C-O>w', { noremap = true })
    set('i', '∫', '<C-O>b', { noremap = true })

    --blocks of text to play with!
    --
    -- 1\   11  1111111   11111\   V|   VV  |II|  N\  /MI       4   \44  4444444   444444     VVVV   |II|  M    MM
    -- 222  22  22___    2     22  V\   VV   II   M MM MM       3  3V33  33ºº'    3    .33   V\  VV   II   M WW MM
    -- 3  3V33  33ºº'    3    .33   V\  VV   II   M WW MM       222  22  22___    2     22  V\   VV   II   M MM MM
    -- 4   \44  4444444   444444     VVVV   |II|  M    MM       1\   11  1111111   11111\   V|   VV  |II|  N\  /MI
    --

    set("n", "n", "nzzzv")
    set("n", "N", "Nzzzv")
    set("n", "*", "*zzzv")
    set("n", "<leader>W", "<cmd>set wrap!<CR>", { desc = 'toggle [W]ordwrap' })


    set('n', '<Leader>L',
      function()
        require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
        require("luasnip.loaders.from_vscode").load({
          paths = "~/.config/nvim/snippets/vscode_snippets/" })
        print("Reloaded snippets")
      end,
      { desc = 'Hot reload LuaSnips' }
    )
    -- Remap Control + H / J / K / L to move between windows
    --
    -- NORMAL MODE
    set('n', '<C-H>', '<C-W>h', { noremap = true })
    set('n', '<C-J>', '<C-W>j', { noremap = true })
    set('n', '<C-K>', '<C-W>k', { noremap = true })
    set('n', '<C-L>', '<C-W>l', { noremap = true })
    -- Remap Control + H and Control + L to cycle through windows
    -- set('n', '<C-h>', '<C-w>W', { noremap = true })
    -- set('n', '<C-l>', '<C-w>w', { noremap = true })

    -- TERMINAL MODE
    set('t', '<C-H>', ' <C-\\><C-N><C-W>h', { noremap = true })
    set('t', '<C-J>', ' <C-\\><C-N><C-W>j', { noremap = true })
    set('t', '<C-K>', '<C-\\><C-N><C-W>k', { noremap = true })
    set('t', '<C-L>', '<C-W>l', { noremap = true })
    -- Remap Control + H and Control + L to cycle through windows
    -- set('t', '<C-h>', '<C-\\><C-N><C-w>W', { noremap = true })
    -- set('t', '<C-l>', '<C-\\><C-N><C-w>w', { noremap = true })

    -- INSERT MODE
    set('i', '<C-H>', ' <C-\\><C-N><C-W>h', { noremap = true })
    set('i', '<C-J>', ' <C-\\><C-N><C-W>j', { noremap = true })
    set('i', '<C-K>', '<C-\\><C-N><C-W>k', { noremap = true })
    set('i', '<C-L>', '<C-W>l', { noremap = true })
    -- Remap Control + H and Control + L to cycle through windows
    -- set('i', '<C-h>', '<C-\\><C-N><C-w>W', { noremap = true })
    -- set('i', '<C-l>', '<C-\\><C-N><C-w>w', { noremap = true })

    -- Commands for making splits
    set('n', 'Ó', '<C-W>v', { noremap = true })      -- altshift h
    set('n', 'Ò', '<C-W>v<C-W>l', { noremap = true }) -- altshift l
    set('n', '', '<C-W>s', { noremap = true })     -- altshift k
    set('n', 'Ô', '<C-W>s<C-W>j', { noremap = true }) -- altshift j

    -- entering and exiting terminal
    set('n', '<C-T>', '<cmd>terminal<cr>', { noremap = true })
    set('t', "<Esc>", "<C-\\><C-n>", { noremap = true })

    -- resizing windows
    set("n", "=", [[<cmd>vertical resize +5<cr>]])   -- make the window biger vertically
    set("n", "-", [[<cmd>vertical resize -5<cr>]])   -- make the window smaller vertically
    set("n", "+", [[<cmd>horizontal resize +2<cr>]]) -- make the window bigger horizontally by pressing shift and =
    set("n", "_", [[<cmd>horizontal resize -2<cr>]]) -- make the window smaller horizontally by pressing shift and -

    -- -- persistent folds across sessions ;
    -- -- doesn't seem to work because it interferes with all sorts of different buffers
    -- -- https://til.hashrocket.com/posts/17c44eda91-persistent-folds-between-vim-sessions
    -- vim.cmd [[
    -- augroup AutoSaveFolds
    --   autocmd!
    --   autocmd BufWinLeave * mkview
    --   autocmd BufWinEnter * silent loadview
    -- augroup END
    -- ]]
    --
    --
    set('n', '<leader>dg', '<cmd>diffget<cr>', { desc = "[D]iff[G]et" })
    -- see `:help diffget`

    set('n', '<leader>dvo', '<cmd>DiffviewOpen<cr>', { desc = "[D]iff[V]iew[O]pen" })
    set('n', '<leader>dvc', '<cmd>DiffviewClose<cr>', { desc = "[D]iff[V]iew[C]lose" })
  end,

  on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      set('n', keys, func, { buffer = bufnr, desc = desc })
    end


    -- HACK: this is just copied into ./lua/custom/plugins/metals.lua, BY HAND. So if you change something here, do it again there
    -- TODO: figure out how to reduce code duplication...
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<leader>sd', vim.lsp.buf.signature_help, '[S]ignature [D]ocumentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
  end
}

return keymaps
