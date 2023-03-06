-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local wk = require("which-key")
local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<C-h>", require("smart-splits").move_cursor_left, { desc = "Go to left window", remap = true })
map("n", "<C-j>", require("smart-splits").move_cursor_down, { desc = "Go to lower window", remap = true })
map("n", "<C-k>", require("smart-splits").move_cursor_up, { desc = "Go to upper window", remap = true })
map("n", "<C-l>", require("smart-splits").move_cursor_right, { desc = "Go to right window", remap = true })

-- Gitsigns preview
map("n", "<leader>gp", "<cmd>Gitsigns preview_hunk<cr>", { desc = "Gitsigns preview" })
map("n", "<leader>ug", "<cmd>Gitsigns toggle_current_line_blame<cr>", { desc = "Toggle git blame" })

-- Neogit
map("n", "<leader>gg", "<cmd>Neogit<cr>", { desc = "Neogit (root dir)" })
map("n", "<leader>gG", "<cmd>Neogit cwd=<cwd><cr>", { desc = "Neogit (cwd)" })

-- DiffView
-- map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Open DiffView" })
-- map("n", "<leader>gD", "<cmd>DiffviewToggleFiles<cr>", { desc = "Toggle DiffView" })

-- ZenMode
map("n", "<leader>uz", "<cmd>ZenMode<cr>", { desc = "Toggle ZenMode" })

-- Overseer
map("n", "<leader>cT", "<cmd>OverseerToggle<cr>", { desc = "Toggle Task" })
map("n", "<leader>ct", "<cmd>OverseerRun<cr>", { desc = "Run Task" })

-- Oil
map("n", "<leader>fo", "<cmd>Oil<cr>", { desc = "Run Oil" })

-- Obsidian

-- wk.register({
--   o = {
--     name = "+obsidian", -- optional group name
--   },
-- }, { prefix = "<leader>" })
--
-- map("n", "<leader>of", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Find Obsidian Files" })
-- map("n", "<leader>fO", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Find Obsidian Files" })
-- map("n", "<leader>os", "<cmd>ObsidianSearch<cr>", { desc = "Search Obsidian" })
-- map("n", "<leader>os", "<cmd>ObsidianOpen<cr>", { desc = "Open Obsidian" })
-- map("n", "<leader>ow", "<cmd>ObsidianWorkspace<cr>", { desc = "Get Obsidian Workspace" })
