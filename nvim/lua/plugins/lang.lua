-- Language specified plugins
local Keymap = require("deltavim.core.keymap")

return {
  -- Json
  {
    "b0o/schemastore.nvim",
    cond = NOT_VSCODE,
    lazy = true,
  },
  -- Rust
  {
    "simrat39/rust-tools.nvim",
    cond = NOT_VSCODE,
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      tools = { inlay_hints = { auto = true, highlight = "LspInlayHint" } },
      server = require("custom.lsp").rust_analyzer,
    },
  },
  {
    "Saecki/crates.nvim",
    cond = NOT_VSCODE,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      popup = { border = "rounded" },
      null_ls = { enabled = true },
    },
  },
  -- Markdown
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
  },
  -- Repl
  {
    "Vigemus/iron.nvim",
    cond = NOT_VSCODE,
    cmd = { "IronAttach", "IronRepl" },
    keys = function()
      return Keymap.Collector()
        :map({
          { "@iron.repl", "<Cmd>IronRepl<CR>", "Open repl" },
          { "@iron.send_motion", desc = "Send" },
          { "@iron.visual_send", mode = "x", desc = "Send" },
          { "@iron.send_file", desc = "Send file" },
          { "@iron.send_line", desc = "Send line" },
          { "@iron.send_mark", desc = "Send mark" },
          { "@iron.mark_motion", desc = "Mark" },
          { "@iron.mark_visual", mode = "x", desc = "Mark" },
          { "@iron.remove_mark", desc = "Remove mark" },
          { "@iron.cr", desc = "CR" },
          { "@iron.interrupt", desc = "Interrupt" },
          { "@iron.exit", desc = "Exit" },
          { "@iron.clear", desc = "Clear" },
        })
        :collect_lazy()
    end,
    opts = function()
      local keymaps = Keymap.Collector()
        :map_unique({
          { "@iron.send_motion", "send_motion" },
          { "@iron.visual_send", "visual_send" },
          { "@iron.send_file", "send_file" },
          { "@iron.send_line", "send_line" },
          { "@iron.send_mark", "send_mark" },
          { "@iron.mark_motion", "mark_motion" },
          { "@iron.mark_visual", "mark_visual" },
          { "@iron.remove_mark", "remove_mark" },
          { "@iron.cr", "cr" },
          { "@iron.interrupt", "interrupt" },
          { "@iron.exit", "exit" },
          { "@iron.clear", "clear" },
        })
        :collect_rhs_table()
      return {
        config = {
          scratch_repl = true,
          repl_definition = {
            python = {
              command = { "ipython" },
              format = require("iron.fts.common").bracketed_paste,
            },
          },
          repl_open_cmd = require("iron.view").split.vertical(0.4, {
            winfixwidth = false,
            winfixheight = false,
          }),
        },
        keymaps = keymaps,
      }
    end,
    config = function(_, opts)
      require("iron.core").setup(opts)
    end,
  },
}
