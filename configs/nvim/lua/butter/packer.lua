-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	-- Theme
	use('ryanoasis/vim-devicons')
        use {
          'nvim-lualine/lualine.nvim',
          requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        }
	use { "ellisonleao/gruvbox.nvim" }

	-- Project
	use { 
	  'nvim-telescope/telescope.nvim',
	  tag = '0.1.0',
	  requires = { {'nvim-lua/plenary.nvim'} }
        }
    use {
      'nvim-tree/nvim-tree.lua',
      requires = {
        'nvim-tree/nvim-web-devicons', -- optional, for file icons
      },
      tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }
	use('tpope/vim-fugitive')
	use('mbbill/undotree')

        -- Code
	use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
	use('fatih/vim-go', { run = ':GoUpdateBinaries' })
	use('mzlogin/vim-markdown-toc')
	use('iamcco/markdown-preview.nvim', { run = "cd app && yarn install" })
	use('https://github.com/tpope/vim-commentary')
	use { 'neoclide/coc.nvim',  branch = 'release' }

end)

