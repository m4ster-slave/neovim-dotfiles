local modules = {
    "plugins.plenary",
    "plugins.rainbow-csv",
    "plugins.cmp",
    "plugins.colorizer",
    "plugins.colorscheme",
    "plugins.conform",
    "plugins.debugger",
    "plugins.diffview",
    "plugins.gitsigns",
    "plugins.indent-blankline",
    "plugins.lspconfig",
    "plugins.markdown",
    "plugins.nvim-web-devicons",
    "plugins.rainbow-delimiters",
    "plugins.rust",
    "plugins.statusline",
    "plugins.telescope",
    "plugins.treesitter",
    "plugins.typst",
    "plugins.which-key",
    "plugins.yazi",
}

local function to_src(repo)
    return { src = "https://github.com/" .. repo }
end

local function normalize(item)
    if type(item) == "string" then
        return to_src(item)
    end

    if item.repo then
        local copy = vim.tbl_extend("force", {}, item)
        copy.src = "https://github.com/" .. item.repo
        copy.repo = nil
        return copy
    end

    return item
end

local function collect_packages()
    local list = {}
    local seen = {}
    for _, name in ipairs(modules) do
        local mod = require(name)
        local items = mod.plugins or mod.plugin or {}
        if type(items) == "string" then
            items = { items }
        end
        for _, item in ipairs(items) do
            local entry = normalize(item)
            if entry and entry.src then
                if not seen[entry.src] then
                    seen[entry.src] = true
                    table.insert(list, entry)
                end
            else
                table.insert(list, entry)
            end
        end
    end
    return list
end

local M = {}
M.packages = collect_packages()

function M.setup()
    for _, name in ipairs(modules) do
        local mod = require(name)
        if type(mod.setup) == "function" then
            mod.setup()
        end
    end
end

return M
