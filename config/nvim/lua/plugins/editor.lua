local function open_and_quit(state)
  local node = state.tree:get_node()
  state.commands["open_drop"](state)
  if not require("neo-tree.utils").is_expandable(node) then
    state.commands["close_window"](state)
  end
end

local function neo_tree_focus(dir)
  require("neo-tree.command").execute({ focus = true, dir = dir })
end

return {
  {
    "neo-tree.nvim",
    keys = {

      {
        "<leader>fe",
        function()
          neo_tree_focus(vim.loop.cwd())
        end,
        desc = "Explorer NeoTree (cwd)",
      },
      {
        "<leader>fE",
        function()
          neo_tree_focus(require("lazyvim.util").get_root())
        end,
        desc = "Explorer NeoTree (root)",
      },
      { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (cwd)", remap = true },
      { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (root)", remap = true },
    },
    opts = {
      -- Add neo-tree mappings
      window = {
        mappings = {
          ["<cr>"] = open_and_quit,
          ["o"] = "open_drop",
        },
      },
    },
  },
  {
    "vim-illuminate",
    -- Enable wrap
    keys = {
      {
        "]]",
        function()
          require("illuminate").goto_next_reference(true)
        end,
        desc = "Next Reference",
      },
      {
        "[[",
        function()
          require("illuminate").goto_prev_reference(true)
        end,
        desc = "Prev Reference",
      },
    },
  },
  ----------------
  -- My plugins --
  ----------------
  -- Add telescope-fzf-native
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
}
