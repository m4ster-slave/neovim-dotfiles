local M = {}

M.plugins = {
    "nanozuki/tabby.nvim",
}

function M.setup()
    -- always show the tabline, even with a single tab open
    vim.o.showtabline = 2

    -- theme references highlight groups, not hex -> follows whatever
    -- colorscheme.lua sets, no hardcoding, no re-styling on theme swap
    local theme = {
        fill = "TabLineFill",
        head = "TabLine",
        current_tab = "TabLineSel",
        tab = "TabLine",
        tail = "TabLine",
    }

    require("tabby").setup({
        line = function(line)
            return {
                -- top-left: swap the default vim-logo head for something fun
                { { " 🫪 ", hl = theme.head }, line.sep("", theme.head, theme.fill) },

                line.tabs().foreach(function(tab)
                    local hl = tab.is_current() and theme.current_tab or theme.tab
                    return {
                        line.sep("", hl, theme.fill),
                        tab.is_current() and "🐸" or "",
                        tab.number(),
                        tab.name(),
                        -- no tab.close_btn() here -> no 'x' on tabs
                        line.sep("", hl, theme.fill),
                        hl = hl,
                        margin = " ",
                    }
                end),

                -- no line.wins_in_tab(...) block -> no per-buffer names listed
                -- no tail element -> no file icon top right

                line.spacer(),
                hl = theme.fill,
            }
        end,
    })

    -- complements your existing <leader>j/k/n tab nav
    vim.keymap.set("n", "<leader>tr", "<cmd>Tabby rename_tab<CR>", { desc = "Rename current tab" })
    vim.keymap.set("n", "<leader>tp", "<cmd>Tabby pick_window<CR>", { desc = "Pick window across tabs" })
    vim.keymap.set("n", "<leader>tj", "<cmd>Tabby jump_to_tab<CR>", { desc = "Jump to tab by key" })

    -- persist tab layout + names across sessions (pairs with persistence.nvim)
    vim.opt.sessionoptions:append({ "tabpages", "globals" })
end

return M
