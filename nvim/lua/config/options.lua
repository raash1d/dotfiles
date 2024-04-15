-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.filetype.add({
  filename = {
    ["requirements.txt"] = "config",
  },
  pattern = {
  },
})

-- remove concealing information
-- added the following specifically for markdown but may have effects on other files, which is fine
vim.wo.conceallevel = 0
