return {
  "olimorris/codecompanion.nvim",
  config = function()
    require("codecompanion").setup {

      strategies = {
        chat = { adapter = "ollama" },
        inline = { adapter = "ollama" },
        agent = { adapter = "ollama" },
      },

      adapters = {
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            env = {
              url = "http://192.168.178.209:11434",
              -- api_key = "OLLAMA_API_KEY",
            },
            headers = {
              ["Content-Type"] = "application/json",
              -- ["Authorization"] = "Bearer ${api_key}",
            },
            parameters = {
              sync = true,
            },

            schema = {
              model = {
                default = "llama3.2:latest",
              },
            },
          })
        end,
      },
    }
  end,
}
