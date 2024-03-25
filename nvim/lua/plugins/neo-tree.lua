return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      window = {
        auto_expand_width = true,
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
        },
      },
    },
  },
}
