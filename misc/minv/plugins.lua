local M = {}

---@return boolean
local function not_vscode()
  return vim.g.vscode == nil
end

---@param minv MiNV
function M.setup(minv)
  local plugins = minv.plugins

  plugins.theme.plug
    :spec({ cond = not_vscode })
    :spec_of("folke/tokyonight.nvim", {
      cond = function()
        return false
      end,
    })
    :extend({
      {
        "ful1e5/onedark.nvim",
        config = function()
          require("onedark").setup({})
        end,
      },
    })
  plugins.treesitter.plug:extend({
    {
      "windwp/nvim-autopairs",
      config = function()
        require("custom.autopairs").setup()
        require("cmp").event:on(
          "confirm_done",
          require("nvim-autopairs.completion.cmp").on_confirm_done()
        )
      end,
    },
    {
      "windwp/nvim-ts-autotag",
      config = function()
        require("nvim-treesitter").define_modules({
          autotag = {
            enable = true,
          },
        })
      end,
    },
    {
      "andymass/vim-matchup",
      config = function()
        require("nvim-treesitter").define_modules({
          matchup = {
            enable = true,
          },
        })
      end,
    },
    {
      "p00f/nvim-ts-rainbow",
      cond = not_vscode,
      config = function()
        local c = require("onedark.colors").setup({})
        require("nvim-treesitter").define_modules({
          rainbow = {
            enable = true,
            extended_mode = true,
            colors = {
              c.red0,
              c.yellow0,
              c.blue0,
              c.purple0,
              c.green0,
              c.orange0,
              c.cyan0,
            },
          },
        })
      end,
    },
  })
  plugins.lsp.plug:spec({ cond = not_vscode }):extend({
    { "folke/lua-dev.nvim" },
  })
  plugins.cmp.plug:spec({ cond = not_vscode }):extend({
    { "hrsh7th/cmp-nvim-lsp-signature-help" },
  })
  plugins.telescope.plug:spec({ cond = not_vscode })
  plugins.ui.plug:spec({ cond = not_vscode }):extend({
    -------------------
    -- UI Enhancment --
    -------------------
    { "nacro90/numb.nvim" },
    {
      "kevinhwang91/nvim-bqf",
      config = function()
        require("bqf").setup({
          func_map = {
            pscrollup = "<C-u>",
            pscrolldown = "<C-d>",
          },
        })
      end,
    },
    {
      "folke/todo-comments.nvim",
      config = function()
        require("todo-comments").setup({})
      end,
    },
    {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require("colorizer").setup({ "*" })
      end,
    },
    {
      "rcarriga/nvim-notify",
      config = function()
        vim.notify = require("notify")
        vim.notify.setup({ max_width = 70 })
        require("telescope").load_extension("notify")
      end,
    },
    {
      "j-hui/fidget.nvim",
      config = function()
        require("fidget").setup({})
      end,
    },
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("indent_blankline").setup({
          filetype_exclude = {
            "alpha",
            "NvimTree",
            "",
            "lspinfo",
            "toggleterm",
            "packer",
          },
          show_current_context = true,
          use_treesitter = true,
        })
      end,
    },
    {
      "stevearc/dressing.nvim",
      config = function()
        require("dressing").setup({})
      end,
    },
    ----------------
    -- Git helper --
    ----------------
    {
      "TimUntersberger/neogit",
      config = function()
        require("neogit").setup({
          integrations = {
            diffview = true,
          },
        })
      end,
    },
    {
      "sindrets/diffview.nvim",
      config = function()
        local actions = require("diffview.config").actions
        require("diffview").setup({
          enhanced_diff_hl = true,
          file_panel = {
            win_config = {
              width = 30,
            },
          },
          key_bindings = {
            view = {
              ["q"] = "<Cmd>DiffviewClose<CR>",
              ["<C-b>"] = actions.toggle_files,
              ["<C-n>"] = actions.focus_files,
            },
            file_panel = {
              ["q"] = "<Cmd>DiffviewClose<CR>",
              ["<C-b>"] = actions.toggle_files,
              ["<C-n>"] = actions.focus_files,
            },
            file_history_panel = {
              ["q"] = "<Cmd>DiffviewClose<CR>",
              ["<C-b>"] = actions.toggle_files,
              ["<C-n>"] = actions.focus_files,
            },
          },
        })
      end,
    },
  })
  plugins.extra:extend({
    -------------------------------
    -- Better editing experience --
    -------------------------------
    { "tpope/vim-surround" },
    { "tpope/vim-repeat" },
    {
      "ggandor/leap.nvim",
      config = function()
        require("leap").set_default_keymaps()
      end,
    },
    { "tpope/vim-sleuth" },
    { "famiu/bufdelete.nvim", cond = not_vscode },
    -----------------------
    -- Project & Session --
    -----------------------
    {
      "ahmedkhalf/project.nvim",
      cond = not_vscode,
      config = function()
        require("project_nvim").setup({
          ignore_lsp = { "null-ls" },
        })
        require("telescope").load_extension("projects")
      end,
    },
    {
      "Shatur/neovim-session-manager",
      cond = not_vscode,
      config = function()
        require("session_manager").setup({
          autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
        })
      end,
    },
  })
end

return M
