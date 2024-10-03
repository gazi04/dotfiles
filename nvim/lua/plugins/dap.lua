return {
  "mfussenegger/nvim-dap",
  lazy = false,
  depedencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio"},
  config = function()
    local dap = require("dap")

    -- PHP DAP CONFIGURATION
    dap.adapters.php = {
      type = "executable",
      command = "node",
      args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js"}
    }

    dap.configurations.php = {
      {
        type = "php",
        request = "launch",
        name = "Listen for Xdebug",
        port = 9003
      }
    }

    dap.listeners.after.event_terminated["dapui_config"] = function()
      require("dapui").close()
    end

    dap.listeners.after.event_exited["dapui_config"] = function()
      require("dapui").close()
    end

    -- C-SHARP DAP CONFIGURATION
    dap.adapters.coreclr = {
      type = 'executable',
      command = '/usr/bin/netcoredbg',
      args = {'--interpreter=vscode'}
    }

    dap.configurations.cs = {
      {
        type = 'coreclr',
        name = 'Launch',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
        end,
      },
    }
    -- KEYMAP CONFIGURATION
    vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Start debugging"})
    vim.keymap.set("n", "<Leader>dd", dap.terminate, { desc = "Stop Debugging"})
    vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step Into"})
    vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step Over"})
    vim.keymap.set("n", "<Leader>du", dap.step_out, { desc = "Step Out"})
    vim.keymap.set("n", "<Leader>db", dap.step_back, { desc = "Step Back"})

    vim.keymap.set('n', '<leader>dq', function()
      require('dapui').close()
    end, { desc = "Close all DAP UI windows and buffers" })
  end,
}
