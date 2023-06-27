local mset = require "macaltkey".keymap.set
local set = vim.keymap.set

-- TODO: find where other keymaps are defined.
--
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
    -- NOTE: above is replaced with :Trouble in lua/plugins/ui.lua


    -- ThePrimeagen style remap, https://www.youtube.com/watch?v=KfENDDEpCsI&list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R&index=3
    set("n", "<C-d>", "<C-d>zz")
    set("n", "<C-u>", "<C-u>zz")
    set("x", "<leader>p", "\"_dP")
    -- for some reason these below are not working so are commented out.
    -- set("n", "÷", "gcc") -- <D-/> (D = option)
    -- set("v", "÷", "gc")
    -- set("n", "<D-/>", "gcc")
    -- set("n", "<a-/>", "gcc")
    -- I suspect this is because gcc is provided by something else so this requires remapping

    -- indentation
    set("n", "<a-[>", "<<")  -- option h and l (<D-h>, <D-l>)
    set("n", "<a-]>", ">>")
    set("v", "<a-[>", "<gv") -- works on lines and blocks(!)
    set("v", "<a-]>", ">gv")

    -- keymap to move lines
    vim.cmd [[
    nnoremap <A-j> :m .+1<CR>==
    nnoremap <A-k> :m .-2<CR>==
    inoremap <A-j> <Esc>:m .+1<CR>==gi
    inoremap <A-k> <Esc>:m .-2<CR>==gi
    vnoremap <A-j> :m '>+1<CR>gv=gv
    vnoremap <A-k> :m '<-2<CR>gv=gv
    ]]


    -- mset('n', '<a-k>', '"addk"aP')          -- option k; note that this deletes lines at the top of the text!
    -- mset('n', '<a-j>', '"add"ap')
    -- mset('v', '<a-k>', '"ad<esc>k"aP`[V`]') -- only use these two when
    -- mset('v', '<a-j>', '"ad<esc>"ap`[V`]')  -- in visual line mode.

    -- mset('n', '', '"ayy"aP')         -- option k; note that this deletes lines at the top of the text!
    -- mset('n', 'Ô', '"ayy"ap')          -- duplicate lines

    --quick save button and buffer close
    mset('n', '<a-q>', ':bd<CR>') -- option Q
    mset('n', '<a-w>', ':w<CR>')  -- option W

    -- common commands while in insert mode
    mset('i', '<a-W>', '<C-O>W')
    mset('i', '<a-B>', '<C-O>B')
    mset('i', '<a-w>', '<C-O>w')
    mset('i', '<a-b>', '<C-O>b')

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
    set('n', '<C-H>', '<C-W>h')
    set('n', '<C-J>', '<C-W>j')
    set('n', '<C-K>', '<C-W>k')
    set('n', '<C-L>', '<C-W>l')
    -- Remap Control + H and Control + L to cycle through windows
    -- set('n', '<C-h>', '<C-w>W')
    -- set('n', '<C-l>', '<C-w>w')

    -- TERMINAL MODE
    set('t', '<C-H>', ' <C-\\><C-N><C-W>h')
    set('t', '<C-J>', ' <C-\\><C-N><C-W>j')
    set('t', '<C-K>', '<C-\\><C-N><C-W>k')
    set('t', '<C-L>', '<C-W>l')
    -- Remap Control + H and Control + L to cycle through windows
    -- set('t', '<C-h>', '<C-\\><C-N><C-w>W')
    -- set('t', '<C-l>', '<C-\\><C-N><C-w>w')

    -- INSERT MODE
    set('i', '<C-H>', ' <C-\\><C-N><C-W>h')
    set('i', '<C-J>', ' <C-\\><C-N><C-W>j')
    set('i', '<C-K>', '<C-\\><C-N><C-W>k')
    set('i', '<C-L>', '<C-W>l')
    -- Remap Control + H and Control + L to cycle through windows
    -- set('i', '<C-h>', '<C-\\><C-N><C-w>W')
    -- set('i', '<C-l>', '<C-\\><C-N><C-w>w')

    -- Commands for making splits
    mset('n', '<a-H>', '<C-W>v')
    mset('n', '<a-L>', '<C-W>v<C-W>l')
    mset('n', '<a-K>', '<C-W>s')
    mset('n', '<a-J>', '<C-W>s<C-W>j')

    -- entering and exiting terminal
    mset('n', '<a-t>', '<cmd>terminal<cr>')
    set('t', "<Esc>", "<C-\\><C-n>")
    set('t', "<C-t>", "<C-\\><cmd>FloatermToggle<cr>")
    -- INFO: see also lua/plugins/floatterm.lua

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

    -- plugin testing commands
    set("n", "<leader><localleader>t", [[<Plug>PlenaryTestFile]])
    set("n", "<leader><localleader>s", [[<cmd>source %<cr>]])
  end,

  -- keybinds when the LSP attaches
  on_attach = function(_, bufnr)
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      set('n', keys, func, { buffer = bufnr, desc = desc })
    end

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
  end,

  autosave = function()
    vim.api.nvim_set_keymap("n", "<leader>tas", ":SosToggle<CR>", { desc = "[T]oggle [A]uto[S]ave" })
  end
}

return keymaps
