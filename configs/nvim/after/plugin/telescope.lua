-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local themes = require('telescope.themes')
local trouble = require("trouble.providers.telescope")


require('telescope').setup {
  defaults = {
    file_ignore_patterns = { ".git", "node_modules" },
    mappings = {
      i = {
        -- ['<C-u>'] = false,
        -- ['<C-d>'] = false,
        ['<C-d>'] = actions.delete_buffer
      },
      n = {
        ['<C-d>'] = actions.delete_buffer
      }
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', builtin.oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  builtin.current_buffer_fuzzy_find(themes.get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

-- -- Finding files
vim.keymap.set('n', '<leader>sf', ':Telescope find_files hidden=true<CR>', { desc = '[S]earch [F]iles include hidden' })

-- -- Finding Strings
vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', ':Telescope live_grep hidden=true<CR>', { desc = '[S]earch by [G]rep' })
--
-- -- Finding LSP
vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
vim.keymap.set('n', '<leader>ss', builtin.lsp_document_symbols, { desc = '[S]earch document [S]ymbols' })
vim.keymap.set('n', '<leader>sS', builtin.lsp_dynamic_workspace_symbols, { desc = '[S]earch workspace [S]ymbols' })

-- Finding Misc
vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
