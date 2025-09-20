local function ensure_loaded(names)
  local ok, lazy = pcall(require, "lazy")
  if not ok then return end
  pcall(lazy.load, { plugins = names })
end

--global
function _G.select_session_with_telescope()
  ensure_loaded({ "folke/persistence.nvim", "nvim-telescope/telescope.nvim" })

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

return {
  "folke/persistence.nvim",
  event = "BufReadPre",
  opts = { need = 2 },
  config = function(_, opts)
    require("persistence").setup(opts)
  end,
}
