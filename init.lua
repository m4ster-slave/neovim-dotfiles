vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

-- lazy.nvim setup
require("lazy").setup("plugins", {
  default = {
    lazy = true,
  },
})

require "autocmds"
require "options"

vim.schedule(function()
  require "mappings"
  require "cmp"
end)
