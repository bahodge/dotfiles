-- Universal settings
vim.opt.encoding = "UTF-8"

-- A nice cursorline to help figure out where the cursor is
vim.opt.cursorline = true

-- Set tabs and indents
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 4

-- Set persistent undo
vim.opt.undofile = true
vim.opt.undodir = string.format("%s/.vim/undo", os.getenv("HOME"))
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep cursor n number of lines from top/bottom of page
vim.opt.scrolloff = 10

-- Enable mouse support
vim.opt.mouse = "a"

-- Line numbers
vim.opt.nu = true
vim.opt.relativenumber = true

-- Set global clipboard
vim.opt.clipboard = "unnamedplus"

-- Always show the signcolumn
vim.opt.signcolumn = "number"

-- Update time is important for coc
-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'
vim.o.swapfile = false
