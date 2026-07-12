vim.loader.enable()
vim.g.mapleader = " "

vim.g.loaded_rust_vim = 1 -- prevents rust.vim ftplugin/syntax from loading at all

-- vim.pack plugin setup (Neovim 0.12+)
local plugins = require("plugins")
vim.pack.add(plugins.packages)
plugins.setup()

vim.cmd("colorscheme rose-pine-moon")

require("autocmds")
require("options")

vim.schedule(function()
    require("mappings")
end)
