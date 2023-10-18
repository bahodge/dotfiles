require("butter")

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- -- Useful status updates for LSP
      -- -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      -- { 'j-hui/fidget.nvim', opts = { tag = 'legacy' } },
      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim',      opts = {} },

  -- Theme
  { 'xiyaowong/transparent.nvim' },
  { "ellisonleao/gruvbox.nvim",  priority = 1000, config = true },

  -- { 'srcery-colors/srcery-vim',  as = 'srcery' },
  -- { 'connorholyday/vim-snazzy' },
  -- { 'rebelot/kanagawa.nvim' },
  -- { "tiagovla/tokyodark.nvim", opts = { gamma = 1.20, }, },

  -- Set lualine as statusline
  -- See `:help lualine.txt`
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = true,
        path = 2,
        theme = 'papercolor_dark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim',   opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim' }
  },
  { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' }, tag = 'nightly' },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  -- auto close parens
  { "windwp/nvim-autopairs" },

  {
    -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },
}, {})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
