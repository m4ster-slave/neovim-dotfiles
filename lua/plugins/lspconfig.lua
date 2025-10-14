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
          "csharp_ls",
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

      local util = require("lspconfig.util")
      local lsp = vim.lsp

      local function with_capabilities(cfg)
        cfg.capabilities = vim.tbl_deep_extend("force", {}, capabilities, cfg.capabilities or {})
        return cfg
      end

      local function python_path()
        local venv = vim.env.VIRTUAL_ENV
        return venv and (venv .. "/bin/python3") or "/usr/bin/python3"
      end

      local servers = {
        zls = with_capabilities { cmd = { "zls" } },
        hls = with_capabilities {},
        lua_ls = with_capabilities {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
        wgsl_analyzer = with_capabilities {},
        jsonls = with_capabilities {},
        gopls = with_capabilities {},
        cssls = with_capabilities {},
        prismals = with_capabilities {},
        intelephense = with_capabilities {
          init_options = { globalStoragePath = "/tmp/" },
        },
        yamlls = with_capabilities {},
        html = with_capabilities {
          filetypes = { "templ", "html", "javascriptreact", "typescriptreact", "jsx", "tsx", "php" },
        },
        htmx = with_capabilities { filetypes = { "html", "templ" } },
        emmet_language_server = with_capabilities {
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
        },
        tailwindcss = with_capabilities {
          filetypes = { "templ", "html", "css", "javascriptreact", "typescriptreact", "javascript", "typescript", "jsx", "tsx" },
          root_dir = util.root_pattern(
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
        },
        templ = with_capabilities { filetypes = { "templ" } },
        ts_ls = with_capabilities {},
        eslint = with_capabilities {},
        clangd = with_capabilities {
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
          root_dir = util.root_pattern(".clangd", "compile_commands.json", ".git"),
          init_options = { fallbackFlags = { "-std=c++2a" } },
        },
        pylsp = with_capabilities {
          settings = {
            python = { pythonPath = python_path() },
          },
        },
        marksman = with_capabilities {},
        jdtls = with_capabilities {
          cmd = { "jdtls" },
          root_dir = util.root_pattern(".git", "build.gradle", "pom.xml"),
          settings = {
            java = {
              home = "~/.local/share/nvim/java/",
              configuration = {
                runtimes = {
                  { name = "JavaSE-23", path = "/usr/lib/jvm/java-23-openjdk" },
                  { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk", default = true },
                  { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" },
                  { name = "JavaSE-11", path = "/usr/lib/jvm/java-11-openjdk" },
                },
                imports = {
                  gradle = {
                    wrapper = {
                      checksums = {
                        { sha256 = "7d34ac4de1c32b59bc6a4eb8ecb8e612ccd0cf1ae1e99f66902da64df296172", allowed = true },
                      },
                    },
                  },
                },
              },
            },
          },
        },
        csharp_ls = with_capabilities {
          root_dir = util.root_pattern("*.sln", "*.csproj", ".git"),
        },
      }

      for name, cfg in pairs(servers) do
        lsp.config[name] = vim.tbl_deep_extend("force", lsp.config[name] or {}, cfg)
        lsp.enable(name)
      end
    end,
  },
}
