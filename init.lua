vim.loader.enable()
vim.g.mapleader = " "

local plugins = require("plugins")

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        if ev.data.spec.name == "telescope-fzf-native.nvim" then
            vim.fn.system("make -C " .. ev.data.path)
        end
    end,
})
vim.pack.add(plugins.packages)
plugins.setup()

require("autocmds")
require("options")

vim.schedule(function()
    require("mappings")
end)
