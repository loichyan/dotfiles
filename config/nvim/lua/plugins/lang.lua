-- Language specified plugins

return {
  {
    "Saecki/crates.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      popup = { border = "rounded" },
      null_ls = {
        enabled = true,
      },
    },
  },
}
