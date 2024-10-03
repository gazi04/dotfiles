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

}, lazy_config)



-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "nvchad.autocmds"

-- local function setup_lsp()
--   require'lspconfig'.intelephense.setup{
--     settings = {
--       intelephense = {
--         files = {
--           maxSize = 5000000;
--         };
--       };
--     };
--   }
--
--   -- C# LSP setup (OmniSharp)
--   require'lspconfig'.omnisharp.setup{
--     cmd = { "/usr/bin/omnisharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
--     root_dir = require'lspconfig'.util.root_pattern("*.csproj", "*.sln"),
--     enable_editorconfig_support = true,
--     enable_msbuild_load_projects_on_demand = false,
--     enable_roslyn_analyzers = true,
--     organize_imports_on_format = true,
--     enable_import_completion = true,
--     sdk_include_prereleases = true,
--     analyze_open_documents_only = false,
--     on_attach = function(client, bufnr)
--       local buf_set_keymap = vim.api.nvim_buf_set_keymap
--       local opts = { noremap = true, silent = true }
--
--       buf_set_keymap(bufnr, "n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
--       buf_set_keymap(bufnr, "n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
--       buf_set_keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
--       buf_set_keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
--     end,
--     capabilities = require("cmp_nvim_lsp").default_capabilities(),
--   }
-- end

-- local function setup_dat()
--   local dap = require('dap')
--
--   dap.adapters.php = {
--     type = "executable",
--     command = "node",
--     args = { os.getenv("HOME") .. "/vscode-php-debug/out/phpDebug.js"}
--   }
--
--   dap.configurations.php = {
--     {
--       type = "php",
--       request = "launch",
--       name = "Listen for Xdebug",
--       port = 9003
--     }
--   }
--
--   dap.listeners.after.event_terminated["dapui_config"] = function()
--     require("dapui").close()
--   end
--
--   dap.listeners.after.event_exited["dapui_config"] = function()
--     require("dapui").close()
--   end
--
--
--   dap.adapters.coreclr = {
--     type = 'executable',
--     command = '/usr/bin/netcoredbg',
--     args = {'--interpreter=vscode'}
--   }
--
--   dap.configurations.cs = {
--     {
--       type = 'coreclr',
--       name = 'Launch',
--       request = 'launch',
--       program = function()
--         return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '/bin/Debug/net8.0/', 'file')
--       end,
--     },
--   }
-- end

vim.schedule(function()
  -- setup_dat()
  require "mappings"
  -- setup_lsp()
end)
