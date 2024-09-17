vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.env.PATH = vim.env.PATH .. ':/usr/local/bin'


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
  {
    "neovim/nvim-lspconfig",
    lazy = false,
  },
  { "OmniSharp/omnisharp-vim",
    config = function ()
      vim.g.OmniSharp_server_stdio = 1
    end
  },
  { "neoclide/coc.nvim", branch = "release" },
  { "mfussenegger/nvim-dap", lazy = false },
}, lazy_config)

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
end

local dap = require('dap')

dap.adapters.php = {
  type = "executable",
  command = "node",
  args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js" }
}

dap.configurations.php = {
  {
    type = "php",
    request = "launch",
    name = "Listen for Xdebug",
    port = 9003
  }
}

vim.schedule(function()
  require "mappings"
  setup_lsp()
end)


