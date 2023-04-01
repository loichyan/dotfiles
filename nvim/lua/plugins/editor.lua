local Keymap = require("deltavim.core.keymap")
local Utils = require("deltavim.utils")

local function open_and_quit(state)
  local node = state.tree:get_node()
  state.commands["open_drop"](state)
  if not require("neo-tree.utils").is_expandable(node) then
    state.commands["close_window"](state)
  end
end

return {
  {
    "neo-tree.nvim",
    opts = {
      window = {
        mappings = { ["<CR>"] = open_and_quit },
      },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          never_show = { ".git" },
        },
      },
    },
  },
  {
    "which-key.nvim",
    opts = function(_, opts)
      return Utils.merge({}, opts, {
        groups = {
          mode = { "n", "x" },
          ["["] = { name = "+prev" },
          ["]"] = { name = "+next" },
          ["g"] = { name = "+goto" },
          ["gz"] = { name = "+surround" },
          ["<Leader>b"] = { name = "+buffer" },
          ["<Leader>f"] = { name = "+find" },
          ["<Leader>g"] = { name = "+git" },
          ["<Leader>l"] = { name = "+lsp" },
          ["<Leader>n"] = { name = "+notify" },
          ["<Leader>q"] = { name = "+session" },
          ["<Leader>s"] = { name = "+search" },
          ["<Leader>u"] = { name = "+ui" },
          ["<Leader>w"] = { name = "+window" },
          ["<Leader>x"] = { name = "+quickfix" },
          ["<Leader><Tab>"] = { name = "+tab" },
        },
      })
    end,
  },
  {
    "gitsigns.nvim",
    opts = { current_line_blame = true },
  },
  { "flit.nvim" },
  ----------------
  -- My plugins --
  ----------------
  -- Add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = { "telescope-fzf-native.nvim" },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function() require("telescope").load_extension("fzf") end,
  },
  -- Diffview/merge tool
  {
    "sindrets/diffview.nvim",
    cond = NOT_VSCODE,
    cmd = { "DiffviewOpen" },
    keys = function()
      -- stylua: ignore
      return Keymap.Collector()
        :map({
          { "@diffview.open", "<Cmd>DiffviewOpen<CR>", "Open diffview" },
          { "@diffview.open_last", "<Cmd>DiffviewOpen HEAD~1<CR>", "Open diffview with last commit" },
          { "@diffview.file_histroy", "<Cmd>DiffviewFileHistory %<CR>", "File histroy" },
        })
        :collect_lazy()
    end,
    opts = function()
      -- stylua: ignore
      local close = { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close diffview" } }
      return {
        keymaps = {
          view = { close },
          file_panel = { close },
          file_history_panel = { close },
        },
      }
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    cond = NOT_VSCODE,
    event = { "BufReadPost", "BufNewFile" },
    cmd = "ColorizerToggle",
    opts = {
      "css",
      "html",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
    },
  },
}
