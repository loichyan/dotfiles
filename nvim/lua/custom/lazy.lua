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
  dev = {
    path = "~/dev/nvim",
  },
  spec = {
    {
      "loichyan/DeltaVim",
      dev = true,
      import = "deltavim.plugins",
    },
    { "DeltaVim", dev = true },
    { import = "plugins" },
    -- {
    --   name = "LazyVim",
    --   dir = "~/dev/lua/LazyVim",
    --   import = "lazyvim.plugins",
    -- },
    -- { "mason.nvim", enabled = false },
    -- { "mason-lspconfig.nvim", enabled = false },
    -- { "mini.indentscope", enabled = false },
  },
  defaults = { lazy = true, version = false },
  install = { missing = NOT_VSCODE, colorscheme = { COLORSCHEME } },
  checker = { enabled = false },
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
