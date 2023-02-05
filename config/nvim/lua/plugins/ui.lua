---@param opts_fn fun():table
local function toggle_term(opts_fn)
  local term
  return function()
    if term == nil then
      local Terminal = require("toggleterm.terminal").Terminal
      term = Terminal:new(vim.tbl_extend("force", opts_fn(), {
        on_open = function(term2)
          vim.keymap.set("t", "<esc><esc>", function()
            term2:toggle()
          end, { buffer = term2.bufnr, desc = "Toggle terminal" })
        end,
      }))
    end
    term:toggle()
  end
end

---@param f string
local function smart_splits(f)
  return function()
    require("smart-splits")[f]()
  end
end

return {
  {
    "nvim-notify",
    opts = function(_, opts)
      require("telescope").load_extension("notify")
      return opts
    end,
  },
  {
    "lualine.nvim",
    opts = {
      options = {
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
      },
    },
  },
  { "mini.indentscope", enabled = false },
  {
    "indent-blankline.nvim",
    opts = {
      char = "▏",
      context_char = "▏",
      use_treesitter = true,
      show_current_context = true,
      show_first_indent_level = false,
      show_trailing_blankline_indent = false,
    },
  },
  ----------------
  -- My plugins --
  ----------------
  {
    "akinsho/toggleterm.nvim",
    enabled = NOT_VSCODE,
    keys = {
      {
        "<leader>ft",
        toggle_term(function()
          return { dir = require("lazyvim.util").get_root() }
        end),
        desc = "Terminal (root)",
      },
      {
        "<leader>fT",
        toggle_term(function()
          return {
            dir = vim.loop.cwd(),
          }
        end),
        desc = "Terminal (cwd)",
      },
      {
        "<leader>gg",
        toggle_term(function()
          return { cmd = "lazygit", dir = require("lazyvim.util").get_root() }
        end),
        desc = "Lazygit (root)",
      },
      {
        "<leader>gG",
        toggle_term(function()
          return { cmd = "lazygit", dir = vim.loop.cwd() }
        end),
        desc = "Lazygit (cwd)",
      },
    },
    opts = {
      direction = "float",
      float_opts = { border = "rounded" },
    },
    config = function(_, opts)
      require("toggleterm").setup(opts)
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    enabled = NOT_VSCODE,
    keys = {
      -- Resize window
      { "<A-j>", smart_splits("resize_down"), desc = "Resize window down" },
      { "<A-k>", smart_splits("resize_up"), desc = "Resize window up" },
      { "<A-h>", smart_splits("resize_left"), desc = "Resize window left" },
      { "<A-l>", smart_splits("resize_right"), desc = "Resize window right" },
      -- Move among windows
      { "<C-j>", smart_splits("move_cursor_down"), desc = "Move cursor down" },
      { "<C-k>", smart_splits("move_cursor_up"), desc = "Move cursor up" },
      { "<C-h>", smart_splits("move_cursor_left"), desc = "Move cursor left" },
      { "<C-l>", smart_splits("move_cursor_right"), desc = "Move cursor right" },
    },
    opts = {},
    config = function(_, opts)
      require("smart-splits").setup(opts)
    end,
  },
}
