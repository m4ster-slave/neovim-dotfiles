local M = {}

M.plugins = {
    "nvim-telescope/telescope.nvim",
    { src = "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}

function M.setup()
    local find_command

    if vim.fn.executable("rg") == 1 then
        find_command = { "rg", "--files", "--color=never" }
    elseif vim.fn.executable("fd") == 1 then
        find_command = { "fd", "--type", "f", "--color", "never" }
    elseif vim.fn.executable("fdfind") == 1 then
        find_command = { "fdfind", "--type", "f", "--color", "never" }
    else
        find_command = { "find", ".", "-type", "f" }
    end

    require("telescope").setup({
        defaults = {
            prompt_prefix = "   ",
            selection_caret = " ",
            entry_prefix = " ",
            sorting_strategy = "ascending",
            layout_config = {
                horizontal = {
                    prompt_position = "top",
                    preview_width = 0.55,
                },
                width = 0.87,
                height = 0.80,
            },
            mappings = {
                n = { ["q"] = require("telescope.actions").close },
            },
        },
        pickers = {
            find_files = {
                find_command = find_command,
            },
        },

        extensions_list = { "themes", "terms" },
        extensions = {
            fzf = {
                fuzzy = true, -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true, -- override the file sorter
                case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
        },
    })

    require("telescope").load_extension("fzf")
end

return M
