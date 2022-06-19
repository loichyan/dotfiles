function _G.add_snippet(ft, trig, body)
  local ls = require("luasnip")
  ls.add_snippets(
    ft,
    { require("luasnip.util.parser").parse_snippet({ trig = trig }, body) }
  )
end

---@param minv MiNV
---@return any[]
local function custom(minv)
  local utils = require("minv.utils")

  -----------------
  -- Keybindings --
  -----------------

  local keybindings = minv.keybindings

  -- Buffer
  minv.keybindings.n:extend({
    ["<Leader>x"] = { "<Cmd>Bdelete<CR>", "Close buffer" },
  })
  -- Telescope
  minv.keybindings.telescope:extend({
    ["<Leader>f"] = {
      ["p"] = { "<Cmd>Telescope projects<CR>", "Search recent projects" },
      ["P"] = {
        "<Cmd>SessionManager load_session<CR>",
        "Search recent sessions",
      },
      ["t"] = { "<Cmd>TodoTelescope<CR>", "Search TODOs" },
      ["n"] = { "<Cmd>Telescope notify<CR>", "Search notifications" },
    },
  })
  -- Git
  keybindings.gitsigns:extend({
    ["<Leader>g"] = {
      ["d"] = { "<Cmd>DiffviewOpen<CR>", "Open diffview" },
      ["g"] = { "<Cmd>Neogit kind=split<CR>", "Open neogit" },
    },
  })

  ----------
  -- Misc --
  ----------

  vim.env["http_proxy"] = vim.env["MY_HTTP_PROXY"]
  vim.env["HTTP_PROXY"] = vim.env["MY_HTTP_PROXY"]
  vim.env["https_proxy"] = vim.env["MY_HTTP_PROXY"]
  vim.env["HTTPS_PROXy"] = vim.env["MY_HTTP_PROXY"]

  -- Set rulers.
  utils.autocmd("FileType", "rust", "setlocal cc=80")
  -- Extend `q_to_close`.
  vim.list_extend(minv.autocmds.q_to_close, { "notify" })

  -------------
  -- Plugins --
  -------------

  require("custom.plugins").setup(minv)

  ---------------
  -- Cmpletion --
  ---------------

  local cmp = minv.plugins.cmp

  -- Luasnip
  cmp.luasnip = {
    history = false,
    -- Delete leaved snippets
    region_check_events = "InsertEnter",
    delete_check_events = "InsertLeave",
  }

  -- Cmp sources
  cmp.config.sources = vim.list_extend(
    cmp.config.sources,
    { { name = "nvim_lsp_signature_help" } }
  )

  ---------
  -- LSP --
  ---------

  require("custom.lsp").setup(minv)

  ----------------
  -- Treesitter --
  ----------------

  local treesitter = minv.plugins.treesitter

  -- Install all treesitters.
  treesitter.config.ensure_installed = "all"

  -- Disable hightlight in vscode.
  if vim.g.vscode ~= nil then
    treesitter.config.highlight.enable = false
  end

  --------
  -- UI --
  --------
  --
  local ui = minv.plugins.ui

  -- Set font.
  minv.settings.o.guifont = "Fira Code:h10"

  -- Match tmux theme.
  ui.lualine.options.component_separators = { left = "", right = "" }
  ui.lualine.options.section_separators = { left = "", right = "" }

  -- Exclude some folders.
  vim.list_extend(ui.tree.filters.custom, { [[^target$]] })

  -- Integrate nvim-tree with project.nvim
  ui.tree.git.ignore = false

  -- Use bdelete.nvim intead of builtin ones.
  ui.bufferline = vim.tbl_extend("force", ui.bufferline, {
    close_command = "Bdelete! %d",
    right_mouse_command = "Bdelete! %d",
  })

  -- Add dashboard entries.
  table.insert(
    ui.dashboard.buttons,
    2,
    { "s", "  Last Session", [[<Cmd>SessionManager load_last_session<CR>]] }
  )
  table.insert(
    ui.dashboard.buttons,
    4,
    { "p", "  Recent Projects", "<Cmd>Telescope projects<CR>" }
  )
end

require("minv").setup(custom)
