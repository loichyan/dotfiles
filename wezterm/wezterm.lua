local W = require("wezterm")
local SplitKeys = require("split_keys")
local Act = W.action
local Mux = W.mux

local function toggle_domain(name)
  return W.action_callback(function(win, pane)
    local domain = Mux.get_domain(name)
    if domain:state() == "Attached" then
      win:perform_action(Act.DetachDomain({ DomainName = name }), pane)
    else
      win:perform_action(Act.AttachDomain(name), pane)
    end
  end)
end

local key_tables = W.gui.default_key_tables()
local accept_pattern = Act.Multiple({
  Act.CopyMode("ClearSelectionMode"),
  Act.CopyMode("AcceptPattern"),
})
local clear_pattern = Act.Multiple({
  Act.CopyMode("ClearPattern"),
  Act.CopyMode("ClearSelectionMode"),
  Act.CopyMode("AcceptPattern"),
})
local my_key_tables = {
  copy_mode = {
    { key = "/", action = Act.Search({ CaseInSensitiveString = "" }) },
    { key = "n", action = Act.CopyMode("NextMatch") },
    { key = "n", mods = "SHIFT", action = Act.CopyMode("PriorMatch") },
    { key = "c", mods = "CTRL", action = clear_pattern },
  },
  search_mode = {
    { key = "Enter", action = accept_pattern },
    { key = "c", mods = "CTRL", action = clear_pattern },
  },
}
for k, list in pairs(my_key_tables) do
  for _, kb in ipairs(list) do
    table.insert(key_tables[k], kb)
  end
end

return {
  -- Multiplexer
  unix_domains = {
    { name = "bg" },
  },
  -- IME
  use_ime = true,
  ime_preedit_rendering = "Builtin",
  -- Colorscheme & font
  color_scheme = require("colorscheme"),
  font = W.font_with_fallback({
    { family = "monospace" },
    { family = "Noto Sans CJK SC" },
  }),
  font_size = 11.0,
  line_height = 1.1,
  -- Cursor style
  cursor_blink_rate = 500,
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  hide_mouse_cursor_when_typing = false,
  -- Title & tab bar
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  window_background_opacity = 0.90,
  use_fancy_tab_bar = false,
  tab_max_width = 25,
  show_tab_index_in_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  -- Window & pane style
  window_padding = {
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
  },
  -- Performance
  front_end = "WebGpu",
  -- Keybindings
  disable_default_key_bindings = true,
  mouse_bindings = {
    { event = { Up = { streak = 1, button = "Left" } }, action = Act.Nop },
  },
  keys = {
    { key = "_", mods = "CTRL|SHIFT", action = Act.SplitVertical({ domain = "CurrentPaneDomain" }) },
    { key = "b", mods = "CTRL|SHIFT", action = toggle_domain("bg") },
    { key = "c", mods = "CTRL|SHIFT", action = Act.CopyTo("Clipboard") },
    { key = "d", mods = "CTRL|SHIFT", action = Act.CloseCurrentPane({ confirm = true }) },
    { key = "f", mods = "CTRL|SHIFT", action = Act.Search({ CaseInSensitiveString = "" }) },
    { key = "i", mods = "CTRL|SHIFT", action = Act.RotatePanes("CounterClockwise") },
    { key = "m", mods = "CTRL|SHIFT", action = Act.TogglePaneZoomState },
    { key = "n", mods = "CTRL|SHIFT", action = Act.SpawnTab("CurrentPaneDomain") },
    { key = "o", mods = "CTRL|SHIFT", action = Act.RotatePanes("Clockwise") },
    { key = "p", mods = "CTRL|SHIFT", action = Act.ActivateCommandPalette },
    { key = "v", mods = "CTRL|SHIFT", action = Act.PasteFrom("Clipboard") },
    { key = "w", mods = "CTRL|SHIFT", action = Act.CloseCurrentTab({ confirm = true }) },
    { key = "y", mods = "CTRL|SHIFT", action = Act.ActivateCopyMode },
    { key = "|", mods = "CTRL|SHIFT", action = Act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "h", mods = "ALT", action = Act.ActivateTabRelative(-1) },
    { key = "l", mods = "ALT", action = Act.ActivateTabRelative(1) },
    { key = "c", mods = "ALT", action = Act.CopyTo("PrimarySelection") },
    { key = "v", mods = "ALT", action = Act.PasteFrom("PrimarySelection") },
    table.unpack(SplitKeys),
  },
  key_tables = key_tables,
}
