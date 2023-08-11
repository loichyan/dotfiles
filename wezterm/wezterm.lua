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

return {
  -- Multiplexer
  unix_domains = {
    { name = "bg" },
  },
  -- Colorscheme & font
  color_scheme = require("colorscheme"),
  font = W.font_with_fallback({
    { family = "monospace" },
    { family = "Sarasa UI SC" },
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
  keys = {
    {
      key = "c",
      mods = "CTRL|SHIFT",
      action = Act.CopyTo("Clipboard"),
    },
    {
      key = "v",
      mods = "CTRL|SHIFT",
      action = Act.PasteFrom("Clipboard"),
    },
    {
      key = "c",
      mods = "ALT",
      action = Act.CopyTo("PrimarySelection"),
    },
    {
      key = "v",
      mods = "ALT",
      action = Act.PasteFrom("PrimarySelection"),
    },
    {
      key = "m",
      mods = "CTRL|SHIFT",
      action = Act.TogglePaneZoomState,
    },
    {
      key = "n",
      mods = "CTRL|SHIFT",
      action = Act.SpawnTab("CurrentPaneDomain"),
    },
    {
      key = "|",
      mods = "CTRL|SHIFT",
      action = Act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "_",
      mods = "CTRL|SHIFT",
      action = Act.SplitVertical({ domain = "CurrentPaneDomain" }),
    },
    {
      key = "o",
      mods = "CTRL|SHIFT",
      action = Act.RotatePanes("Clockwise"),
    },
    {
      key = "i",
      mods = "CTRL|SHIFT",
      action = Act.RotatePanes("CounterClockwise"),
    },
    {
      key = "<",
      mods = "CTRL|SHIFT",
      action = Act.ActivateTabRelative(-1),
    },
    {
      key = ">",
      mods = "CTRL|SHIFT",
      action = Act.ActivateTabRelative(1),
    },
    {
      key = "d",
      mods = "CTRL|SHIFT",
      action = Act.CloseCurrentPane({ confirm = true }),
    },
    {
      key = "w",
      mods = "CTRL|SHIFT",
      action = Act.CloseCurrentTab({ confirm = true }),
    },
    {
      key = "y",
      mods = "CTRL|SHIFT",
      action = Act.ActivateCopyMode,
    },
    {
      key = "b",
      mods = "CTRL|SHIFT",
      action = toggle_domain("bg"),
    },
    {
      key = "p",
      mods = "CTRL|SHIFT",
      action = Act.ActivateCommandPalette,
    },
    table.unpack(SplitKeys),
  },
}
