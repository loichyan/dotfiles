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

local colorscheme = "default"
if NOT_VSCODE then
  colorscheme = "tokyonight"
end

require("lazy").setup({
  spec = {
    -- Add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins", opts = {
      colorscheme = colorscheme,
    } },
    -- Import my custom plugins
    { import = "plugins" },
  },
  defaults = {
    -- All plugins will be lazy-loaded.
    lazy = true,
    -- Always use the latest git commit
    version = false,
  },
  install = { colorscheme = { colorscheme } },
  checker = { enabled = true }, -- automatically check for plugin updates
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
})
