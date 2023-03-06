return {
  {
    "folke/zen-mode.nvim",
    dependencies = { "folke/twilight.nvim" },
    opts = {
      plugins = {
        twilight = { enabled = true },
        tmux = { enabled = true },
        wezterm = {
          enabled = true,
          -- can be either an absolute font size or the number of incremental steps
          font = "+0", -- (10% increase per step)
        },
      },
    },
  },
}
