local Util = require("deltavim.util")

---@return DeltaVim.Keymaps
return function()
  local keymaps = {
    -- enhanced
    { true, "@enhanced.j" },
    { true, "@enhanced.k" },
    { true, "@enhanced.n" },
    { true, "@enhanced.N" },
    { true, "@enhanced.shl" },
    { true, "@enhanced.shr" },
    { true, "@enhanced.esc" },
    -- undo break points
    { ".", "@util.undo_break_point" },
    { ",", "@util.undo_break_point" },
    { ";", "@util.undo_break_point" },
    { ":", "@util.undo_break_point" },
    { "，", "@util.undo_break_point" },
    { "。", "@util.undo_break_point" },
    { "；", "@util.undo_break_point" },
    { "：", "@util.undo_break_point" },
    { "=", "@util.undo_break_point" },
    -- surround
    { "yz", "@surround.add" },
    { "dz", "@surround.delete" },
    { "cz", "@surround.replace" },
    -- comment
    { "gc", "@comment.toggle" },
    { "gcc", "@comment.toggle_line" },
    { "gc", "@textobject.comment" },
    -- leap/flit
    { "s", "@leap.forward_to" },
    { "S", "@leap.backward_to" },
    { "gs", "@leap.from_window" },
    -- util
    { "gw", "@util.search_this" },
  }
  if NOT_VSCODE then
    local nixt = { "n", "i", "x", "t" }
    Util.concat(keymaps, {
      -- window
      { "<C-h>", "@smart_splits.move_left", mode = nixt },
      { "<C-j>", "@smart_splits.move_down", mode = nixt },
      { "<C-k>", "@smart_splits.move_up", mode = nixt },
      { "<C-l>", "@smart_splits.move_right", mode = nixt },
      { "<C-S-h>", "@smart_splits.resize_left", mode = nixt },
      { "<C-S-j>", "@smart_splits.resize_down", mode = nixt },
      { "<C-S-k>", "@smart_splits.resize_up", mode = nixt },
      { "<C-S-l>", "@smart_splits.resize_right", mode = nixt },
      { "<Leader>-", "@window.split" },
      { "<Leader>\\", "@window.vsplit" },
      { "<Leader>W", "@window.close" },
      -- ui
      { "<Leader>ua", "@ui.alpha" },
      { "<Leader>uc", "@toggle.conceallevel" },
      { "<Leader>ud", "@toggle.diagnostics" },
      { "<Leader>uf", "@toggle.autoformat" },
      { "<Leader>ug", "@toggle.blame_line" },
      { "<Leader>ul", "@ui.lazy" },
      { "<Leader>um", "@ui.mason" },
      { "<Leader>un", "@toggle.line_number" },
      { "<Leader>ur", "@ui.refresh" },
      { "<Leader>us", "@toggle.spell" },
      { "<Leader>uu", "@search.colorschemes" },
      { "<Leader>uU", "@search.highlights" },
      { "<Leader>uw", "@toggle.wrap" },
      -- tab
      { "<Leader><Tab>h", "@tab.prev" },
      { "<Leader><Tab>l", "@tab.next" },
      { "<Leader><Tab>n", "@tab.new" },
      { "<Leader><Tab>q", "@tab.close" },
      { "<Leader><Tab><Tab>", "@tab.new" },
      -- cmp/snippet
      { "<Tab>", "@snippet.next_node" },
      { "<S-Tab>", "@snippet.prev_node" },
      { "<Down>", "@cmp.next_item" },
      { "<Up>", "@cmp.prev_item" },
      { "<CR>", "@cmp.confirm" },
      { "<S-CR>", "@cmp.confirm_replace" },
      { "<C-e>", "@cmp.abort" },
      { "<C-n>", "@cmp.next_item" },
      { "<C-p>", "@cmp.prev_item" },
      { "<C-d>", "@cmp.scroll_down" },
      { "<C-u>", "@cmp.scroll_up" },
      { "<C-y>", "@cmp.confirm" },
      { "<C-Space>", "@cmp.complete" },
      -- file/find
      { "<C-t>", "@terminal.open" },
      { "<C-t>", "@terminal.hide" },
      { "<Leader>e", "@explorer.focus_cwd" },
      { "<Leader>E", "@explorer.focus" },
      { "<Leader>fe", "@explorer.focus_cwd" },
      { "<Leader>fE", "@explorer.focus" },
      { "<Leader>ff", "@search.autofiles_cwd" },
      { "<Leader>fF", "@search.autofiles" },
      { "<Leader>fn", "@util.new_file" },
      { "<Leader>fo", "@search.oldfiles" },
      { "<Leader>fO", "@search.oldfiles" },
      { "<Leader>ft", "@terminal.select" },
      { "<Leader>fT", "@terminal.open_cwd" },
      -- search
      { "<Leader>,", "@search.buffers_all" },
      { "<Leader>:", "@search.command_history" },
      { "<Leader>sa", "@search.autocommands" },
      { "<Leader>sc", "@search.command_history" },
      { "<Leader>sC", "@search.commands" },
      { "<Leader>sd", "@search.words_cwd" },
      { "<Leader>sD", "@search.words" },
      { "<Leader>se", "@search.document_errors" },
      { "<Leader>sE", "@search.workspace_errors" },
      { "<Leader>sf", "@search.current_buffer" },
      { "<Leader>sg", "@search.grep_cwd" },
      { "<Leader>sG", "@search.grep" },
      { "<Leader>sh", "@search.help_tags" },
      { "<Leader>sH", "@search.man_pages" },
      { "<Leader>sk", "@search.keymaps" },
      { "<Leader>sm", "@search.marks" },
      { "<Leader>sn", "@search.notifications" },
      { "<Leader>sr", "@search.replace" },
      { "<Leader>so", "@search.options" },
      { "<Leader>sp", "@search.projects" },
      { "<Leader>sR", "@search.resume" },
      { "<Leader>ss", "@search.document_symbols" },
      { "<Leader>sS", "@search.workspace_symbols" },
      { "<Leader>st", "@search.todo" },
      { "<Leader>sT", "@search.todo_fixme" },
      { "<Leader>sw", "@search.document_warnings" },
      { "<Leader>sW", "@search.workspace_warnings" },
      { "<Leader>sx", "@search.document_diagnostics" },
      { "<Leader>sX", "@search.workspace_diagnostics" },
      { "<Leader><Leader>", "@search.autofiles" },
      -- git
      { "[g", "@goto.prev_hunk" },
      { "]g", "@goto.next_hunk" },
      { "ig", "@textobject.hunk" },
      { "<Leader>gb", "@git.blame_line" },
      { "<Leader>gB", "@git.blame_line_full" },
      { "<Leader>gc", "@search.git_commits" },
      { "<Leader>gC", "@search.git_status" },
      { "<Leader>gd", "@diffview.open" },
      { "<Leader>gD", "@diffview.open_last" },
      { "<Leader>gh", "@diffview.file_history" },
      { "<Leader>gp", "@git.preview_hunk" },
      { "<Leader>gR", "@git.reset_buffer" },
      { "<Leader>gr", "@git.reset_hunk" },
      { "<Leader>gs", "@git.stage_hunk" },
      { "<Leader>gS", "@git.stage_buffer" },
      { "<Leader>gu", "@git.undo_stage_hunk" },
      -- quickfix
      { "[t", "@goto.prev_todo" },
      { "]t", "@goto.next_todo" },
      { "[x", "@goto.prev_quickfix" },
      { "]x", "@goto.next_quickfix" },
      { "<Leader>xe", "@quickfix.document_errors" },
      { "<Leader>xE", "@quickfix.workspace_errors" },
      { "<Leader>xl", "@quickfix.location_list" },
      { "<Leader>xq", "@quickfix.quickfix_list" },
      { "<Leader>xt", "@quickfix.todo" },
      { "<Leader>xT", "@quickfix.todo_fixme" },
      { "<Leader>xw", "@quickfix.document_warnings" },
      { "<Leader>xW", "@quickfix.workspace_warnings" },
      { "<Leader>xx", "@quickfix.document_diagnostics" },
      { "<Leader>xX", "@quickfix.workspace_diagnostics" },
      -- lsp
      { "[d", "@goto.prev_diagnostic" },
      { "]d", "@goto.next_diagnostic" },
      { "[e", "@goto.prev_error" },
      { "]e", "@goto.next_error" },
      { "[w", "@goto.prev_warning" },
      { "]w", "@goto.next_warning" },
      { "gd", "@search.definitions" },
      { "gD", "@lsp.declaration" },
      { "gI", "@search.implementations" },
      { "gk", "@lsp.signature_help" },
      { "gr", "@search.references" },
      { "gy", "@search.type_definitions" },
      { "gx", "@lsp.line_diagnostics" },
      { "K", "@lsp.hover" },
      { "<Leader>la", "@lsp.code_action" },
      { "<Leader>lA", "@lsp.code_action_source" },
      { "<Leader>lf", "@lsp.format" },
      { "<Leader>li", "@ui.lsp_info" },
      { "<Leader>lI", "@ui.nullls_info" },
      { "<Leader>lr", "@lsp.rename" },
      { "<Leader>ls", "@lsp.symbols_outline" },
      -- lang
      { "<Leader>lle", "@rust.expand_macro" },
      { "<Leader>llo", "@rust.open_cargo" },
      { "<Leader>llr", "@rust.reload_workspace" },
      -- iron
      { "<Leader>ic", "@iron.interrupt" },
      { "<Leader>id", "@iron.clear" },
      { "<Leader>if", "@iron.send_file" },
      { "<Leader>io", "@iron.repl" },
      { "<Leader>il", "@iron.send_line" },
      { "<Leader>iq", "@iron.exit" },
      { "<Leader>ii", "@iron.send_motion" },
      { "<Leader>ii", "@iron.visual_send" },
      { "<Leader>i<CR>", "@iron.cr" },
      -- treesitter
      { "<C-Space>", "@treesitter.increment_selection" },
      { "<BS>", "@treesitter.decrement_selection" },
      -- notify
      { "<S-Enter>", "@notify.redirect" },
      { "<Leader>na", "@notify.all" },
      { "<Leader>nd", "@notify.dismiss" },
      { "<Leader>nh", "@notify.history" },
      { "<Leader>nl", "@notify.last" },
      -- buffer
      { "<S-h>", "@buffer.prev" },
      { "<S-l>", "@buffer.next" },
      { "<C-,>", "@buffer.prev" },
      { "<C-.>", "@buffer.next" },
      { "<Leader>`", "@buffer.switch_back" },
      { "<Leader>w", "@buffer.close" },
      { "<Leader>bb", "@buffer.switch_back" },
      { "<Leader>bh", "@buffer.close_left" },
      { "<Leader>bl", "@buffer.close_right" },
      { "<Leader>bo", "@buffer.close_others" },
      { "<Leader>bP", "@buffer.close_ungrouped" },
      { "<Leader>bp", "@buffer.toggle_pin" },
      { "<Leader>bq", "@buffer.close" },
      { "<Leader>bQ", "@buffer.close_force" },
      -- session
      { "<Leader>ql", "@session.restore" },
      { "<Leader>qL", "@session.restore_last" },
      { "<Leader>qq", "@session.quit" },
      { "<Leader>qQ", "@session.quit_silently" },
      { "<Leader>qs", "@session.stop" },
      -- goto references
      { "[[", "@goto.prev_reference" },
      { "]]", "@goto.next_reference" },
      -- util
      { "jj", "@util.escape_insert" },
      { "jk", "@util.escape_insert" },
      { "<C-s>", "@util.save" },
      { "<Esc><Esc>", "@util.escape_terminal" },
    })
  else
    local vs = function(cmd, ...)
      local args = { ... }
      return function()
        vim.fn.VSCodeNotify(cmd, unpack(args))
      end
    end
    Util.concat(keymaps, {
      -- buffer
      { "<S-h>", vs("workbench.action.previousEditor") },
      { "<S-l>", vs("workbench.action.nextEditor") },
      { "<Leader>d", vs("workbench.action.closeActiveEditor") },
      -- goto references
      { "[[", vs("references-view.prev") },
      { "]]", vs("references-view.next") },
      -- file
      { "<Leader>,", vs("workbench.action.quickOpen") },
      -- lsp
      { "<Leader>la", vs("keyboard-quickfix.openQuickFix") },
    })
  end
  for _, k in ipairs({ "y", "Y", "d", "D", "p", "P" }) do
    -- copy/paste using system clipboard
    table.insert(keymaps, { "<LocalLeader>" .. k, '"+' .. k, mode = { "n", "x" } })
  end
  return keymaps
end
