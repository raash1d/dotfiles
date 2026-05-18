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
        explorer = {
          hidden = true,
          ignored = true,
        },
      },
    },
    styles = {
      notification = {
        wo = {
          wrap = true, -- wrap text in notifications
          linebreak = true, -- wrap at word boundaries
          breakindent = true, -- preserve indentation when wrapping
        },
      },
      notification_history = {
        wo = {
          wrap = true,
          linebreak = true,
          breakindent = true,
        },
      },
    },
  },
}
