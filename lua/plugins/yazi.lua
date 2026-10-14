local M = {}

M.plugins = {
    "mikavilpas/yazi.nvim",
}

function M.setup()
    local function set_yazi_highlights()
        vim.api.nvim_set_hl(0, "YaziFloat", { bg = "#1e2030" })
        vim.api.nvim_set_hl(0, "YaziFloatBorder", { bg = "#1e2030", fg = "#7aa2f7" })
    end

    -- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
    -- vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_yazi_highlights,
    })

    set_yazi_highlights()

    require("yazi").setup({
        open_for_directories = false,
        keymaps = {
            show_help = "<f1>",
            close = { "<Esc>", "q", "<c-n>" },
        },
        yazi_floating_window_winblend = 0,
        open_file_function = function(chosen_file, config, state)
            local ext = vim.fn.fnamemodify(chosen_file, ":e"):lower()

            if
                ext == "pdf"
                or vim.tbl_contains({
                    "png",
                    "jpg",
                    "jpeg",
                    "gif",
                    "webp",
                    "svg",
                    "bmp",
                    "tif",
                    "tiff",
                    "avif",
                }, ext)
            then
                vim.fn.jobstart({ "xdg-open", chosen_file }, {
                    detach = true,
                })
            else
                vim.cmd("edit " .. vim.fn.fnameescape(chosen_file))
            end
        end,
    })
end

return M
