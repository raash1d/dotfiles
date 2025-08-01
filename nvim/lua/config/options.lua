-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.filetype.add({
  filename = {
    ["requirements.txt"] = "config",
    [".prettierrc"] = "yaml",
  },
  pattern = {
    -- detect .localrc files as shell scripts
    [".*%.localrc"] = "sh",
    [".*%rc"] = "sh",
  },
})

-- Load local customizations if the file exists
-- Check for environment variable first, then fall back to default location
local local_options_path = vim.env.NVIM_LOCAL_OPTIONS or vim.fn.stdpath("config") .. "/lua/config/options-local.lua"
if vim.fn.filereadable(local_options_path) == 1 then
  -- Load the file directly using dofile since require expects a module path
  vim.cmd("source " .. vim.fn.fnameescape(local_options_path))
end

-- remove concealing information
-- added the following specifically for markdown but may have effects on other files, which is fine
vim.wo.conceallevel = 0

vim.api.nvim_set_hl(0, "@lsp.type.comment.cpp", {})
