return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = "Telescope",

  opts = function()
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

    local opts =
    {
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
      extensions = {},
    }

    return opts
  end,
}
