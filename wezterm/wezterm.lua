local smart_splits = require("smart_splits")
local W = require("wezterm")
local Act = W.action

---@param action "move"|"resize"
---@param dir string
local function pane_splits(action, dir)
  if action == "move" then
    return {
      key = dir .. "Arrow",
      mods = "CTRL",
      action = Act.ActivatePaneDirection(dir),
    }
  elseif action == "resize" then
    return {
      key = dir .. "Arrow",
      mods = "ALT",
      action = Act.AdjustPaneSize({ dir, 3 }),
    }
  end
end

return {
  -- Colorscheme & font
  color_scheme = "Catppuccin Macchiato",
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
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
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
    smart_splits("move", "h"),
    smart_splits("move", "j"),
    smart_splits("move", "k"),
    smart_splits("move", "l"),
    pane_splits("move", "Left"),
    pane_splits("move", "Down"),
    pane_splits("move", "Up"),
    pane_splits("move", "Right"),
    -- resize panes
    smart_splits("resize", "h"),
    smart_splits("resize", "j"),
    smart_splits("resize", "k"),
    smart_splits("resize", "l"),
    pane_splits("resize", "Left"),
    pane_splits("resize", "Down"),
    pane_splits("resize", "Up"),
    pane_splits("resize", "Right"),
  },
}
