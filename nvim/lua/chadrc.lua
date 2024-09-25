-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "bearded-arc",

  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
	},
}

M.mason = {
    pkgs = {
        "lua-language-server",    -- Lua language server
        "intelephense",           -- PHP language server
        "prettier",               -- Prettier formatter
        "php-cs-fixer",           -- PHP Code Formatter
        "stylua",                 -- Lua formatter
        "html-lsp",               -- HTML LSP
        "css-lsp",                -- CSS LSP
        -- Add more as needed...
    }
}

return M
