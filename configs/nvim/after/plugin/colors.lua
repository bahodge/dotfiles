function AdoptTheme(color)
	require("gruvbox").setup({
		transparent_mode = true
	})

	vim.opt.background = "dark"
	color = color or "gruvbox"
	vim.cmd.colorscheme(color)

	-- Transparent background
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

AdoptTheme()
