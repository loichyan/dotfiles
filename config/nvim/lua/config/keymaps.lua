---@return DeltaVim.Keymaps
return function()
  -- TODO: remap some keys in VSCode
  return {
    -- enhanced
    { true, "@enhanced.j" },
    { true, "@enhanced.k" },
    { true, "@enhanced.n" },
    { true, "@enhanced.N" },
    { true, "@enhanced.shl" },
    { true, "@enhanced.shr" },
    { true, "@enhanced.esc" },
    -- window
    { "<C-h>", "@smart_splits.move_left" },
    { "<C-j>", "@smart_splits.move_down" },
    { "<C-k>", "@smart_splits.move_up" },
    { "<C-l>", "@smart_splits.move_right" },
    { "<C-Up>", "@smart_splits.resize_up" },
    { "<C-Down>", "@smart_splits.resize_down" },
    { "<C-Left>", "@smart_splits.resize_left" },
    { "<C-Right>", "@smart_splits.resize_right" },
    { "<Leader>-", "@window.split" },
    { "<Leader>|", "@window.vsplit" },
    { "<Leader>w-", "@window.split" },
    { "<Leader>w|", "@window.vsplit" },
    { "<Leader>wq", "@window.close" },
    { "<Leader>ww", "@window.switch_back" },
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
    { "<C-Space>", "@cmp.complete" },
    -- surround
    { "gza", "@surround.add" },
    { "gzd", "@surround.delete" },
    { "gzf", "@surround.find" },
    { "gzF", "@surround.find_left" },
    { "gzh", "@surround.highlight" },
    { "gzn", "@surround.update_n_lines" },
    { "gzr", "@surround.replace" },
    -- comment
    { "gc", "@comment.toggle" },
    { "gcc", "@comment.toggle_line" },
    { "gc", "@select.comment" },
    -- file/find
    { "<C-t>", "@terminal.open" },
    { "<C-t>", "@terminal.hide" },
    { "<Leader>e", "@explorer.focus" },
    { "<Leader>E", "@explorer.focus_cwd" },
    { "<Leader>fe", "@explorer.focus" },
    { "<Leader>fE", "@explorer.focus_cwd" },
    { "<Leader>ff", "@search.files" },
    { "<Leader>fF", "@search.files_cwd" },
    { "<Leader>fn", "@util.new_file" },
    { "<Leader>fo", "@search.oldfiles" },
    { "<Leader>ft", "@terminal.open" },
    { "<Leader>fT", "@terminal.open_cwd" },
    { "<Leader><Leader>", "@search.files" },
    -- search
    { "<Leader>,", "@search.buffers_all" },
    { "<Leader>:", "@search.command_history" },
    { "<Leader>sa", "@search.autocommands" },
    { "<Leader>sc", "@search.command_history" },
    { "<Leader>sC", "@search.commands" },
    { "<Leader>sf", "@search.current_buffer" },
    { "<Leader>sg", "@search.grep" },
    { "<Leader>sG", "@search.grep_cwd" },
    { "<Leader>sh", "@search.help_tags" },
    { "<Leader>sH", "@search.man_pages" },
    { "<Leader>sk", "@search.keymaps" },
    { "<Leader>sm", "@search.marks" },
    { "<Leader>sn", "@search.notifications" },
    { "<Leader>sr", "@search.replace" },
    { "<Leader>so", "@search.options" },
    { "<Leader>sp", "@search.projects" },
    { "<Leader>sR", "@search.resume" },
    { "<Leader>ss", "@search.lsp_document_symbols" },
    { "<Leader>sS", "@search.lsp_workspace_symbols" },
    { "<Leader>st", "@search.todo" },
    { "<Leader>sT", "@search.todo_fixme" },
    { "<Leader>sw", "@search.words" },
    { "<Leader>sW", "@search.words_cwd" },
    { "<Leader>sx", "@search.lsp_document_diagnostics" },
    { "<Leader>sX", "@search.lsp_workspace_diagnostics" },
    -- git
    { "[g", "@goto.prev_hunk" },
    { "]g", "@goto.next_hunk" },
    { "ig", "@select.hunk" },
    { "<Leader>gb", "@git.blame_line" },
    { "<Leader>gB", "@git.blame_line_full" },
    { "<Leader>gc", "@search.git_commits" },
    { "<Leader>gC", "@search.git_status" },
    { "<Leader>gd", "@diffview.open" },
    { "<Leader>gg", "@terminal.lazygit" },
    { "<Leader>gG", "@terminal.lazygit_cwd" },
    { "<Leader>gh", "@diffview.file_histroy" },
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
    { "<Leader>xl", "@quickfix.location_list" },
    { "<Leader>xq", "@quickfix.quickfix_list" },
    { "<Leader>xt", "@quickfix.todo" },
    { "<Leader>xT", "@quickfix.todo_fixme" },
    { "<Leader>xx", "@quickfix.document_diagnostics" },
    { "<Leader>xX", "@quickfix.workspace_diagnostics" },
    -- lsp
    { "[d", "@goto.prev_diagnostic" },
    { "]d", "@goto.next_diagnostic" },
    { "[e", "@goto.prev_error" },
    { "]e", "@goto.next_error" },
    { "[w", "@goto.prev_warning" },
    { "]w", "@goto.next_warning" },
    { "gd", "@search.lsp_definitions" },
    { "gD", "@lsp.declaration" },
    { "gI", "@search.lsp_implementations" },
    { "gk", "@lsp.signature_help" },
    { "gr", "@search.lsp_references" },
    { "gt", "@search.lsp_type_definitions" },
    { "gx", "@lsp.line_diagnostics" },
    { "K", "@lsp.hover" },
    { "<C-k>", "@lsp.code_action" },
    { "<Leader>la", "@lsp.code_action" },
    { "<Leader>lf", "@lsp.format" },
    { "<Leader>li", "@ui.lsp_info" },
    { "<Leader>lI", "@ui.nullls_info" },
    { "<Leader>lr", "@lsp.rename:inc_rename" },
    -- treesitter
    { "<C-Space>", "@treesitter.increase_selection" },
    { "<BS>", "@treesitter.decrease_selection" },
    -- notify
    { "<S-Enter>", "@notify.redirect" },
    { "<Leader>na", "@notify.all" },
    { "<Leader>nh", "@notify.history" },
    { "<Leader>nl", "@notify.last" },
    { "<Leader>uc", "@notify.clear" },
    -- buffer
    { "<S-h>", "@buffer.prev" },
    { "<S-l>", "@buffer.next" },
    { "<Leader>`", "@buffer.switch_back" },
    { "<Leader>d", "@buffer.close" },
    { "<Leader>D", "@buffer.close_force" },
    { "<Leader>bb", "@buffer.switch_back" },
    { "<Leader>bh", "@buffer.close_left" },
    { "<Leader>bl", "@buffer.close_right" },
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
    -- leap/flit
    { "s", "@leap.forward_to" },
    { "S", "@leap.backward_to" },
    { "gs", "@leap.from_window" },
    -- goto references
    { "[[", "@goto.prev_reference" },
    { "]]", "@goto.next_reference" },
    -- util
    { "gw", "@util.search_this" },
    { "jj", "@util.escape_insert" },
    { "jk", "@util.escape_insert" },
    { "<A-k>", "@util.move_line_up" },
    { "<A-j>", "@util.move_line_down" },
    { "<C-s>", "@util.save" },
    { "<Esc><Esc>", "@util.escape_terminal" },
    -- undo break points
    { ".", "@util.undo_break_point" },
    { ",", "@util.undo_break_point" },
    { ";", "@util.undo_break_point" },
    -- copy/paste using system clipboard
    { "<Leader>y", '"+y', mode = { "n", "x" } },
    { "<Leader>Y", '"+Y', mode = { "n", "x" } },
    { "<Leader>p", '"+p', mode = { "n", "x" } },
    { "<Leader>P", '"+P', mode = { "n", "x" } },
  }
end
