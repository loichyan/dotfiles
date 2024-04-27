local Keymap = require("deltavim.core.keymap")
local H = require("deltavim.helpers")
local Util = require("deltavim.util")

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
    "toggleterm.nvim",
    opts = { direction = "horizontal" },
  },
  {
    "which-key.nvim",
    opts = function(_, opts)
      return Util.merge({}, opts, {
        defaults = {
          mode = { "n", "x" },
          ["["] = { name = "+prev" },
          ["]"] = { name = "+next" },
          ["g"] = { name = "+goto" },
          ["gz"] = { name = "+surround" },
          ["<Leader>b"] = { name = "+buffer" },
          ["<Leader>f"] = { name = "+find" },
          ["<Leader>g"] = { name = "+git" },
          ["<Leader>l"] = { name = "+lsp" },
          ["<Leader>ll"] = { name = "+lang" },
          ["<Leader>n"] = { name = "+notify" },
          ["<Leader>q"] = { name = "+session" },
          ["<Leader>s"] = { name = "+search" },
          ["<Leader>u"] = { name = "+ui" },
          ["<Leader>w"] = { name = "+window" },
          ["<Leader>x"] = { name = "+quickfix" },
          ["<Leader><Tab>"] = { name = "+tab" },
        },
        operators = Keymap.Collector()
          :map({
            { "@iron.send_motion", "Send" },
            { "@iron.mark_motion", "Mark" },
          })
          :collect_lhs_table(),
      })
    end,
  },
  {
    "gitsigns.nvim",
    opts = { current_line_blame = true },
  },
  { "todo-comments.nvim", opts = { highlight = { multiline = true } } },
  ----------------
  -- My plugins --
  ----------------
  -- Telescope plugins
  {
    "telescope.nvim",
    dependencies = {
      "telescope-fzf-native.nvim",
      "telescope-project.nvim",
    },
    opts = {
      extensions = {
        project = {
          base_dirs = { "~/dev" },
        },
      },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    cond = NOT_VSCODE,
    build = "make",
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "nvim-telescope/telescope-project.nvim",
    cond = NOT_VSCODE,
    event = "VeryLazy",
    keys = function()
      -- stylua: ignore
      return Keymap.Collector()
        :map({
          { "@search.projects", H.telescope({ "project", "project" }), "Projects" },
        })
        :collect_lazy()
    end,
    config = function()
      require("telescope").load_extension("project")
    end,
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
          { "@diffview.file_history", "<Cmd>DiffviewFileHistory %<CR>", "File history" },
        })
        :collect_lazy()
    end,
    opts = function()
      local actions = require("diffview.actions")
      local close = { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close diffview" } }
      return {
        keymaps = {
          file_panel = {
            close,
            { "n", "<c-u>", actions.scroll_view(-0.25), { desc = "Scroll the view up" } },
            { "n", "<c-d>", actions.scroll_view(0.25), { desc = "Scroll the view down" } },
          },
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
