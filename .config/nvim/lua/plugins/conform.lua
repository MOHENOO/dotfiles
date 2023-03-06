return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      bash = { "shfmt" },
      sh = { "shfmt" },
    },
  },
}
