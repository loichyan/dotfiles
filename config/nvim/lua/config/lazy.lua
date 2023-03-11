-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- {
    --   "LazyVim/LazyVim",
    --   import = "lazyvim.plugins",
    -- },
    {
      "loichyan/DeltaVim",
      dir = "~/devel/lua/DeltaVim",
      import = "deltavim.plugins",
    },
    { import = "plugins" },
    { import = "fixup" },
  },
  defaults = { lazy = true, version = false },
  install = { missing = NOT_VSCODE, colorscheme = { "catppuccin" } },
  checker = { enabled = NOT_VSCODE },
  performance = {
    rtp = {
      -- Disable some rtp plugins
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
  ui = { border = "rounded" },
  change_detection = { enabled = false },
})
