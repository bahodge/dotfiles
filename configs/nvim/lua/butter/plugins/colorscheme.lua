return {
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000,
		config = function()
			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"srcery-colors/srcery-vim",
		priority = 1000,
		as = "srcery",
		-- config = function()
		-- 	vim.cmd("colorscheme srcery")
		-- end,
	},

	-- transparency
	{ "xiyaowong/transparent.nvim" },
}
