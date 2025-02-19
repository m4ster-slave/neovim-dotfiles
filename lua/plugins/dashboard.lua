return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    local dashboard = require("dashboard")
    local fortune_cowsay = function()
      local handle = io.popen "fortune /usr/share/fortune/leftist-quotes | cowsay -r "
      if not handle then
        return { "Error: could not run cowsay" }
      end
      local result = handle:read "*a"
      handle:close()

      if not result or result == "" then
        return { "Error: cowsay returned no output" }
      end

      local lines = {}
      for line in result:gmatch "[^\r\n]+" do
        table.insert(lines, line)
      end
      return #lines > 0 and lines or { "Error: No header to display" }
    end

    dashboard.setup({
      theme = 'doom',
      config = {
        header = fortune_cowsay(),
        center = {
          {
            icon = '󰑴 ',
            desc = 'School',
            key = 'School Notes',
            action = 'cd ~/Nextcloud/Notes/School/2024-25/'
          },
          {
            icon = '󰙨 ',
            desc = 'Projects',
            key = 'Projects Folder',
            action = 'cd ~/Nextcloud/Projects/'
          },
          {
            icon = ' ',
            desc = 'Find File',
            key = 'Spc f f',
            action = 'Telescope find_files'
          },
          {
            icon = '󰈚 ',
            desc = 'Recent Files',
            key = 'Spc f o',
            action = 'Telescope oldfiles'
          },
          {
            icon = '󰈭 ',
            desc = 'Find Word',
            key = 'Spc f w',
            action = 'Telescope live_grep'
          },
        },
        footer = {}
      }
    })
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } }
}
