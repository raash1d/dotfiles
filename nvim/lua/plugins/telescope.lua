return {
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--follow", -- Follow symbolic links
          "--hidden", -- Search for hidden files
          "--no-ignore-vcs", -- Don't respect .gitignore
          "--no-heading", -- Don't group matches by each file
          "--with-filename", -- Print the file path with the matched lines
          "--line-number", -- Show line numbers
          "--column", -- Show column numbers
          "--smart-case", -- Smart case search

          -- Exclude some patterns from search
          "--glob=!**/.git/*",
          -- "--glob=!**/.idea/*",
          -- "--glob=!**/.vscode/*",
          -- "--glob=!**/build/*",
          -- "--glob=!**/dist/*",
          -- "--glob=!**/yarn.lock",
          -- "--glob=!**/package-lock.json",
        },
      },
    },
  },
}
