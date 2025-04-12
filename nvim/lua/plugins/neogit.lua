return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim", -- required
        "sindrets/diffview.nvim", -- optional - Diff integration

        -- Only one of these is needed.
        "ibhagwan/fzf-lua", -- optional
    },
    opts = {
        kind = "floating",
        commit_view = {
            kind = "floating",
        },
        commit_select_view = {
            kind = "floating",
        },
        commit_editor = {
            kind = "floating",
        },
        popup = {
            kind = "floating",
        },
        stash = {
            kind = "floating",
        },
    },
}
