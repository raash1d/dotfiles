return {
  "folke/snacks.nvim",
  event = "VeryLazy",
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
          ignored = true,
          formatters = {
            file = {
              filename_first = true,
            },
          },
          ui_select = {
            hidden = true,
          },
        },
      },
    },
  },
}
