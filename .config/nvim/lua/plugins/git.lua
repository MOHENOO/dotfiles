return {
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      current_line_blame = true,
    },
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "nvim-telescope/telescope.nvim", -- optional
      "sindrets/diffview.nvim", -- optional
    },
    config = true,
    opts = {
      integrations = {
        diffview = true,
        telescope = true,
      },
    },
  },
}
