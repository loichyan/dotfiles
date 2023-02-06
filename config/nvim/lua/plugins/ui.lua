local term_opts = {
  on_open = function(term)
    vim.keymap.set({ "n", "t" }, "<C-t>", function()
      term:toggle()
    end, { buffer = term.bufnr, desc = "Toggle terminal" })
  end,
}

---@param cmd? string
local function root(cmd)
  return function()
    return { cmd = cmd, dir = require("lazyvim.util").get_root() }
  end
end

---@param cmd? string
local function cwd(cmd)
  return function()
    return { cmd = cmd, dir = vim.loop.cwd() }
  end
end

---@param opts_fn fun():table
local function create_term(opts_fn)
  return function()
    local Terminal = require("toggleterm.terminal").Terminal
    local term =
      Terminal:new(vim.tbl_extend("force", opts_fn(), term_opts, { count = vim.v.count }))
    term:toggle()
  end
end

---@param opts_fn fun():table
local function toggle_term(opts_fn)
  return function()
    require("toggleterm").toggle(vim.v.count, nil, opts_fn().dir)
  end
end

---@param action string
local function smart_splits(action)
  return function()
    require("smart-splits")[action]()
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
    "bufferline.nvim",
    keys = {
      { "<leader>bh", "<cmd>BufferLineCloseLeft<cr>", desc = "Close Left Buffers" },
      { "<leader>bl", "<cmd>BufferLineCloseRight<cr>", desc = "Close Right Buffers" },
    },
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
  { "mini.indentscope", enabled = false },
  ----------------
  -- My plugins --
  ----------------
  {
    "akinsho/toggleterm.nvim",
    cond = NOT_VSCODE,
    keys = {
      -- Toggle terminals
      { "<C-t>", toggle_term(root()), desc = "Open terminal (root)" },
      { "<leader>ft", toggle_term(root()), desc = "Terminal (root)" },
      { "<leader>fT", toggle_term(cwd()), desc = "Terminal (cwd)" },
      -- LaztGit
      { "<leader>gg", create_term(root("lazygit")), desc = "Lazygit (root)" },
      { "<leader>gG", create_term(cwd("lazygit")), desc = "Lazygit (cwd)" },
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
      -- Move among windows
      { "<C-k>", smart_splits("move_cursor_up"), desc = "Move Cursor up" },
      { "<C-j>", smart_splits("move_cursor_down"), desc = "Move Cursor down" },
      { "<C-h>", smart_splits("move_cursor_left"), desc = "Move Cursor left" },
      { "<C-l>", smart_splits("move_cursor_right"), desc = "Move Cursor right" },
      -- Resize window
      { "<C-Up>", smart_splits("resize_up"), desc = "Resize Window up" },
      { "<C-Down>", smart_splits("resize_down"), desc = "Resize Window down" },
      { "<C-Left>", smart_splits("resize_left"), desc = "Resize Window left" },
      { "<C-Right>", smart_splits("resize_right"), desc = "Resize Window right" },
    },
    opts = {},
    config = function(_, opts)
      require("smart-splits").setup(opts)
    end,
  },
}
