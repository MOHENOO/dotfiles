return {
  -- { "olimorris/onedarkpro.nvim", lazy = false, priority = 1000 },
  -- { "shaunsingh/nord.nvim", lazy = false, priority = 1000 },
  -- { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        background = { -- :h background
          light = "latte",
          dark = "frappe",
        },
        integrations = {
          overseer = true,
        },
      })
    end,
  },
  -- {
  --   "LazyVim/LazyVim",
  --   opts = {
  --     colorscheme = "catppuccin",
  --   },
  -- },
  {
    "f-person/auto-dark-mode.nvim",
    lazy = false,
    priority = 1000,
    init = function()
      -- Get the current hour
      local current_hour = tonumber(os.date("%H"))

      -- Set the background based on the time of day
      if current_hour >= 8 and current_hour < 19 then
        vim.opt.background = "light"
        vim.cmd("colorscheme catppuccin-latte")
      else
        vim.opt.background = "dark"
        vim.cmd("colorscheme catppuccin-frappe")
      end
    end,
    config = {
      update_interval = 1000,
      set_dark_mode = function()
        vim.opt.background = "dark"
        vim.cmd("colorscheme catppuccin-frappe")
      end,
      set_light_mode = function()
        vim.opt.background = "light"
        vim.cmd("colorscheme catppuccin-latte")
      end,
    },
  },
}
