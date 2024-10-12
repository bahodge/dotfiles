return {
	-- {
	-- 	"ellisonleao/gruvbox.nvim",
	-- 	priority = 1000,
	-- 	-- config = function()
	-- 	-- 	vim.cmd("colorscheme gruvbox")
	-- 	-- end,
	-- },
	-- {
	-- 	"srcery-colors/srcery-vim",
	-- 	priority = 1000,
	-- 	as = "srcery",
	-- 	config = function()
	-- 		vim.cmd("colorscheme srcery")
	-- 	end,
	-- },
	-- {
	-- 	"rebelot/kanagawa.nvim",
	-- 	priority = 1000,
	-- 	as = "kanagawa",
	-- 	config = function()
	-- 		vim.cmd("colorscheme kanagawa")
	-- 	end,
	-- },
	-- {
	-- 	"sainnhe/everforest",
	-- 	priority = 1000,
	-- 	as = "everforest",
	-- 	config = function()
	-- 		vim.cmd("colorscheme everforest")
	-- 	end,
	-- },
	-- {
	-- 	"AlexvZyl/nordic.nvim",
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("nordic").load()
	-- 	end,
	-- },

	-- {
	-- 	"sainnhe/sonokai",
	-- 	-- lazy = false,
	-- 	as = "sonokai",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.cmd("colorscheme sonokai")
	-- 	end,
	-- },
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				background = {
					light = "latte",
					dark = "mocha",
				},

				color_overrides = {
					mocha = {
						rosewater = "#ffc0b9",
						flamingo = "#f5aba3",
						pink = "#f592d6",
						mauve = "#c0afff",
						red = "#ea746c",
						maroon = "#ff8595",
						peach = "#fa9a6d",
						yellow = "#ffe081",
						green = "#99d783",
						teal = "#47deb4",
						sky = "#00d5ed",
						sapphire = "#00dfce",
						blue = "#00baee",
						lavender = "#abbff3",
						text = "#cccccc",
						subtext1 = "#bbbbbb",
						subtext0 = "#aaaaaa",
						overlay2 = "#999999",
						overlay1 = "#888888",
						overlay0 = "#777777",
						surface2 = "#666666",
						surface1 = "#555555",
						surface0 = "#444444",
						base = "#202020",
						mantle = "#222222",
						crust = "#333333",
					},
				},

				transparent_background = true,
			})
			vim.cmd("colorscheme catppuccin")
		end,
	},

	-- -- transparency
	-- {
	-- 	"xiyaowong/transparent.nvim",
	-- 	config = function()
	-- 		local t = require("transparent")
	-- 		t.setup({
	-- 			extra_groups = {
	-- 				"NormalFloat",
	-- 				"NvimTreeNormal",
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
