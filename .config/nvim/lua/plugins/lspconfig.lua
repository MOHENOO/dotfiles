return {
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      inlay_hints = {
        enabled = true,
      },
      codelens = {
        enabled = true,
      },
      ---@type lspconfig.options
    },
  },
}
