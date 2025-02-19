return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup {
        PATH = "prepend",
      }
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "rust_analyzer",
          "gopls",
          "templ",
          "html",
          "cssls",
          "emmet_language_server",
          "htmx",
          "tailwindcss",
          "ts_ls",
          "pylsp",
          "clangd",
          "prismals",
          "yamlls",
          "jsonls",
          "eslint",
          "zls",
          "marksman",
          "sqlls",
          "wgsl_analyzer",
          "jdtls",
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require "lspconfig"
      lspconfig.zls.setup {
        capabilities = capabilities,
        cmd = { "zls" },
      }
      lspconfig.hls.setup {
        capabilities = capabilities,
        -- on_attach = function()
        -- 	vim.cmd([[
        --     augroup LspFormatting
        --       autocmd! * <buffer>
        --       autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
        --     augroup END
        --   ]])
        -- end,
      }
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
        settings = {
          Lua = {
            runtime = {
              -- Tell the language server which version of Lua you're using for Neovim
              version = "LuaJIT",
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = { "vim" },
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false, -- Optional, suppresses some warnings about workspace settings
            },
            telemetry = {
              enable = false, -- Disable telemetry data
            },
          },
        },
      }
      lspconfig.wgsl_analyzer.setup {
        capabilities = capabilities,
      }
      lspconfig.jsonls.setup {
        capabilities = capabilities,
      }
      lspconfig.gopls.setup {
        capabilities = capabilities,
      }
      lspconfig.cssls.setup {
        capabilities = capabilities,
      }
      lspconfig.prismals.setup {
        capabilities = capabilities,
      }
      lspconfig.yamlls.setup {
        capabilities = capabilities,
      }
      lspconfig.html.setup {
        capabilities = capabilities,
        filetypes = {
          "templ",
          "html",
          "css",
          "javascriptreact",
          "typescriptreact",
          "javascript",
          "typescript",
          "jsx",
          "tsx",
        },
      }
      lspconfig.htmx.setup {
        capabilities = capabilities,
        filetypes = { "html", "templ" },
      }
      lspconfig.emmet_language_server.setup {
        capabilities = capabilities,
        filetypes = {
          "templ",
          "html",
          "css",
          "javascriptreact",
          "typescriptreact",
          "javascript",
          "typescript",
          "jsx",
          "tsx",
        },
      }
      lspconfig.tailwindcss.setup {
        capabilities = capabilities,
        filetypes = {
          "templ",
          "html",
          "css",
          "javascriptreact",
          "typescriptreact",
          "javascript",
          "typescript",
          "jsx",
          "tsx",
        },
        root_dir = require("lspconfig").util.root_pattern(
          "tailwind.config.js",
          "tailwind.config.cjs",
          "tailwind.config.mjs",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.cjs",
          "postcss.config.mjs",
          "postcss.config.ts",
          "package.json",
          "node_modules",
          ".git"
        ),
      }
      lspconfig.templ.setup {
        capabilities = capabilities,
        filetypes = { "templ" },
      }
      local configs = require "lspconfig.configs"
      if not configs.ts_ls then
        configs.ts_ls = {
          default_config = {
            capabilties = capabilities,
            filetypes = {
              "javascript",
              "javascriptreact",
              "typescript",
              "typescriptreact",
              "html",
            },
          },
        }
      end
      lspconfig.ts_ls.setup {
        -- capabilties = capabilities,
        -- filetypes = {
        --   "javascript",
        --   "javascriptreact",
        --   "typescript",
        --   "typescriptreact",
        --   "html",
        -- },
      }
      lspconfig.eslint.setup {
        capabilties = capabilities,
      }

      require("lspconfig").clangd.setup {
        cmd = {
          "clangd",
          "--background-index",
          "--pch-storage=memory",
          "--all-scopes-completion",
          "--pretty",
          "--header-insertion=never",
          "-j=4",
          "--inlay-hints",
          "--header-insertion-decorators",
          "--function-arg-placeholders",
          "--completion-style=detailed",
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = require("lspconfig").util.root_pattern "src",
        init_option = { fallbackFlags = { "-std=c++2a" } },
        capabilities = capabilities,
      }

      local function get_python_path()
        -- Check if there's an active virtual environment
        local venv_path = os.getenv "VIRTUAL_ENV"
        if venv_path then
          return venv_path .. "/bin/python3"
        else
          return "/usr/bin/python3"
        end
      end

      lspconfig.pylsp.setup {
        capabilties = capabilities,
        settings = {
          python = {
            pythonPath = get_python_path(),
          },
        },
      }

      lspconfig.marksman.setup {
        capabilties = capabilities,
      }
      lspconfig.jdtls.setup {
        cmd = { "jdtls" },
        root_dir = require("lspconfig").util.root_pattern(".git", "build.gradle", "pom.xml"),
        settings = {
          java = {
            home = "~/.local/share/nvim/java/",
            configuration = {
              runtimes = {
                {
                  name = "JavaSE-23",
                  path = "/usr/lib/jvm/java-23-openjdk",
                },
                {
                  name = "JavaSE-17",
                  path = "/usr/lib/jvm/java-17-openjdk",
                  default = true,
                },
                {
                  name = "JavaSE-11",
                  path = "/usr/lib/jvm/java-11-openjdk",
                },
              },
            },
          },
        },
      }
    end,
  },
  {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = function()
      require("lsp_lines").setup()
    end,
  },
}
