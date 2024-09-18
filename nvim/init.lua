vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
      require "options"
    end,
  },

  { import = "plugins" },

  { "OmniSharp/omnisharp-vim",
    lazy = false,
    config = function ()
      vim.g.OmniSharp_server_stdio = 1
    end
  },
  { "neoclide/coc.nvim", lazy=false, branch = "release" },
  { "mfussenegger/nvim-dap", lazy = false },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },

  {
    "mfussenegger/nvim-dap",
    lazy = false,
    depedencies = { "rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      vim.keymap.set("n", "<Leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
      vim.keymap.set("n", "<Leader>dc", dap.continue, { desc = "Start debugging"})
      vim.keymap.set("n", "<Leader>dd", dap.terminate, { desc = "Stop Debugging"})
      vim.keymap.set("n", "<Leader>di", dap.step_into, { desc = "Step Into"})
      vim.keymap.set("n", "<Leader>do", dap.step_over, { desc = "Step Over"})
      vim.keymap.set("n", "<Leader>du", dap.step_out, { desc = "Step Out"})
      vim.keymap.set("n", "<Leader>db", dap.step_back, { desc = "Step Back"})
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    lazy = false,
    config = function()
      local dapui = require("dapui")
      local dap = require("dap")

      dapui.setup()

      dap.listeners.before.attach.dapui_config = function() dapui.open() end
      dap.listeners.before.launch.dapui_config = function() dapui.open() end
      dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
     dap.listeners.before.event_exited.dapui_config = function() dapui.close() end
    end,
  },

  {
    "nvim-neotest/nvim-nio",
    lazy = false,
  },
}, lazy_config)

require("dap").configurations.php = {
  {
    type = "php",
    request = "launch",
    name = "Listen for Xdebug",
    port = 9003
  }
}


-- require('dap-cs').setup()

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

local function setup_lsp()
  require'lspconfig'.intelephense.setup{
    settings = {
      intelephense = {
        files = {
          maxSize = 5000000;
        };
      };
    };
  }

  -- C# LSP setup (OmniSharp)
  require'lspconfig'.omnisharp.setup{
    cmd = { "/usr/bin/omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
    root_dir = require'lspconfig'.util.root_pattern("*.csproj", "*.sln"),
    enable_editorconfig_support = true,
    enable_msbuild_load_projects_on_demand = false,
    enable_roslyn_analyzers = true,
    organize_imports_on_format = true,
    enable_import_completion = true,
    sdk_include_prereleases = true,
    analyze_open_documents_only = false,
    on_attach = function(client, bufnr)
      local buf_set_keymap = vim.api.nvim_buf_set_keymap
      local opts = { noremap = true, silent = true }

      buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
      buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
      buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
      buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    end,
    capabilities = require("cmp_nvim_lsp").default_capabilities(),
  }
end

local function setup_dat()
  local dap = require('dap')

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
end

vim.schedule(function()
  setup_dat()
  require "mappings"
  setup_lsp()
end)
