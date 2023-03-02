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

-- TODO: diable autocheck in VSCode
require("lazy").setup({
  spec = {
    {
      "loichyan/DeltaVim",
      import = "deltavim.plugins",
    },
    { import = "plugins" },
    { import = "fixup" },
  },
  defaults = { lazy = true, version = false },
  checker = { enabled = true },
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
  ui = { border = BORDER_STYLE },
  change_detection = { enabled = false },
})
