local W = require("wezterm")
local Util = require("config.util")

local accept_pattern = {
  Multiple = {
    { CopyMode = "ClearSelectionMode" },
    { CopyMode = "AcceptPattern" },
  },
}
local clear_pattern = {
  Multiple = {
    { CopyMode = "ClearPattern" },
    { CopyMode = "ClearSelectionMode" },
    { CopyMode = "AcceptPattern" },
  },
}

local key_tables = W.gui.default_key_tables()
Util.list_extend(key_tables.copy_mode, {
  { key = "/", action = { Search = { CaseInSensitiveString = "" } } },
  { key = "n", action = { CopyMode = "NextMatch" } },
  { key = "n", mods = "SHIFT", action = { CopyMode = "PriorMatch" } },
  { key = "c", mods = "CTRL", action = clear_pattern },
  {
    key = "y",
    action = {
      Multiple = {
        { CopyTo = "PrimarySelection" },
        { CopyMode = "Close" },
      },
    },
  },
})
Util.list_extend(key_tables.search_mode, {
  { key = "Enter", action = accept_pattern },
  { key = "c", mods = "CTRL", action = clear_pattern },
})

return key_tables
