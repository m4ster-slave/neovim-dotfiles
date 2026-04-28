--global
function _G.select_session_with_telescope()
  local ok, persistence = pcall(require, "persistence")
  if not ok then
    vim.notify("persistence.nvim not available", vim.log.levels.ERROR)
    return
  end

  local pickers_ok, pickers = pcall(require, "telescope.pickers")
  if not pickers_ok then
    vim.notify("telescope.nvim not available", vim.log.levels.ERROR)
    return
  end

  local finders = require("telescope.finders")
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local sorter = require("telescope.config").values.generic_sorter({})

  local sessions = persistence.list()
  pickers.new({}, {
    prompt_title = "Select Session",
    finder = finders.new_table({ results = sessions }),
    sorter = sorter,
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        local session_name = selection[1] or selection.value
        persistence.load({ session = session_name })
      end)
      return true
    end,
  }):find()
end

-- create a user command
vim.api.nvim_create_user_command("SelectSession", function()
  _G.select_session_with_telescope()
end, { desc = "Pick persistence session" })

local M = {}

M.plugins = {
  "folke/persistence.nvim",
}

function M.setup()
  require("persistence").setup { need = 2 }
end

return M
