return {
  {
    "Bekaboo/dropbar.nvim",
    -- optional, but required for fuzzy finder support
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
    },
  },
  -- {
  --   "utilyre/barbecue.nvim",
  --   name = "barbecue",
  --   version = "*",
  --   dependencies = {
  --     "SmiteshP/nvim-navic",
  --     "nvim-tree/nvim-web-devicons", -- optional dependency
  --   },
  --   opts = {
  --     -- configurations go here
  --   },
  -- },
  -- task runner and job management
  -- {
  --   "stevearc/overseer.nvim",
  --   enabled = false,
  --   dependencies = { "stevearc/dressing.nvim" },
  --   opts = {},
  -- },
  -- {
  --   "m4xshen/hardtime.nvim",
  --   dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
  --   opts = {
  --     disable_mouse = false, -- enable mouse
  --   },
  -- },
  {
    "stevearc/oil.nvim",
    opts = {},
    -- Optional dependencies
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup()
    end,
  },
}
