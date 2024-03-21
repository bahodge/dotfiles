return {
	-- {
	-- 	"bluz71/vim-nightfly-guicolors",
	-- 	priority = 1000, -- make sure to load this before all the other start plugins
	-- 	config = function()
	-- 		-- load the colorscheme here
	-- 		vim.cmd([[colorscheme nightfly]])
	-- 	end,
	-- },
	{ "ellisonleao/gruvbox.nvim", priority = 1000, config = true },
	{ "xiyaowong/transparent.nvim" },
	{ "sainnhe/sonokai" },
	{ "srcery-colors/srcery-vim", as = "srcery" },
	{ "connorholyday/vim-snazzy" },
	{ "tiagovla/tokyodark.nvim", opts = { gamma = 1.20 } },
	{ "rebelot/kanagawa.nvim" },
}
