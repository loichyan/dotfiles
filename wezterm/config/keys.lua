local W = require("wezterm")
local Util = require("config.util")

local function toggle_domain(name)
  return W.action_callback(function(win, pane)
    local domain = W.mux.get_domain(name)
    if domain:state() == "Attached" then
      win:perform_action({ DetachDomain = { DomainName = name } }, pane)
    else
      win:perform_action({ AttachDomain = name }, pane)
    end
  end)
end

local tab_keys = {}
for i = 1, 9 do
  table.insert(tab_keys, {
    key = tostring(i),
    mods = "ALT",
    action = { ActivateTab = i - 1 },
  })
end

local keys = {
  { key = ",", mods = "ALT", action = { ActivateTabRelative = -1 } },
  { key = "-", mods = "ALT", action = { SplitVertical = { domain = "CurrentPaneDomain" } } },
  { key = ".", mods = "ALT", action = { ActivateTabRelative = 1 } },
  { key = "\\", mods = "ALT", action = { SplitHorizontal = { domain = "CurrentPaneDomain" } } },
  { key = "b", mods = "ALT", action = toggle_domain("bg") },
  { key = "f", mods = "ALT", action = { Search = { CaseInSensitiveString = "" } } },
  { key = "i", mods = "ALT", action = { RotatePanes = "CounterClockwise" } },
  { key = "m", mods = "ALT", action = "TogglePaneZoomState" },
  { key = "n", mods = "ALT", action = { SpawnTab = "CurrentPaneDomain" } },
  { key = "o", mods = "ALT", action = { RotatePanes = "Clockwise" } },
  { key = "p", mods = "ALT", action = { PasteFrom = "PrimarySelection" } },
  { key = "u", mods = "ALT", action = "ActivateCopyMode" },
  { key = "w", mods = "ALT", action = { CloseCurrentPane = { confirm = true } } },
  { key = "y", mods = "ALT", action = { CopyTo = "PrimarySelection" } },
  { key = ":", mods = "ALT|SHIFT", action = "ActivateCommandPalette" },
  { key = "w", mods = "ALT|SHIFT", action = { CloseCurrentTab = { confirm = true } } },
  { key = "c", mods = "CTRL|SHIFT", action = { CopyTo = "Clipboard" } },
  { key = "v", mods = "CTRL|SHIFT", action = { PasteFrom = "Clipboard" } },
}

return Util.list_extend(keys, tab_keys, require("config.split_keys"))
