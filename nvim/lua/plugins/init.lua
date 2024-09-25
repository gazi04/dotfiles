return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    lazy = false,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false;
    opts = {
      ensure_installed = {
        "vim", "lua", "vimdoc",
        "html", "css",
      },
    },
  },

  {
    "phpactor/phpactor",
    lazy = false;
    run = "composer install --no-dev --optimize-autoloader",
  },

  { 'nicholasmata/nvim-dap-cs', lazy=false, dependencies = { 'mfussenegger/nvim-dap' } },

  {
    "L3MON4D3/LuaSnip",
    lazy = false,
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },


  -- {
  --   "mfussenegger/nvim-dap",
  --   depedencies = {
  --     "rcarriga/nvim-dap-ui",
  --     "nvim-neotest/nvim-nio"
  --   },
  --   lazy = false,
  --   config = function()
  --     local dap = require("dap")
  --     local dapui = require("dap.ui")
  --     dapui.setup
  --
  --     dap.listeners.before.attach.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.launch.dapui_config = function()
  --       dapui.open()
  --     end
  --     dap.listeners.before.event_terminated.dapui_config = function()
  --       dapui.close()
  --     end
  --     dap.listeners.before.event_exited.dapui_config = function()
  --       dapui.close()
  --     end
  --
  --     vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
  --     vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Start debugging"})
  --   end,
  -- },
  --
  -- {
  --   "rcarriga/nvim-dap-ui",
  --   lazy = false,
  --   depedencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  --   config = function()
  --     require("dapui").setup()
  --   end,
  -- },
  --
  -- {
  --   "nvim-neotest/nvim-nio",  -- Add this line to install nvim-nio
  --   lazy = false,
  -- },
}

