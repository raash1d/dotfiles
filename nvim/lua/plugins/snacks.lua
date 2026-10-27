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
  config = function(_, opts)
    require("snacks").setup(opts)

    -- Override highlight groups to make hidden/ignored files appear like regular files/directories
    -- SnacksPickerFile links to "" (empty string = no special highlight, normal text)
    -- SnacksPickerPathHidden links to "NonText" (greyed out)
    -- We need to break the link and make PathHidden/PathIgnored have no special styling
    local function fix_hidden_highlights()
      -- Force clear and redefine the highlights to break any links
      -- Use vim.cmd with ! to force override
      vim.cmd("hi! clear SnacksPickerPathHidden")
      vim.cmd("hi! clear SnacksPickerPathIgnored")

      -- Define them with no attributes - this makes them transparent
      -- so they inherit the normal text color (same as SnacksPickerFile)
      vim.cmd("hi! SnacksPickerPathHidden guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE")
      vim.cmd("hi! SnacksPickerPathIgnored guifg=NONE guibg=NONE ctermfg=NONE ctermbg=NONE")
    end

    -- Use schedule to ensure it runs after snacks sets up its highlights
    vim.schedule(fix_hidden_highlights)

    -- Also set on ColorScheme change to persist across theme changes
    vim.api.nvim_create_autocmd("ColorScheme", {
      callback = fix_hidden_highlights,
    })

    -- Fix highlights when picker buffers are created and when they're rendered
    vim.api.nvim_create_autocmd({ "FileType", "BufWinEnter" }, {
      pattern = "snacks_picker_list",
      callback = function()
        vim.schedule(function()
          fix_hidden_highlights()
          -- Also fix after a short delay to catch any late highlight applications
          vim.defer_fn(fix_hidden_highlights, 50)
        end)
      end,
    })

    -- Also fix on TextChanged to catch dynamic updates
    vim.api.nvim_create_autocmd("TextChanged", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "snacks_picker_list" then
          fix_hidden_highlights()
        end
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "snacks_notification_history",
      callback = function()
        vim.wo.wrap = true
        vim.wo.linebreak = true
        vim.wo.breakindent = true
      end,
    })
  end,
}
