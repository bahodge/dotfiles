-- Converting all of this to lua is painful, just execute a script
local cocpath = string.format("source %s/.config/nvim/after/plugin/coc.vim", os.getenv("HOME"))
vim.cmd(cocpath)
