vim.loader.enable()
vim.g.mapleader = " "

local plugins = require("plugins")
vim.pack.add(plugins.packages)
plugins.setup()

vim.cmd("colorscheme rose-pine-moon")

require("autocmds")
require("options")

vim.schedule(function()
    require("mappings")
end)
