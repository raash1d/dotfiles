return {
  "hedyhli/outline.nvim",
  config = function()
    require("outline").setup({
      outline_window = {
        auto_jump = true,
      },
      providers = {
        priority = { "lsp", "coc", "markdown", "norg", "man", "treesitter" },
      },
    })
  end,
  event = "VeryLazy",
  dependencies = {
    "epheien/outline-treesitter-provider.nvim",
  },
}
