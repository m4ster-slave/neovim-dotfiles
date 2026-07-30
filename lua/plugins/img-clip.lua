local M = {}

M.plugins = {
    "HakonHarnes/img-clip.nvim",
}

function M.setup()
    pcall(function()
        require("img-clip").setup({
            default = {
                dir_path = "assets",
                relative_to_current_file = true,

                filetypes = {
                    typst = {
                        template = '#image("$FILE_PATH", width: 80%)',
                    },
                },
            },
        })
    end)

    vim.keymap.set("n", "<leader>p", "<cmd>PasteImage<cr>", { desc = "Paste image from system clipboard" })
end

return M
