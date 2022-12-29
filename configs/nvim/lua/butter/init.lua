require("butter.packer")
require("butter.remap")
require("butter.set")

-- Having a group is currently not necessary
-- local ButterGroup = vim.api.nvim_create_augroup("Butter", {})

-- Remove the cursor line when in insert mode
vim.api.nvim_create_autocmd("InsertEnter", {
  pattern = "*",
  callback = function()
    vim.opt.cursorline = false
  end,
})

-- Restore the cursor line when in insert mode
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    vim.opt.cursorline = true
  end,
})

-- Set the title of the buffer
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.opt.titlestring = [[%f %h%m%r%w %{v:progname} (%{tabpagenr()} of %{tabpagenr('$')})]]
    vim.opt.title = true
  end,
})

-- Trim whitespace on write
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.cmd([[
      let saved_view = winsaveview()
      keeppatterns %s/\s\+$//e
      call winrestview(saved_view)
    ]])
  end,
})

