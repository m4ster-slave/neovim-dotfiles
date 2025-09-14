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
          "tinymist",
          "intelephense",
        },
      }
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      local ok, cmp_caps = pcall(require, "cmp_nvim_lsp")
      if ok then
        capabilities = cmp_caps.default_capabilities(capabilities)
      end

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
      lspconfig.intelephense.setup {
        capabilities = capabilities,
        init_option = {
          globalStoragePath = "/tmp/", -- i dont need this shit in my home dir
        }
      }
      lspconfig.yamlls.setup {
        capabilities = capabilities,
      }
      lspconfig.html.setup {
        capabilities = capabilities,
        filetypes = {
          "templ",
          "html",
          "javascriptreact",
          "typescriptreact",
          "jsx",
          "tsx",
          "php",
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
          "php",
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
      local ts = lspconfig.ts_ls or lspconfig.tsserver
      if ts and ts.setup then
        ts.setup {
          capabilities = capabilities,
        }
      end
      lspconfig.eslint.setup {
        capabilities = capabilities,
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
        root_dir = require("lspconfig").util.root_pattern(".clangd", "compile_commands.json", ".git"),
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
        capabilities = capabilities,
        settings = {
          python = {
            pythonPath = get_python_path(),
          },
        },
      }
      lspconfig.marksman.setup {
        capabilities = capabilities,
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
                  name = "JavaSE-21",
                  path = "/usr/lib/jvm/java-21-openjdk",
                  default = true,
                },
                {
                  name = "JavaSE-17",
                  path = "/usr/lib/jvm/java-17-openjdk",
                },
                {
                  name = "JavaSE-11",
                  path = "/usr/lib/jvm/java-11-openjdk",
                },
              },
              imports = {
                gradle = {
                  wrapper = {
                    checksums = {
                      {
                        sha256 = "7d34ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172",
                        allowed = true
                      }
                    }
                  }
                }
              }
            },
          },
        },
      }
    end,
  },
}
