-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls" }

lspconfig.omnisharp.setup {
  cmd = { "OmniSharp", "--languageserver", "--hostPID", tostring(vim.fn.getpid()) },
  filetypes = { "cs" },
  root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
  settings = {
    omnisharp = {
      useGlobalMono = "always",
      enableRoslynAnalyzers = true,
      organizeImportsOnFormat = true,
      enableEditorConfigSupport = true,
    }
  }
}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "vscode-html-language-server", "--stdio" }, 
  }
end

lspconfig.omnisharp.setup {
    cmd = { "omnisharp" },
    on_attach = function(client, bufnr)
        -- Add any custom settings or key mappings here
    end,
    flags = {
        debounce_text_changes = 150,
    }
}

-- typescript
lspconfig.tsserver.setup {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}
