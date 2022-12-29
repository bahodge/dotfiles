-- Global setup
vim.g.mapleader = " "
vim.keymap.set("n", "<SPACE>", "<nop>")

-- Unhighlight search
vim.keymap.set("", "<esc>", ":noh<CR>")

-- Source & Install all plugins
vim.keymap.set("", "<leader>1", ":source ~/.config/nvim/init.lua | :PackerSync<CR>")

-- Buffer Navigation
vim.keymap.set("", "<A-h>", "<C-\\><C-n><C-w>h" )
vim.keymap.set("", "<A-j>", "<C-\\><C-n><C-w>j" )
vim.keymap.set("", "<A-k>", "<C-\\><C-n><C-w>k" )
vim.keymap.set("", "<A-l>", "<C-\\><C-n><C-w>l" )

-- Search and replace in file
vim.keymap.set("v", "<C-r>", "\"hy:%s/<C-r>h//gc<left><left><left>")

