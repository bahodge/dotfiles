-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

require("nvim-tree").setup({
  sort_by = "case_sensitive",

  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u",  action = "dir_up" },
        { key = "cd", action = "cd" },
      },
    },
  },
  renderer = {
    group_empty = false,
  },
  filters = {
    -- dotfiles = true,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
  },
})

-- Remapped keys
vim.keymap.set("", "<C-b>", ":NvimTreeToggle<CR>")

local function open_nvim_tree()
  -- open the tree
  require("nvim-tree.api").tree.open()
end
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
