local function open_and_quit(state)
  local node = state.tree:get_node()
  state.commands["open_drop"](state)
  if not require("neo-tree.utils").is_expandable(node) then
    state.commands["close_window"](state)
  end
end

local function root()
  return require("lazyvim.util").get_root()
end

local function cwd()
  return vim.loop.cwd()
end

---@param dir_fn fun():string
local function focus(dir_fn)
  return function()
    require("neo-tree.command").execute({ focus = true, dir = dir_fn() })
  end
end

---@param action string
local function illuminate(action)
  return function()
    require("illuminate")[action]()
  end
end

return {
  {
    "neo-tree.nvim",
    keys = {
      -- Toggle or focus explorer
      { "<leader>fe", focus(root), desc = "Explorer NeoTree (root)" },
      { "<leader>fE", focus(cwd), desc = "Explorer NeoTree (cwd)" },
      { "<leader>e", focus(root), desc = "Explorer NeoTree (root)" },
      { "<leader>E", focus(cwd), desc = "Explorer NeoTree (cwd)" },
    },
    opts = {
      window = {
        mappings = { ["<cr>"] = open_and_quit },
      },
    },
  },
  {
    "vim-illuminate",
    -- Enable wrap
    keys = {
      { "]]", illuminate("goto_next_reference"), desc = "Next Reference" },
      { "[[", illuminate("goto_prev_reference"), desc = "Prev Reference" },
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
