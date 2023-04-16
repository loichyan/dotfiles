local smart_splits = require("smart_splits")
local W = require("wezterm")
local Act = W.action

return {
  color_scheme = "Catppuccin Macchiato",
  font = W.font({ family = "monospace" }),
  font_size = 11.0,
  line_height = 1.15,
  window_decorations = "TITLE",
  hide_tab_bar_if_only_one_tab = true,
  window_padding = {
    left = "0.5cell",
    right = "0.5cell",
    top = "0.5cell",
    bottom = "0.5cell",
  },
  inactive_pane_hsb = {
    saturation = 0.9,
    brightness = 0.8,
  },
  visual_bell = {
    fade_in_duration_ms = 75,
    fade_out_duration_ms = 75,
    target = "CursorColor",
  },
  leader = { key = "b", mods = "CTRL" },
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
      key = "x",
      mods = "CTRL|SHIFT",
      action = Act.CloseCurrentPane({ confirm = true }),
    },
    {
      key = "w",
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
