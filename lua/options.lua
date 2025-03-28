local opt = vim.opt
local o = vim.o

-------------------------------------- options ------------------------------------------
o.laststatus = 3
o.showmode = false

o.clipboard = "unnamedplus"
o.cursorline = true
o.cursorlineopt = "number"

-- Indenting
o.expandtab = true
o.shiftwidth = 2
o.smartindent = true
o.tabstop = 2
o.softtabstop = 2
o.linebreak = true -- Line break at word boundaries (if wrap is enabled)


opt.fillchars = { eob = " " }
o.ignorecase = true
o.smartcase = true
o.mouse = "a"

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = true
vim.opt.number = true         -- show absolute number
vim.opt.relativenumber = true -- add numbers to each line on the left side

-- disable nvim intro
opt.shortmess:append "sI"

o.signcolumn = "yes"
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400
o.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

-- g.mapleader = " "

-- disable some default providers
vim.g["loaded_node_provider"] = 0
vim.g["loaded_python3_provider"] = 0
vim.g["loaded_perl_provider"] = 0
vim.g["loaded_ruby_provider"] = 0

-- add binaries installed by mason.nvim to path
local is_windows = vim.fn.has "win32" ~= 0
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

vim.filetype.add {
  extension = {
    hbs = "html",
  },
}

vim.diagnostic.config({
  virtual_text = false,
})


o.hlsearch = true   -- Highlight search matches
o.incsearch = true  -- Show matches as you type (incremental search)
o.ignorecase = true -- Case-insensitive search
o.smartcase = true  -- Enable case-sensitive search if uppercase letters are used



o.scrolloff = 8     -- Keep 8 lines visible above/below the cursor
o.sidescrolloff = 8 -- Keep 8 columns visible to the left/right of the cursor


o.undolevels = 1000  -- Increase undo levels to allow deeper history
o.undoreload = 10000 -- Larger undo history when reloading files

o.autoread = true    -- Automatically read files if they change outside of Vim


-- folding workflow
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldlevel = 99
