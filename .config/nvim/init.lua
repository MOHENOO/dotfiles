-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.g.neovide then
  vim.o.guifont = "MonaspiceRn Nerd Font:h20"
  vim.g.neovide_scale_factor = 1.0

  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set("n", "<C-=>", function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set("n", "<C-->", function()
    change_scale_factor(1 / 1.25)
  end)

  -- vim.g.neovide_floating_blur_amount_x = 2.0
  -- vim.g.neovide_floating_blur_amount_y = 2.0

  -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
  -- vim.g.neovide_transparency = 0.0
  -- vim.g.transparency = 0.8

  vim.g.neovide_refresh_rate = 60

  vim.g.neovide_no_idle = true

  vim.g.neovide_profiler = false

  vim.g.neovide_cursor_antialiasing = false
end
