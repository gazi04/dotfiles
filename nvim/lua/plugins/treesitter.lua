return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false;
  opts = {
    ensure_installed = {
      "vim", "lua", "vimdoc",
      "html", "css", "json",
      "c_sharp", "diff", "php",
      "arduino"
    },
    higlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    context_commentstring = {
      enable = true,
      enable_autocmd = false,
    },
  },
}
