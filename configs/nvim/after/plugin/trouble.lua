local trouble = require("trouble")

vim.keymap.set("n", "<leader>xx", function() trouble.toggle() end, { desc = "trouble toggle" })
vim.keymap.set("n", "<leader>xw", function() trouble.toggle("workspace_diagnostics") end,
  { desc = "trouble workspace_diagnostics" })
vim.keymap.set("n", "<leader>xd", function() trouble.toggle("document_diagnostics") end,
  { desc = "trouble document_diagnostics" })
vim.keymap.set("n", "<leader>xq", function() trouble.toggle("quickfix") end, { desc = "trouble quickfix" })
vim.keymap.set("n", "<leader>xl", function() trouble.toggle("loclist") end, { desc = "trouble loclist" })
vim.keymap.set("n", "gR", function() trouble.toggle("lsp_references") end, { desc = "trouble lsp_references" })
