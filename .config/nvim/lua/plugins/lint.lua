return {
  "mfussenegger/nvim-lint",
  optional = true,
  opts = {
    linters_by_ft = {
      go = { "golangcilint" },
      bash = { "shellcheck" },
      sh = { "shellcheck" },
      yaml = { "yamllint" },
      zsh = { "zsh" },
      markdown = { "markdownlint" },
      json = { "jsonlint" },
    },
  },
}
