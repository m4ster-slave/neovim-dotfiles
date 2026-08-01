local M = {}

M.plugins = {
    "nvim-lualine/lualine.nvim",
}

-- component: currently attached LSP clients for THIS buffer (not global)
local function lsp_clients()
    local bufnr = vim.api.nvim_get_current_buf()
    local clients = vim.lsp.get_clients({ bufnr = bufnr })
    if #clients == 0 then
        return ""
    end
    local names = {}
    for _, c in ipairs(clients) do
        table.insert(names, c.name)
    end
    return " " .. table.concat(names, ",")
end

-- component: macro recording indicator
local function recording()
    local reg = vim.fn.reg_recording()
    if reg == "" then
        return ""
    end
    return "  @" .. reg
end

-- component: search match count while hlsearch is active
local function search_count()
    if vim.v.hlsearch == 0 then
        return ""
    end
    local ok, count = pcall(vim.fn.searchcount, { maxcount = 999 })
    if not ok or count.current == nil or count.total == 0 then
        return ""
    end
    return string.format(" %d/%d", count.current, count.total)
end

-- component: word count, only shown for prose filetypes where it's actually useful
local function word_count()
    local ft = vim.bo.filetype
    if ft ~= "markdown" and ft ~= "text" and ft ~= "typst" then
        return ""
    end
    return "  " .. vim.fn.wordcount().words .. "w"
end

function M.setup()
    require("lualine").setup({
        options = {
            theme = "auto", -- reads colors from the active colorscheme's highlight groups, no hardcoding
            icons_enabled = true,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
            globalstatus = true, -- single statusline for all splits, matches your laststatus = 3
            disabled_filetypes = { statusline = { "dashboard", "alpha" } },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                "branch",
                {
                    "diff",
                    symbols = { added = " ", modified = "󰝤 ", removed = " " },
                },
                {
                    "diagnostics",
                    symbols = { error = " ", warn = " ", info = " ", hint = "󰌵 " },
                },
            },
            lualine_c = {
                {
                    "filename",
                    path = 1, -- relative path, so you can tell files apart across dirs
                    symbols = { modified = " ●", readonly = " 󰌾", unnamed = "[No Name]" },
                },
                { recording, color = { fg = "#e0af68", gui = "bold" } },
                { search_count },
            },
            lualine_x = {
                { word_count },
                { lsp_clients, icon = "󰒋" },
                "filetype",
            },
            lualine_y = { "encoding", "fileformat" },
            lualine_z = { "progress", "location" },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = { { "filename", path = 1 } },
            lualine_x = { "location" },
            lualine_y = {},
            lualine_z = {},
        },
        extensions = { "quickfix", "man", "fugitive" },
    })
end

return M
