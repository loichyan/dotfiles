local W = require("wezterm")

local home = assert(os.getenv("HOME"))
return {
  term = "wezterm",
  set_environment_variables = {
    -- TODO: maybe unnecessary if NixOS/nixpkgs#307484 is merged?
    TERMINFO_DIRS = home .. "/.nix-profile/share/terminfo:/usr/share/terminfo",
  },
  -- Multiplexer
  --unix_domains = {
  --  { name = "bg" },
  --},
  -- IME
  use_ime = true,
  -- Colorscheme & font
  color_scheme = "Catppuccin Mocha",
  font = W.font_with_fallback({
    { family = "monospace" },
    { family = "Noto Sans CJK SC" },
  }),
  font_size = 11.0,
  line_height = 1,
  --Cursor style
  cursor_blink_rate = 500,
  cursor_blink_ease_in = "Constant",
  cursor_blink_ease_out = "Constant",
  hide_mouse_cursor_when_typing = false,
  -- Title & tab bar
  window_decorations = "RESIZE",
  window_background_opacity = 0.75,
  enable_tab_bar = false,
  use_fancy_tab_bar = false,
  tab_max_width = 25,
  show_tab_index_in_tab_bar = false,
  hide_tab_bar_if_only_one_tab = false,
  switch_to_last_active_tab_when_closing_tab = true,
  -- Window & pane style
  window_padding = {
    left = 3,
    right = 3,
    top = 3,
    bottom = 3,
  },
  inactive_pane_hsb = {
    saturation = 0.75,
    brightness = 0.75,
  },
  -- Rendering
  front_end = "WebGpu",
  --freetype_load_flags = "NO_HINTING",
  -- Keybindings
  disable_default_key_bindings = true,
  mouse_bindings = {
    { event = { Up = { streak = 1, button = "Left" } }, action = "OpenLinkAtMouseCursor" },
  },
  --keys = require("config.keys"),
  --key_tables = require("config.key_tables"),
  default_prog = { "tmux", "new", "-A" },
  enable_csi_u_key_encoding = true,
  keys = {
    { key = "c", mods = "CTRL|SHIFT", action = { CopyTo = "Clipboard" } },
    { key = "v", mods = "CTRL|SHIFT", action = { PasteFrom = "Clipboard" } },
  },
}
