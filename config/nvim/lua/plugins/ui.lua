local term_opts = {
  on_open = function(term2)
    vim.keymap.set({ "n", "t" }, "<C-t>", function()
      term2:toggle()
    end, { buffer = term2.bufnr, desc = "Toggle terminal" })
  end,
}

---@param opts_fn fun():table
local function create_term(opts_fn)
  return function()
    local Terminal = require("toggleterm.terminal").Terminal
    local term =
      Terminal:new(vim.tbl_extend("force", opts_fn(), term_opts, { count = vim.v.count }))
    term:toggle()
  end
end

---@param dir_fn fun():string
local function toggle_term(dir_fn)
  return function()
    require("toggleterm").toggle(vim.v.count, nil, dir_fn())
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
    cond = NOT_VSCODE,
    keys = {
      {
        "<C-t>",
        "<leader>ft",
        desc = "Open terminal (root)",
        remap = true,
      },
      {
        "<leader>ft",
        toggle_term(function()
          return require("lazyvim.util").get_root()
        end),
        desc = "Terminal (root)",
      },
      {
        "<leader>fT",
        toggle_term(function()
          ---@diagnostic disable-next-line:return-type-mismatch
          return vim.loop.cwd()
        end),
        desc = "Terminal (cwd)",
      },
      {
        "<leader>gg",
        create_term(function()
          return { cmd = "lazygit", dir = require("lazyvim.util").get_root() }
        end),
        desc = "Lazygit (root)",
      },
      {
        "<leader>gG",
        create_term(function()
          return { cmd = "lazygit", dir = vim.loop.cwd() }
        end),
        desc = "Lazygit (cwd)",
      },
    },
    opts = function(_, opts)
      return vim.tbl_deep_extend("force", opts, term_opts, {
        direction = "float",
        float_opts = { border = "rounded" },
      })
    end,
    config = function(_, opts)
      require("toggleterm").setup(opts)
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    cond = NOT_VSCODE,
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
