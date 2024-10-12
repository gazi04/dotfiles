return {
  "neovim/nvim-lspconfig",
  config = function()
    require("nvchad.configs.lspconfig").defaults()
    require "configs.lspconfig"

    local lspconfig = require("lspconfig")

    lspconfig.intelephense.setup {
      capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
      on_attach = function(client, bufnr)
        -- Additional setup or keybindings can go here
      end,
      root_dir = lspconfig.util.root_pattern("composer.json", ".git"), -- or appropriate root
    }
  end,
}
