local M = {}
M.plugins = {
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
}

---@diagnostic disable: missing-fields
function M.setup()
    local dap = require("dap")
    local dapui = require("dapui")

    -- mason-nvim-dap handles adapter setup FOR you.
    -- Don't define dap.adapters.codelldb manually — let this do it.
    require("mason-nvim-dap").setup({
        ensure_installed = { "codelldb" },
        automatic_installation = true,
        handlers = {
            function(config)
                require("mason-nvim-dap").default_setup(config)
            end,
        },
    })

    -- Rust configuration
    dap.configurations.rust = {
        {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = function()
                vim.fn.system("cargo build")
                if vim.v.shell_error ~= 0 then
                    vim.notify("cargo build failed", vim.log.levels.ERROR)
                end
                local binary_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
                local binary_path = vim.fn.getcwd() .. "/target/debug/" .. binary_name
                if vim.fn.executable(binary_path) == 0 then
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
                end
                return binary_path
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = {},
        },
    }

    -- DAP UI
    dapui.setup()

    dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
    end

    -- Keybinds
    vim.keymap.set("n", "<F5>", dap.continue, { desc = "DAP Continue" })
    vim.keymap.set("n", "<F10>", dap.step_over, { desc = "DAP Step Over" })
    vim.keymap.set("n", "<F11>", dap.step_into, { desc = "DAP Step Into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "DAP Step Out" })
    vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP Open REPL" })
end

return M
