local smart_splits = require("smart_splits")
local W = require("wezterm")
local Act = W.action

return {
  -- Colorscheme & font
  color_scheme = "Catppuccin Macchiato",
  term = "wezterm",
  font = W.font({ family = "monospace" }),
  font_size = 11.0,
  line_height = 1.15,
  -- Cursor style
  default_cursor_style = "BlinkingUnderline",
  cursor_blink_rate = 450,
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  -- Title & tab bar
  window_decorations = "INTEGRATED_BUTTONS|RESIZE",
  use_fancy_tab_bar = false,
  tab_max_width = 25,
  show_tab_index_in_tab_bar = false,
  hide_tab_bar_if_only_one_tab = true,
  -- Window & pane style
  window_padding = {
    left = "0.5cell",
    right = "0.5cell",
    top = "0.5cell",
    bottom = "0.5cell",
  },
  -- Keybindings
  keys = {
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
      key = "O",
      mods = "CTRL|SHIFT",
      action = Act.RotatePanes("Clockwise"),
    },
    {
      key = "I",
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
      key = "X",
      mods = "CTRL|SHIFT",
      action = Act.CloseCurrentPane({ confirm = true }),
    },
    {
      key = "H",
      mods = "CTRL|SHIFT",
      action = Act.ActivateCopyMode,
    },
    {
      key = "W",
      mods = "CTRL|SHIFT",
      action = Act.CloseCurrentTab({ confirm = true }),
    },
    -- move between split panes
    smart_splits("move", "CTRL", "h"),
    smart_splits("move", "CTRL", "j"),
    smart_splits("move", "CTRL", "k"),
    smart_splits("move", "CTRL", "l"),
    -- resize panes
    smart_splits("resize", "ALT", "h"),
    smart_splits("resize", "ALT", "j"),
    smart_splits("resize", "ALT", "k"),
    smart_splits("resize", "ALT", "l"),
  },
}
